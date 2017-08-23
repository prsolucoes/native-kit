// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from native-kit.djinni

#pragma once

#include "djinni_support.hpp"
#include "http_client.hpp"

namespace djinni_generated {

class HttpClient final : ::djinni::JniInterface<::NK::HttpClient, HttpClient> {
public:
    using CppType = std::shared_ptr<::NK::HttpClient>;
    using CppOptType = std::shared_ptr<::NK::HttpClient>;
    using JniType = jobject;

    using Boxed = HttpClient;

    ~HttpClient();

    static CppType toCpp(JNIEnv* jniEnv, JniType j) { return ::djinni::JniClass<HttpClient>::get()._fromJava(jniEnv, j); }
    static ::djinni::LocalRef<JniType> fromCppOpt(JNIEnv* jniEnv, const CppOptType& c) { return {jniEnv, ::djinni::JniClass<HttpClient>::get()._toJava(jniEnv, c)}; }
    static ::djinni::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c) { return fromCppOpt(jniEnv, c); }

private:
    HttpClient();
    friend ::djinni::JniClass<HttpClient>;
    friend ::djinni::JniInterface<::NK::HttpClient, HttpClient>;

};

}  // namespace djinni_generated