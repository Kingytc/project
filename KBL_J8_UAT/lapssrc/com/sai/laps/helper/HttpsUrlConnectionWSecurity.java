package com.sai.laps.helper;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.security.SecureRandom;
import java.security.cert.Certificate;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.KeyManager;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLPeerUnverifiedException;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import com.jamonapi.utils.Logger;
public class HttpsUrlConnectionWSecurity {

	public static class DummyTrustManager implements X509TrustManager {

		public DummyTrustManager() {
		}

		public boolean isClientTrusted(X509Certificate cert[]) {
			return true;
		}

		public boolean isServerTrusted(X509Certificate cert[]) {
			return true;
		}

		public X509Certificate[] getAcceptedIssuers() {
			return new X509Certificate[0];
		}

		public void checkClientTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {

		}

		public void checkServerTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {

		}
	}
	public static class DummyHostnameVerifier implements HostnameVerifier {

		public boolean verify( String urlHostname, String certHostname ) {
			return true;
		}

		public boolean verify(String arg0, SSLSession arg1) {
			return true;
		}
	}

	public  static String connect(String httpsURL,String data) throws Exception  {
			StringBuffer sb=new StringBuffer();
			SSLContext sslcontext = null;
			sslcontext = SSLContext.getInstance("SSL");
			
			
//			LogWriter.log(LAPSLogLevel.INFO,"INITIALIZING SSL CONTEXT ");
			
//			System.setProperty("javax.net.ssl.trustStore", "/home/jdoe/MyProject/mykeystore");
			
			
			sslcontext.init(new KeyManager[0],
					new TrustManager[] { new DummyTrustManager() },
					new SecureRandom());
	
			SSLSocketFactory factory = sslcontext.getSocketFactory();
			
//			LogWriter.log(LAPSLogLevel.INFO,"FORMING HTTPS URL ");
			
			Logger.log("HTTPS URL : "+httpsURL.toString());			
			
			URL myurl = new URL(httpsURL);
//			LogWriter.log(LAPSLogLevel.INFO,"CREATING HTTPS CONNECTION ");
			HttpsURLConnection connection = (HttpsURLConnection) myurl.openConnection();
			connection.setConnectTimeout(30000);
			connection.setRequestMethod("POST");
			
			
//			connection.addRequestProperty("X-IBM-Client-Secret", "R7wI3gD7pC5uP8eM7qG1vH5eB6nJ7eR3sT7wK0lM4rY2tP1fH6");
//			connection.addRequestProperty("X-IBM-Client-Id", "743f4511-4d07-490e-a933-f1c8a06f1d6a");
			//connection.addRequestProperty("X-IBM-Client-Secret", ApplicationParams.getStrCIBIL_SECRET_ID());
			//connection.addRequestProperty("X-IBM-Client-Id", ApplicationParams.getStrCIBIL_CLIENT_ID());
			
			connection.addRequestProperty("Content-Type", "application/xml");
			
//			String baseAuthStr = "testclient:test@123";
			//String strCB_username=ApplicationParams.getCIBIL_USER_CREDENTIALS();
			//String strCB_password=ApplicationParams.getCIBIL_PASS_CREDENTIALS();
			//String baseAuthStr=strCB_username+":"+strCB_password;
//			String encoding=Base64.getEncoder().encodeToString((baseAuthStr).getBytes("UTF-8"));
//			connection.addRequestProperty("Authorization", "Basic "+encoding);
			
			connection.setDoOutput(true);
			connection.setSSLSocketFactory(factory);
			connection.setHostnameVerifier(new DummyHostnameVerifier());
			
			
			// dumpl all cert info
			// print_https_cert(con);

			// dump all the content
			// print_content(con);
//			int code=connection.getResponseCode();
//			Logger.log("Before getting Response code..");
//			Logger.log("Response Code:"+code);
//			if(code==200){
//				OutputStream os = connection.getOutputStream();
//				OutputStreamWriter osw = new OutputStreamWriter(os);
//				osw.write(data);
//				osw.flush();
//				osw.close();
//				InputStream is =connection.getInputStream();
//				BufferedReader br = new BufferedReader(new InputStreamReader(is));	
//				String inputLine;
//				while ((inputLine = br.readLine()) != null) {
//					sb.append(inputLine);
//				}
//				br.close();
//				is.close();
//				connection.disconnect();
//			}
//			InputStream is =new FileInputStream("C:\\Users\\Prabakaran.K\\Desktop\\YBL\\CibilSample\\cibilproxy\\ACKRESPONSE.txt");
//			BufferedReader br = new BufferedReader(new InputStreamReader(is));	
//			String inputLine;
//			while ((inputLine = br.readLine()) != null) {
//				sb.append(inputLine);
//			}
//			is.close();
//			br.close();
			
			DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
			
			
//			byte[] postData = Files.readAllBytes(Paths.get("C:\\Users\\Prabakaran.K\\Desktop\\YBL\\CibilSample\\newcibil\\CIBIL_ACK_REQ (2).txt"));
//			wr.write(postData);
			
			
			wr.write(data.getBytes());
			wr.flush();
			wr.close();
			InputStream ins = null;
			
//			LogWriter.log(LAPSLogLevel.INFO,"WAITING FOR CONNECTION STATUS ");
			
			int responseCode=connection.getResponseCode();
			
//			Logger.log("RESPONSE CODE :"+ responseCode);
			
			if (responseCode == connection.HTTP_OK) {
				
//				LogWriter.log(LAPSLogLevel.INFO,"HTTP CONNECTION OK");
				
				ins = connection.getInputStream();
				
			} else {
				
//				LogWriter.log(LAPSLogLevel.INFO,"HTTP CONNECTION ERROR");
				
				
				ins = connection.getErrorStream();
				
			}
			InputStreamReader isr = new InputStreamReader(ins);
			BufferedReader in = new BufferedReader(isr);
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				sb.append(inputLine);
			}
			isr.close();
			in.close();
			
//			LogWriter.log(LAPSLogLevel.INFO,"DISCONNECTING CONNECTION");
			
			connection.disconnect();
		
		return sb.toString();
	}

}
