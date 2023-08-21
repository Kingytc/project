//package com.sai.laps.filter;
//
//public class WebServicesFilterHandler {
//
//}
package com.sai.laps.filter;

import java.io.ByteArrayOutputStream;
import java.io.CharArrayWriter;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.Inet4Address;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.ProxySelector;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.DigestException;
import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import java.util.StringTokenizer;
import java.util.concurrent.ThreadLocalRandom;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import javax.xml.soap.MessageFactory;
import javax.xml.soap.MimeHeaders;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;

import com.google.gson.Gson;
//import com.sai.fw.management.utils.CustomRequestWrapper;
//import com.sai.fw.management.utils.CustomResponseWrapper;
import com.sai.fw.management.utils.FwHelper;
import com.sai.laps.ejb.commworkflow.CommWorkflowBean;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.DBUtils;
import com.sai.laps.helper.EJBInvoker;
import com.sai.laps.helper.Helper;

//import com.sai.mobile.POJO.assignlead.jsonRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.*;



//static Logger log=Logger.getLogger(WebServicesFilterHandler.class);

public class WebServicesFilterHandler implements Filter{
	
	public static final String AUTHENTICATION_HEADER = "Authorization";
	public class FilterServletOutputStream extends ServletOutputStream
	{
	    //=======================================================================
	    private DataOutputStream stream; 
	    //=======================================================================
	    public FilterServletOutputStream(OutputStream output) { 
	      stream = new DataOutputStream(output); 
	    }
	    //=======================================================================
	    @Override
	    public void write(int b) throws IOException  {
	        stream.write(b); 
	    }
	    //=======================================================================
	    @Override
	    public void write(byte[] b) throws IOException  { 
	        stream.write(b); 
	    }
	    //=======================================================================
	    @Override
	    public void write(byte[] b, int off, int len) throws IOException  {
	        stream.write(b,off,len); 
	    }
	    //=======================================================================
	}




	public class GenericResponseWrapper extends HttpServletResponseWrapper 
	{ 
	  private ByteArrayOutputStream output;
	  private int contentLength;
	  private String contentType;
	  
	  private PrintWriter pwriter = null;
	  private ServletOutputStream outpstrm = null;
	  
	  public GenericResponseWrapper(HttpServletResponse response) { 
	    super(response);
	    output=new ByteArrayOutputStream();
	  } 
	  public byte[] getData() { 
	    return output.toByteArray(); 
	  }
	  
	  public String getStringData() { 
		    return output.toString(); 
		  }
	  @Override
	  public ServletOutputStream getOutputStream() 
	  { 
		  if (outpstrm == null) outpstrm = new FilterServletOutputStream(output);
		    return outpstrm;
	  } 

	  @Override
	  public PrintWriter getWriter() 
	  { 
		  if (pwriter == null) pwriter = new PrintWriter(getOutputStream(),true); 
		    return pwriter;
	  } 

	  @Override
	  public void setContentLength(int length) { 
	    this.contentLength = length;
	    super.setContentLength(length); 
	  } 

	  public int getContentLength() { 
	    return contentLength; 
	  } 
	  @Override
	  public void setContentType(String type) { 
	    this.contentType = type;
	    super.setContentType(type); 
	  } 
	  @Override
	  public String getContentType() { 
	    return contentType; 
	  } 
	} 
	
	
	protected FilterConfig config;

	public void init(FilterConfig config) throws ServletException {
	    this.config = config;
	  }

