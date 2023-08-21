package com.sai.laps.filter;

//public class CustomResponseWrapper {
//
//}
import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

public class CustomResponseWrapper extends HttpServletResponseWrapper {
	
	
  protected CharArrayWriter charWriter=null;

  protected PrintWriter writer=null;
  private ServletOutputStream outpstrm = null;


  public CustomResponseWrapper(HttpServletResponse response) {
     super(response);
    charWriter = new CharArrayWriter();
  }

  public ServletOutputStream getOutputStream() throws IOException {
	    if(outpstrm == null)
	    outpstrm=super.getOutputStream();
	    return outpstrm;
  }

  public PrintWriter getWriter() throws IOException {
    if (writer == null) 
    writer = new PrintWriter(charWriter);
    return writer;
  }

  public String toString() {
    String s = null;

    if (writer != null) {
      s = charWriter.toString();
    }
    return s;
  }
}
