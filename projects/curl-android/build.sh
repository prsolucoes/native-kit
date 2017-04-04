#!/bin/bash -e

# validate
if [ -z ${ANDROID_NDK_ROOT+x} ]; then
	echo "Error: You need set ANDROID_NDK_ROOT environment variable"
	exit 1
fi

# create temporary base path
BASE_DIR="tmp"
mkdir -p ${BASE_DIR}
BASE_DIR="`cd "tmp/";pwd`"
cd ${BASE_DIR}

# create vendor dir
VENDOR_DIR="../../../vendor"
mkdir -p ${VENDOR_DIR}
VENDOR_DIR="`cd "../../../vendor/";pwd`"

# common vars
LIBRARY_VERSION="7.53.1"
LIBRARY_TARBALL="curl-${LIBRARY_VERSION}.tar.gz"
LIBRARY_DIR="curl-${LIBRARY_VERSION}"
VENDOR_LIB_DIR="curl-android"

# android environment vars
ANDROID_PLATFORM=android-21
ANDROID_TOOLCHAIN_VERSION="4.9"

ARCHS=(
    x86
    arm64-v8a
    armeabi
    armeabi-v7a
    mips
    mips64
    x86_64
)

TOOLS=(
    x86
    aarch64-linux-android
    arm-linux-androideabi
    arm-linux-androideabi
    mipsel-linux-android
    mips64el-linux-android
    x86_64
)

HOSTS=(
    i686-linux-android
    aarch64-linux-android
    arm-linux-androideabi
    arm-linux-androideabi
    mipsel-linux-android
    mips64el-linux-android
    x86_64-linux-android
)

SYSROOTS=(
    arch-x86
    arch-arm64
    arch-arm
    arch-arm
    arch-mips
    arch-mips64
    arch-x86_64
)

# download library source
if [ ! -e ${LIBRARY_TARBALL} ]; then
	echo "Downloading ${LIBRARY_TARBALL}..."
	curl -# -o ${LIBRARY_TARBALL} -O https://curl.haxx.se/download/${LIBRARY_TARBALL}
fi

# untar the file
if [ ! -e ${LIBRARY_DIR} ]; then
	tar zxf ${LIBRARY_TARBALL}
fi

# create lib for each arch
for (( i=0; i<${#ARCHS[@]}; i++)); do

	# android environment vars for current arch
	tool=${TOOLS[$i]}
    arch=${ARCHS[$i]}
    host=${HOSTS[$i]}
    sysroot=${SYSROOTS[$i]}

	# build dir
	cd ${BASE_DIR}
	LIBRARY_BUILD_DIR="${BASE_DIR}/build"
	mkdir -p ${LIBRARY_BUILD_DIR}

	# build
	echo "Compiling arch: ${arch}"
	cd ${LIBRARY_DIR}

	# verify if the build of current arch exists
	if [ -e ${LIBRARY_BUILD_DIR}/${arch} ]; then
		echo "Build files of arch ${arch} already exists"
		continue
	fi

	# configure android toolchain
	export ANDROID_TOOLCHAIN=""

	for compilerHost in "linux-x86_64" "linux-x86" "darwin-x86_64" "darwin-x86"
	do
		if [ -d "${ANDROID_NDK_ROOT}/toolchains/${tool}-${ANDROID_TOOLCHAIN_VERSION}/prebuilt/${compilerHost}/bin" ]; then
			export ANDROID_TOOLCHAIN="${ANDROID_NDK_ROOT}/toolchains/${tool}-${ANDROID_TOOLCHAIN_VERSION}/prebuilt/${compilerHost}/bin"
			break
		fi
	done

	echo "Building using toolchain: ${ANDROID_TOOLCHAIN}"

	# android environment vars for build
	export ANDROID_ARCH=${sysroot}
    export ANDROID_EABI="${host}-${ANDROID_TOOLCHAIN_VERSION}"
    export ANDROID_API=${ANDROID_PLATFORM}
    export ANDROID_SYSROOT="${ANDROID_NDK_ROOT}/platforms/${ANDROID_PLATFORM}/${sysroot}"
    export ANDROID_DEV="${ANDROID_SYSROOT}/usr"

    export SYSTEM=android
    export ARCH=${arch}

	export CROSS_COMPILE_PREFIX="${host}-"

	export CC="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}gcc"
	export LD="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}ld"
	export CPP="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}cpp"
	export CXX="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}g++"
	export AS="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}as"
	export AR="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}ar"
	export RANLIB="${ANDROID_TOOLCHAIN}/${CROSS_COMPILE_PREFIX}ranlib"

	# specific library build part
	export SYSROOT="${ANDROID_SYSROOT}"
	export CFLAGS="--sysroot=${ANDROID_SYSROOT} -I${ANDROID_DEV}/include -I${VENDOR_DIR}/openssl-android/include/"
	export CPPFLAGS="--sysroot=${ANDROID_SYSROOT} -I${ANDROID_DEV}/include -DANDROID -DCURL_STATICLIB -I${VENDOR_DIR}/openssl-android/include/ -I${ANDROID_TOOLCHAIN}/include"
	export CXXFLAGS="${CPPFLAGS}"
	export LDFLAGS="-L${VENDOR_DIR}/openssl-android/${arch}"

	./buildconf

	./configure \
			--host=${host} \
			--target=${host} \
            --with-ssl=${VENDOR_DIR}/openssl-android/${arch} \
			--enable-static \
            --disable-shared \
            --disable-verbose \
            --enable-threaded-resolver \
            --enable-libgcc \
            --enable-ipv6 \
			--with-zlib \
			--disable-ldaps \
			--disable-ldap \
			--disable-ftp \
			--disable-file \
			--disable-telnet \
			--disable-dict \
			--disable-tftp \
			--disable-pop3 \
			--disable-imap \
			--disable-smtp \
			--disable-rtsp \
			--disable-gopher
	
	make
	
	# install process
	echo "Copying files..."	

	mkdir -p ${LIBRARY_BUILD_DIR}/${arch}

	for file in libcurl.a; do
        file "lib/.libs/$file"
        cp "lib/.libs/$file" "${LIBRARY_BUILD_DIR}/${arch}/$file"
    done

	echo "Copying include files..."	
	
	mkdir -p ${LIBRARY_BUILD_DIR}/${arch}/include/
	cp -R include/curl ${LIBRARY_BUILD_DIR}/${arch}/include/
	
done

echo "Copying files to vendor path..."
rm -rf ${VENDOR_DIR}/${VENDOR_LIB_DIR}
mkdir -p ${VENDOR_DIR}/${VENDOR_LIB_DIR}
cp -R ${LIBRARY_BUILD_DIR}/* ${VENDOR_DIR}/${VENDOR_LIB_DIR}/

echo "Finished"