	  public void destroy() {
	  }

	  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
	      throws ServletException, IOException {
		  String body1="";
		
		 
		
		  
		  String strClientBrowserDetails="";
			strClientBrowserDetails=((HttpServletRequest) request).getHeader("User-Agent");
			HttpServletRequest httpRequest = (HttpServletRequest) request;
			//System.out.println("================================>"+strClientBrowserDetails);
			String strUserAgent="",strOS="",strBrowser="";
			strUserAgent=strClientBrowserDetails.toLowerCase();

			System.out.println("USER-AGENT FOR THE REQUEST : "+strUserAgent);
			
			
			System.out.println("OPERATING SYSTEM : "+strOS);

			if (strUserAgent.contains("msie")){
				String substring=strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("MSIE")).split(";")[0];
				strBrowser=substring.split(" ")[0].replace("MSIE", "IE")+"-"+substring.split(" ")[1];
			}else if (strUserAgent.contains("safari") && strUserAgent.contains("version")){
				strBrowser=(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Safari")).split(" ")[0]).split("/")[0]+"-"+(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Version")).split(" ")[0]).split("/")[1];
			} else if ( strUserAgent.contains("opr") || strUserAgent.contains("opera")){
				if(strUserAgent.contains("opera"))
					strBrowser=(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Opera")).split(" ")[0]).split("/")[0]+"-"+(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Version")).split(" ")[0]).split("/")[1];
				else if(strUserAgent.contains("opr"))
					strBrowser=((strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("OPR")).split(" ")[0]).replace("/", "-")).replace("OPR", "Opera");
			} else if (strUserAgent.contains("chrome")){
				strBrowser=(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Chrome")).split(" ")[0]).replace("/", "-");
			} else if ((strUserAgent.indexOf("mozilla/7.0") > -1) || (strUserAgent.indexOf("netscape6") != -1)  || (strUserAgent.indexOf("mozilla/4.7") != -1) || (strUserAgent.indexOf("mozilla/4.78") != -1) || (strUserAgent.indexOf("mozilla/4.08") != -1) || (strUserAgent.indexOf("mozilla/3") != -1) ){
				//strBrowser=(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("MSIE")).split(" ")[0]).replace("/", "-");
				strBrowser = "Netscape-?";

			} else if (strUserAgent.contains("firefox")) {
				strBrowser=(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Firefox")).split(" ")[0]).replace("/", "-");
			} else if(strUserAgent.contains("rv")) {
				strBrowser="IE-" + strUserAgent.substring(strUserAgent.indexOf("rv") + 3, strUserAgent.indexOf(")"));
			} else{
				strBrowser = "UnKnown Browser, More-Info: "+strClientBrowserDetails;
			}
			
			
			
			String acthost=httpRequest.getHeader("host");
			String acturl=Helper.correctNull(httpRequest.getHeader(org.apache.http.HttpHeaders.REFERER));
			
			
			
		  
		  CustomRequestWrapper customRequestWrapper = new CustomRequestWrapper(
		            (HttpServletRequest) request);
		 
		  body1=(customRequestWrapper.getRequestURI());
		  
		
			  String body = IOUtils.toString(customRequestWrapper.getReader());
			  String req="";
			 
			  Object obj = null;
			try {
				obj = new JSONParser().parse(body);
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
	          
		        // typecasting obj to JSONObject
		        JSONObject jo = (JSONObject) obj;
		          
		        String token=(String) jo.get("token");
		        String reqTime=(String) jo.get("reqTime");
		        String ServiceName=(String) jo.get("ServiceName");
		        // getting firstName and lastName
		        String req1 = (String) jo.get("req");
		        
		       // System.out.println("=====After"+body);
		        body= req1;
		        
			  String decyrptedRequest =decrypt(body, "sysarc@1234INFO@");
			  System.out.println("==================>"+decyrptedRequest);
			  body=decyrptedRequest;
			  Boolean tokenflag=false,logout=false;
			  String StrToken ="",DeviceID="",ValidUser ="";
			  
			  Object obj2 = null;
				try {
					obj2 = new JSONParser().parse(decyrptedRequest);
				} catch (ParseException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
		          
			        // typecasting obj to JSONObject
			        JSONObject jo2 = (JSONObject) obj2;
			        //String ValidUser1 = (String) jo2.putIfAbsent("Tokenfgfd", "7634763237848");
			        // getting firstName and lastName
			       
			      
			        
		   // System.out.println("customRequestWrapper.getRemoteAddr===="+(customRequestWrapper.getRemoteAddr()));
	         
			if(!tokenflag && !logout)
			{
		    try
		    {
		  // System.out.println("==================1==========>"+((HttpServletRequest) request).getRequestURI());
		    body1=(customRequestWrapper.getRequestURI());
		    
		  // System.out.println("========body1==========2==========>"+body1);
		    }
		    catch(Exception e)
		    {
		    	System.out.println(e.toString());
		    }
		    
		    
		    customRequestWrapper.resetInputStream(body.getBytes());
		   // System.out.println("body.getBytes()===="+body.getBytes().toString());
		    ServletResponse newResponse = response;

		  if (request instanceof HttpServletRequest) {
			  
//			  String strClientBrowserDetails="";
//				strClientBrowserDetails=((HttpServletRequest) request).getHeader("User-Agent");
//				HttpServletRequest httpRequest = (HttpServletRequest) request;
//				System.out.println("================================>"+strClientBrowserDetails);
//				String strUserAgent="",strOS="",strBrowser="";
//				strUserAgent=strClientBrowserDetails.toLowerCase();
//
//				System.out.println("USER-AGENT FOR THE REQUEST : "+strUserAgent);
//				
//				
//				if (strUserAgent.toLowerCase().indexOf("windows") >= 0 ){
//					strOS = "Windows";
//				} else if(strUserAgent.toLowerCase().indexOf("mac") >= 0){
//					strOS = "Mac";
//				} else if(strUserAgent.toLowerCase().indexOf("x11") >= 0){
//					strOS = "Unix";
//				} else if(strUserAgent.toLowerCase().indexOf("android") >= 0){
//					strOS = "Android";
//				} else if(strUserAgent.toLowerCase().indexOf("iphone") >= 0){
//					strOS = "IPhone";
//				}else{
//					strOS = "UnKnown Agent, More-Info: "+strUserAgent;
//				}
//				System.out.println("OPERATING SYSTEM : "+strOS);
//
//				if (strUserAgent.contains("msie")){
//					String substring=strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("MSIE")).split(";")[0];
//					strBrowser=substring.split(" ")[0].replace("MSIE", "IE")+"-"+substring.split(" ")[1];
//				}else if (strUserAgent.contains("safari") && strUserAgent.contains("version")){
//					strBrowser=(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Safari")).split(" ")[0]).split("/")[0]+"-"+(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Version")).split(" ")[0]).split("/")[1];
//				} else if ( strUserAgent.contains("opr") || strUserAgent.contains("opera")){
//					if(strUserAgent.contains("opera"))
//						strBrowser=(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Opera")).split(" ")[0]).split("/")[0]+"-"+(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Version")).split(" ")[0]).split("/")[1];
//					else if(strUserAgent.contains("opr"))
//						strBrowser=((strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("OPR")).split(" ")[0]).replace("/", "-")).replace("OPR", "Opera");
//				} else if (strUserAgent.contains("chrome")){
//					strBrowser=(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Chrome")).split(" ")[0]).replace("/", "-");
//				} else if ((strUserAgent.indexOf("mozilla/7.0") > -1) || (strUserAgent.indexOf("netscape6") != -1)  || (strUserAgent.indexOf("mozilla/4.7") != -1) || (strUserAgent.indexOf("mozilla/4.78") != -1) || (strUserAgent.indexOf("mozilla/4.08") != -1) || (strUserAgent.indexOf("mozilla/3") != -1) ){
//					//strBrowser=(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("MSIE")).split(" ")[0]).replace("/", "-");
//					strBrowser = "Netscape-?";
//
//				} else if (strUserAgent.contains("firefox")) {
//					strBrowser=(strClientBrowserDetails.substring(strClientBrowserDetails.indexOf("Firefox")).split(" ")[0]).replace("/", "-");
//				} else if(strUserAgent.contains("rv")) {
//					strBrowser="IE-" + strUserAgent.substring(strUserAgent.indexOf("rv") + 3, strUserAgent.indexOf(")"));
//				} else{
//					strBrowser = "UnKnown Browser, More-Info: "+strClientBrowserDetails;
//				}
//				
//				
//				
//				String acthost=httpRequest.getHeader("host");
//				String acturl=Helper.correctNull(httpRequest.getHeader(org.apache.http.HttpHeaders.REFERER));
//				//acturl=acturl.substring(acturl.indexOf("//")+ 2 );
//				//acturl=acturl.substring(0,acturl.indexOf("/"));
//				System.out.println("===========acthost========="+acthost);
//				System.out.println("===========acturl========="+acturl);
//				if(acthost.equals(acturl))
//				{
//				session.setAttribute("actulurl",Helper.correctNull(httpRequest.getHeader(org.apache.http.HttpHeaders.REFERER)));
//				}
			  
			  
			  GenericResponseWrapper wrapper = new GenericResponseWrapper((HttpServletResponse) response);
			
					HttpServletRequest httpServletRequest = (HttpServletRequest) request;
					String authCredentials = httpServletRequest
							.getHeader(AUTHENTICATION_HEADER);

					boolean authenticationStatus = authenticate(authCredentials);

					if (authenticationStatus) {
						 
						    chain.doFilter(customRequestWrapper, wrapper);
					} else {
						if (response instanceof HttpServletResponse) {
							HttpServletResponse httpServletResponse = (HttpServletResponse) response;
							httpServletResponse
									.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
						}
					}
				
			  
			  
			  
			  
				
				
			 
			    
			    
			    OutputStream out = response.getOutputStream();
			    
			    
				
			    //OutputStream out1 = response.getOutputStream();
			    
			  //  System.out.println("=======111111===4444===="+(wrapper.getStringData()));
			    
			    String finalString=wrapper.getStringData();
			   
			  
			  
				  Object obj3 = null;
				try {
					obj3 = new JSONParser().parse(finalString);
				} catch (ParseException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
		          try{
			        // typecasting obj to JSONObject
			        JSONObject jo3 = (JSONObject) obj3;
			        String strvalue3 = (String) jo3.put("token", token);
			        String strvalue4 = (String) jo3.put("restime", Helper.correctDateFinacle());
			        /*JSONObject userContext = new JSONObject();
			        userContext.put("appUserId", value);
			        userContext.put("appPassword", value);
			        */finalString = jo3.toString();
		          }catch(Exception e)
		          {
		        	  e.printStackTrace();
		          }
			  
		  
			    //out.write(wrapper.getData());
			    
			   // out1.write(wrapper.getData());
			   // java.io.PrintWriter out12 = new PrintWriter(out1);
			   
			   // byte[] respob=wrapper.getWriter();
			    //String finalString = out12.
			   // byte[] respob=((ByteArrayOutputStream) out1).toByteArray();
			    
			    //ByteArrayOutputStream bos = (ByteArrayOutputStream)out1;
			   // System.out.println("=============="+out12.toString());
		        //String finalString = respob.toString();
		        System.out.println("=============finalString REsponse "+finalString);
		        
		        String encyrptedResponse =encrypt(finalString,"sysarc@1234INFO@");
		        System.out.println("=============encyrptedResponse REsponse "+encyrptedResponse);
		        
		      //  System.out.println("=============dedcyrptedResponse REsponse "+decrypt(encyrptedResponse, "sysarc@1234INFO@"));
			    out.write(encyrptedResponse.getBytes());
			   // System.out.println(wrapper.toString());
			    //out.write("test content".getBytes());
			    out.close();
			   

	  }
			  }else
			    {
					    OutputStream out = response.getOutputStream();
					    String finalString = "UnTrusted Access!!! Access Denied!!!";
					    String encyrptedResponse =encrypt(finalString,"sysarc@1234INFO@");
					    out.write(encyrptedResponse.getBytes());
					    out.close();
			    }
		   // }
	   // else
	    //{
	    	
		    	// String body = IOUtils.toString(customRequestWrapper.getReader());
	    	// customRequestWrapper.resetInputStream(body.getBytes("UTF-8"));
		    	 
		    	  // ServletResponse newResponse = response;
	    	  // if (request instanceof HttpServletRequest) {
		    	 // GenericResponseWrapper wrapper = new GenericResponseWrapper((HttpServletResponse) response);
				   // chain.doFilter(customRequestWrapper, wrapper);
				   // OutputStream out = response.getOutputStream();
				   // out.write(wrapper.getData());
				   
				   // out.write("UnTrusted Access!!! Access Denied!!!".getBytes());
				   // out.close();
		    	 //  }
		  
		   // }
	  }
	  
	  public static byte[][] GenerateKeyAndIV(int keyLength, int ivLength, int iterations, byte[] salt, byte[] password, MessageDigest md) {

		    int digestLength = md.getDigestLength();
		    int requiredLength = (keyLength + ivLength + digestLength - 1) / digestLength * digestLength;
		    byte[] generatedData = new byte[requiredLength];
		    int generatedLength = 0;

		    try {
		        md.reset();

		        // Repeat process until sufficient data has been generated
		        while (generatedLength < keyLength + ivLength) {

		            // Digest data (last digest if available, password data, salt if available)
		            if (generatedLength > 0)
		                md.update(generatedData, generatedLength - digestLength, digestLength);
		            md.update(password);
		            if (salt != null)
		                md.update(salt, 0, 8);
		            md.digest(generatedData, generatedLength, digestLength);

		            // additional rounds
		            for (int i = 1; i < iterations; i++) {
		                md.update(generatedData, generatedLength, digestLength);
		                md.digest(generatedData, generatedLength, digestLength);
		            }

		            generatedLength += digestLength;
		        }

		        // Copy key and IV into separate byte arrays
		        byte[][] result = new byte[2][];
		        result[0] = Arrays.copyOfRange(generatedData, 0, keyLength);
		        if (ivLength > 0)
		            result[1] = Arrays.copyOfRange(generatedData, keyLength, keyLength + ivLength);

		        return result;

		    } catch (DigestException e) {
		        throw new RuntimeException(e);

		    } finally {
		        // Clean out temporary data
		        Arrays.fill(generatedData, (byte)0);
		    }
		
		}

//		public static String encrypt(String strToEncrypt, String secret1) 
//		{
//			try 
//			{
////				byte[] bytekey=secret.getBytes();
////				SecretKeySpec key = (SecretKeySpec) generateKey(bytekey,"AES");
//				
//				
////				byte[] decodedKey = org.apache.commons.codec.binary.Base64.decodeBase64(secret);
////				System.out.println("decodedKey==========>"+decodedKey);
////				SecretKey originalKey = new SecretKeySpec(decodedKey, 0, decodedKey.length, "AES"); 
////				
////				
////				System.out.println("originalKey==========>"+originalKey.toString());
////				
//				//secret="abvgfg457@456775";
//				SecretKeySpec skeySpec = new SecretKeySpec(secret.getBytes("UTF-8"), "AES");
//				
//				Cipher cipher1 = Cipher.getInstance("AES/CBC/PKCS5Padding");
//				//cipher1.init(Cipher.ENCRYPT_MODE, secret);
//				cipher1.init(Cipher.ENCRYPT_MODE,skeySpec);
//				return Base64.getEncoder().encodeToString(cipher1.doFinal(strToEncrypt.getBytes("UTF-8")));
//			} 
//			catch (Exception e) 
//			{
//				System.out.println("Error while encrypting: " + e.toString());
//			}
//			return null;
//		}
		
//		  private static  Key generateKey(byte[] keyValue,String algo) throws Exception {
//			    Key key = new SecretKeySpec(keyValue, algo);
//			    return key;
//			  }
	//	
//		 private static String encrypt(String content,byte[] keyValue,String algo) throws Exception {
//			    Key key = generateKey(keyValue, "AES");
//			    Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
//			    c.init(Cipher.ENCRYPT_MODE, key);
//			    byte[] encVal = c.doFinal(content.getBytes(StandardCharsets.UTF_8));
//			    String encryptedValue="";
//			    
//			    encryptedValue = new String(java.util.Base64.getEncoder().encode(encVal));
//			    System.out.println("encryptedValue====="+encryptedValue);
//			    //encryptedValue = new BASE64Encoder().encode(encVal).replaceAll("\r\n","");
//			    return encryptedValue;
//			  }
		
		 public static String encrypt(String plaintext, String passphrase) {
		        try {
		            final int keySize = 256;
		            final int ivSize = 128;

		            // Create empty key and iv
		            byte[] key = new byte[keySize / 8];
		            byte[] iv = new byte[ivSize / 8];

		            // Create random salt
		            byte[] saltBytes = generateSalt(8);

		            // Derive key and iv from passphrase and salt
		            EvpKDF(passphrase.getBytes("UTF-8"), keySize, ivSize, saltBytes, key, iv);

		            // Actual encrypt
		            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		            cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(key, "AES"), new IvParameterSpec(iv));
		            byte[] cipherBytes = cipher.doFinal(plaintext.getBytes("UTF-8"));

		            /**
		             * Create CryptoJS-like encrypted string from encrypted data
		             * This is how CryptoJS do:
		             * 1. Create new byte array to hold ecrypted string (b)
		             * 2. Concatenate 8 bytes to b
		             * 3. Concatenate salt to b
		             * 4. Concatenate encrypted data to b
		             * 5. Encode b using Base64
		             */
		            byte[] sBytes = "Salted__".getBytes("UTF-8");
		            byte[] b = new byte[sBytes.length + saltBytes.length + cipherBytes.length];
		            System.arraycopy(sBytes, 0, b, 0, sBytes.length);
		            System.arraycopy(saltBytes, 0, b, sBytes.length, saltBytes.length);
		            System.arraycopy(cipherBytes, 0, b, sBytes.length + saltBytes.length, cipherBytes.length);

		            String base64b = org.apache.commons.codec.binary.Base64.encodeBase64String(b);

		            return new String(base64b);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }

		        return null;
		    }
		 
		 private static byte[] generateSalt(int length) {
		        Random r = new SecureRandom();
		        byte[] salt = new byte[length];
		        r.nextBytes(salt);
		        return salt;
		    }
		 
		 private static byte[] EvpKDF(byte[] password, int keySize, int ivSize, byte[] salt, byte[] resultKey, byte[] resultIv) throws NoSuchAlgorithmException {
		        return EvpKDF(password, keySize, ivSize, salt, 1, "MD5", resultKey, resultIv);
		    }

		    private static byte[] EvpKDF(byte[] password, int keySize, int ivSize, byte[] salt, int iterations, String hashAlgorithm, byte[] resultKey, byte[] resultIv) throws NoSuchAlgorithmException {
		        keySize = keySize / 32;
		        ivSize = ivSize / 32;
		        int targetKeySize = keySize + ivSize;
		        byte[] derivedBytes = new byte[targetKeySize * 4];
		        int numberOfDerivedWords = 0;
		        byte[] block = null;
		        MessageDigest hasher = MessageDigest.getInstance(hashAlgorithm);
		        while (numberOfDerivedWords < targetKeySize) {
		            if (block != null) {
		                hasher.update(block);
		            }
		            hasher.update(password);
		            block = hasher.digest(salt);
		            hasher.reset();

		            // Iterations
		            for (int i = 1; i < iterations; i++) {
		                block = hasher.digest(block);
		                hasher.reset();
		            }

		            System.arraycopy(block, 0, derivedBytes, numberOfDerivedWords * 4,
		                    Math.min(block.length, (targetKeySize - numberOfDerivedWords) * 4));

		            numberOfDerivedWords += block.length / 4;
		        }

		        System.arraycopy(derivedBytes, 0, resultKey, 0, keySize * 4);
		        System.arraycopy(derivedBytes, keySize * 4, resultIv, 0, ivSize * 4);

		        return derivedBytes; // key + iv
		    }
		    
		    public static String decrypt(String ciphertext, String passphrase) {
		        try {
		            final int keySize = 256;
		            final int ivSize = 128;

		            // Decode from base64 text
		            byte[] ctBytes = org.apache.commons.codec.binary.Base64.decodeBase64(ciphertext.getBytes("UTF-8"));

		            // Get salt
		            byte[] saltBytes = Arrays.copyOfRange(ctBytes, 8, 16);

		            // Get ciphertext
		            byte[] ciphertextBytes = Arrays.copyOfRange(ctBytes, 16, ctBytes.length);

		            // Get key and iv from passphrase and salt
		            byte[] key = new byte[keySize / 8];
		            byte[] iv = new byte[ivSize / 8];
		            EvpKDF(passphrase.getBytes("UTF-8"), keySize, ivSize, saltBytes, key, iv);

		            // Actual decrypt
		            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		            cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(key, "AES"), new IvParameterSpec(iv));
		            byte[] recoveredPlaintextBytes = cipher.doFinal(ciphertextBytes);

		            return new String(recoveredPlaintextBytes);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }

		        return null;
		    }
		    
		    
		    
			public boolean authenticate(String authCredentials) {

				if (null == authCredentials)
					return false;
				final String encodedUserPassword = authCredentials.replaceFirst("Basic"+ " ", "");
				String usernameAndPassword = null;
				try
				{
					byte[] decodedBytes = com.sun.jersey.core.util.Base64.decode(encodedUserPassword);
					usernameAndPassword = new String(decodedBytes, "UTF-8");
				}
				catch (IOException e) {
					e.printStackTrace();
				}
				final StringTokenizer tokenizer = new StringTokenizer(usernameAndPassword, ":");
				final String username = tokenizer.nextToken();
				final String password = tokenizer.nextToken();
				
				String lapsparamCredentials=ApplicationParams.getStrapicredential();
				
				final StringTokenizer lapsparamtokenizer = new StringTokenizer(lapsparamCredentials, ":");
				final String lapsparamUsername = lapsparamtokenizer.nextToken();
				final String lapsparamPassword = lapsparamtokenizer.nextToken();

				boolean authenticationStatus = lapsparamUsername.equals(username) && lapsparamPassword.equals(password);
				return authenticationStatus;
			}
}



