package com.sai.laps.helper;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.net.URL;
import java.net.URLConnection;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.lang.reflect.Type;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
public class OAuthTokenGeneration {
	
	public  HashMap getOAuthAuth(HashMap args) throws IOException, NoSuchAlgorithmException, KeyManagementException {
       HashMap hsh = new HashMap();
       String finalToken="",accessToken="",headerStatus="",clientId="",clientSecret="",TokenUrl="",Method="",Scope="",certiPath="",gType="",reqConcat="",testCommand="",location="",errCode="",errMessage="";
		Map<String,Object> responseMap = new HashMap<String, Object>();
		Map<String,String> ser = new HashMap<String, String>();
		Gson gson = new Gson();
		Type mapType = null;
		
		
		TrustManager[] trustAllCerts = new TrustManager[] {new X509TrustManager() {
	         public java.security.cert.X509Certificate[] getAcceptedIssuers() {
	             return null;
	         }
	         public void checkClientTrusted(X509Certificate[] certs, String authType) {
	         }
	         public void checkServerTrusted(X509Certificate[] certs, String authType) {
	         }
	     }
	 };
		
		
		try{
			  gType="client_credentials";
			  clientId="92c2d9b9793695f7bd9aaa411d7657e0";
			  clientSecret="7a1980519b524854cfdf25cef98a95e9";
			  Scope="CCFM";
			 TokenUrl="https://apiuat.ktkbank.com:8443/non-production/development/fi-ccfm-oauth/oauth2/token";
			 certiPath="/home/lapsuat/patches/NationalPortal/ktk1/ktk.crt";
			//Method="getOAuthHttps";
			/*System.out.println("----------IN "+Method+" Method | Input Params"+requestMap+"-----------------");
			clientId = Helper.correctNull((String)requestMap.get("clientId"));
			clientSecret = Helper.correctNull((String)requestMap.get("clientSecretKey"));
			TokenUrl = Helper.correctNull((String)requestMap.get("accessTokenUrl"));
			Scope = Helper.correctNull((String)requestMap.get("Scope"));
			certiPath = Helper.correctNull((String)requestMap.get("certiPath"));
			gType = Helper.correctNull((String)requestMap.get("gType"));
			reqConcat = Helper.correctNull((String)requestMap.get("reqConcat"));
			testCommand = Helper.correctNull((String)requestMap.get("reqConcat"));*/

			System.out.println("----------IN "+Method+" Method | SSLContext-----------------");
			SSLContext ssl_ctx = SSLContext.getInstance("TLSv1.2");
			ssl_ctx.init(null,trustAllCerts,null);
			HostnameVerifier allHostsValid = new HostnameVerifier(){
				public boolean verify(String hostname,SSLSession session){
					return true;
				}
			};

			
			URL url = new URL(TokenUrl);
			System.out.println("----------IN "+Method+" Method | "+TokenUrl+"-----------------");
			HttpsURLConnection con = (HttpsURLConnection)url.openConnection();
			HttpsURLConnection.setDefaultSSLSocketFactory(ssl_ctx.getSocketFactory());
			// Install the all-trusting host verifier
			HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
			location =certiPath;
			if(!location.equalsIgnoreCase("0")){
				System.out.println("----------IN "+Method+" Method | With certificate-----------------");
				System.setProperty("javax.net.ssl.trustStore", location);
			}
			else{
				System.out.println("----------IN "+Method+" Method | Without certificate-----------------");
			}

			StringBuilder data = new StringBuilder();
			//testCommand
			if(testCommand.equalsIgnoreCase("1")){
				data.append("grant_type="+gType);
				data.append("client_id="+clientId);
				data.append("client_secret="+clientSecret);
				data.append("scope="+Scope);
			}
			else{
				data.append("grant_type="+gType+"&client_id="+clientId+"&client_secret="+clientSecret+"&scope="+Scope);
			}
			System.out.println("----------IN "+Method+" Method | data"+data+"-----------------");

			byte[] byteArray = data.toString().getBytes("UTF-8");

			con.setRequestMethod("POST");
			con.setConnectTimeout(5000);
			con .setDoOutput(true);

			if(reqConcat.equalsIgnoreCase("Basic")){
				System.out.println("----------IN "+Method+" Method | Encoding Client ID & Secret-----------------");
				//con.setRequestProperty("Authorization",reqConcat+" "+getEncodedIdAndPassword(clientId,clientSecret));
			}
			
			OutputStream postStream = con.getOutputStream();
			postStream.write(byteArray, 0, byteArray.length);
			postStream.close();
			
			//curl -X POST https://apiuat.ktkbank.com:8443/non-production/development/nationalportal-oauth/oauth2/token
			//--cacert /home/lapsuat/patches/NationalPortal/ktk1/ktk.crt -d 
			//'grant_type=client_credentials&client_id=be276c7e00b8ed209b8f266bb1cdfb6a&client_secret=7cc6552fa712b94444bdae925fd18426&scope=Nationalportal'
			InputStreamReader reader = new InputStreamReader(con.getInputStream());
			BufferedReader in = new BufferedReader(reader);
			String json = in.readLine();
			System.out.println("Json String = " + json);

			// Parse the Json response and retrieve the Access Token
			gson = new Gson();
			mapType  = new TypeToken<Map<String,String>>(){}.getType();
			ser = gson.fromJson(json, mapType);
			accessToken = ser.get("access_token");
			System.out.println("Access Token = " + accessToken);
			hsh.put("access_token", accessToken);
			in.close();
			con.disconnect();
			if(accessToken.equalsIgnoreCase("") || accessToken.equalsIgnoreCase(null)){
				errCode="101";
				errMessage="Empty Token";
				headerStatus="F";
				System.out.println("----------Method : "+Method+" | errCode: "+errCode+", errMessage: "+errMessage+"-----------------");
			}
			else{
				finalToken = "Bearer "+accessToken;
				responseMap.put("finalToken", finalToken);
				responseMap.put("X-IBM-Client-Id", clientId);
				responseMap.put("X-IBM-Client-Secret", clientSecret);
				headerStatus="S";
			}
		}
		catch(Exception e){
			System.out.println("----------Method : "+Method+"| Token geration Failed-----------------"+e.getMessage());
			errCode="105"; 
			errMessage="System Error :"+e.getMessage();
			headerStatus="F";
			e.printStackTrace();
		}
		finally{
			System.out.println("----------Method : "+Method+"| Finally-----------------");
			responseMap.put("errCode", errCode);
			responseMap.put("errMessage", errMessage);
			responseMap.put("headerStatus", headerStatus);
			System.out.println("----------Method : "+Method+"| responseMap"+responseMap+"-----------------");
		}
 
 return hsh;
}
}
