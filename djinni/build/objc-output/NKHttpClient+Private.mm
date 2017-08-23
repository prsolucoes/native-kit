// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from native-kit.djinni

#import "NKHttpClient+Private.h"
#import "NKHttpClient.h"
#import "DJICppWrapperCache+Private.h"
#import "DJIError.h"
#import "DJIMarshal+Private.h"
#include <exception>
#include <stdexcept>
#include <utility>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@interface NKHttpClient ()

- (id)initWithCpp:(const std::shared_ptr<::NK::HttpClient>&)cppRef;

@end

@implementation NKHttpClient {
    ::djinni::CppProxyCache::Handle<std::shared_ptr<::NK::HttpClient>> _cppRefHandle;
}

- (id)initWithCpp:(const std::shared_ptr<::NK::HttpClient>&)cppRef
{
    if (self = [super init]) {
        _cppRefHandle.assign(cppRef);
    }
    return self;
}

+ (nullable NKHttpClient *)create {
    try {
        auto objcpp_result_ = ::NK::HttpClient::create();
        return ::djinni_generated::HttpClient::fromCpp(objcpp_result_);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)doGet:(nonnull NSString *)url {
    try {
        auto objcpp_result_ = _cppRefHandle.get()->do_get(::djinni::String::toCpp(url));
        return ::djinni::String::fromCpp(objcpp_result_);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)doPost:(nonnull NSString *)url
                        data:(nonnull NSString *)data {
    try {
        auto objcpp_result_ = _cppRefHandle.get()->do_post(::djinni::String::toCpp(url),
                                                           ::djinni::String::toCpp(data));
        return ::djinni::String::fromCpp(objcpp_result_);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)doPut:(nonnull NSString *)url
                       data:(nonnull NSString *)data {
    try {
        auto objcpp_result_ = _cppRefHandle.get()->do_put(::djinni::String::toCpp(url),
                                                          ::djinni::String::toCpp(data));
        return ::djinni::String::fromCpp(objcpp_result_);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)doDelete:(nonnull NSString *)url {
    try {
        auto objcpp_result_ = _cppRefHandle.get()->do_delete(::djinni::String::toCpp(url));
        return ::djinni::String::fromCpp(objcpp_result_);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)doHead:(nonnull NSString *)url {
    try {
        auto objcpp_result_ = _cppRefHandle.get()->do_head(::djinni::String::toCpp(url));
        return ::djinni::String::fromCpp(objcpp_result_);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)doPath:(nonnull NSString *)url {
    try {
        auto objcpp_result_ = _cppRefHandle.get()->do_path(::djinni::String::toCpp(url));
        return ::djinni::String::fromCpp(objcpp_result_);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}


namespace djinni_generated {

auto HttpClient::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        return nullptr;
    }
    return objc->_cppRefHandle.get();
}

auto HttpClient::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return ::djinni::get_cpp_proxy<NKHttpClient>(cpp);
}

}  // namespace djinni_generated

@end
