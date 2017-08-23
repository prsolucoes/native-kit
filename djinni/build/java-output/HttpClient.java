// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from native-kit.djinni

package com.prsolucoes.nativekit;

import java.util.concurrent.atomic.AtomicBoolean;

/** NK::HttpClient */
public abstract class HttpClient {
    /** version */
    public static final int VERSION = 1;

    public abstract String doGet(String url) throws Exception;

    public abstract String doPost(String url, String data) throws Exception;

    public abstract String doPut(String url, String data) throws Exception;

    public abstract String doDelete(String url) throws Exception;

    public abstract String doHead(String url) throws Exception;

    public abstract String doPath(String url) throws Exception;

    /** methods */
    public static native HttpClient create();

    private static final class CppProxy extends HttpClient
    {
        private final long nativeRef;
        private final AtomicBoolean destroyed = new AtomicBoolean(false);

        private CppProxy(long nativeRef)
        {
            if (nativeRef == 0) throw new RuntimeException("nativeRef is zero");
            this.nativeRef = nativeRef;
        }

        private native void nativeDestroy(long nativeRef);
        public void destroy()
        {
            boolean destroyed = this.destroyed.getAndSet(true);
            if (!destroyed) nativeDestroy(this.nativeRef);
        }
        protected void finalize() throws java.lang.Throwable
        {
            destroy();
            super.finalize();
        }

        @Override
        public String doGet(String url) throws Exception
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_doGet(this.nativeRef, url);
        }
        private native String native_doGet(long _nativeRef, String url);

        @Override
        public String doPost(String url, String data) throws Exception
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_doPost(this.nativeRef, url, data);
        }
        private native String native_doPost(long _nativeRef, String url, String data);

        @Override
        public String doPut(String url, String data) throws Exception
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_doPut(this.nativeRef, url, data);
        }
        private native String native_doPut(long _nativeRef, String url, String data);

        @Override
        public String doDelete(String url) throws Exception
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_doDelete(this.nativeRef, url);
        }
        private native String native_doDelete(long _nativeRef, String url);

        @Override
        public String doHead(String url) throws Exception
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_doHead(this.nativeRef, url);
        }
        private native String native_doHead(long _nativeRef, String url);

        @Override
        public String doPath(String url) throws Exception
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_doPath(this.nativeRef, url);
        }
        private native String native_doPath(long _nativeRef, String url);
    }
}
