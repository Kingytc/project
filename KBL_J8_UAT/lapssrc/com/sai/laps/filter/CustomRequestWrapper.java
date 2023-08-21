package com.sai.laps.filter;

//public class CustomRequestWrapper {
//
//}
//package com.sai.fw.management.utils;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.IOUtils;


public class CustomRequestWrapper extends HttpServletRequestWrapper {


private byte[] rawData;
private HttpServletRequest request;
private ResettableServletInputStream servletStream;

public CustomRequestWrapper(HttpServletRequest request) {
    super(request);
    this.request = request;
    this.servletStream = new ResettableServletInputStream();
}


public void resetInputStream(byte[] newRawData) {
    servletStream.stream = new ByteArrayInputStream(newRawData);
}


public ServletInputStream getInputStream() throws IOException {
    if (rawData == null) {
        rawData = IOUtils.toByteArray(this.request.getReader());
        servletStream.stream = new ByteArrayInputStream(rawData);
    }
    return servletStream;
}


public BufferedReader getReader() throws IOException {
    if (rawData == null) {
        rawData = IOUtils.toByteArray(this.request.getReader());
        servletStream.stream = new ByteArrayInputStream(rawData);
    }
    return new BufferedReader(new InputStreamReader(servletStream));
}

private class ResettableServletInputStream extends ServletInputStream {

    private InputStream stream;

    @Override
    public int read() throws IOException {
        return stream.read();
     }
   }
 }