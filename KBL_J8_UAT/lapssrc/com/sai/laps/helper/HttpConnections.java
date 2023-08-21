package com.sai.laps.helper;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class HttpConnections {
	
	
	public static String PostConnection(String httpUrl,String request) throws Exception 
	{String output = "";StringBuffer strOutput=new StringBuffer();
	HttpURLConnection conn= null;
	int Lapstime=600000;
	Lapstime=Integer.parseInt(ApplicationParams.getStrBULKHANDOFFLAPSTIME());
	try {
		URL url = new URL(httpUrl);
		Logger.log("*****URL*****" + url);
		conn = (HttpURLConnection) url.openConnection();
		conn.setDoOutput(true);
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/json");
		//conn.setReadTimeout(ApplicationParams.getStrCreateLoanAccount());
		conn.setConnectTimeout(Lapstime);
		Logger.log("*****Sending Request to --" + url);
		OutputStream os = conn.getOutputStream();
		os.write(request.getBytes());
		os.flush();
		os.close();
		Logger.log("=======Connection Response====>"+conn.getResponseCode());
		Logger.log("=====Connection HTTP OK URL=====>"+HttpURLConnection.HTTP_OK);
		if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
			Logger.log("=======Inside The loop======>Connection done in HTTP");
			BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
			while ((output = br.readLine()) != null) {
				strOutput.append(Helper.correctNull(output));
			}
			//Logger.log("***********  Output FORMAT  ***********  " +"\n"+ strOutput);
			conn.disconnect();
			if (br != null)
				br.close();
		}
	} catch (ConnectException ce) {
		Logger.log("=======Inside Catch one block=========Httpconnection class");
		ce.printStackTrace();
		//throw ce;
		
	}
	catch(Exception e)
	{
		Logger.log("=======Inside Catch two block=========Httpconnection class");			
		e.printStackTrace();
	}
	Logger.log("Output Format Is in HTTP Class=======>"+strOutput.toString());
	return strOutput.toString();}
	
	/*GetConnection
	 * With URL Encoder Format
	 * 
	 * */
	public static String GetConnection(String httpUrl,String request,boolean UrlEncoder) throws Exception
	{
		String output = "";URL url=null;
		StringBuffer strOutput=new StringBuffer();
		try {
			
			if(UrlEncoder)
			{
			 url = new URL(httpUrl + "?"+ URLEncoder.encode(request, "UTF-8"));
			}
			else
			{
			 url = new URL(httpUrl + "?"+ request);
			}
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestProperty("Content-Type", "application/xml");
			Logger.log("*****Sending Request to --" + url);

			if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
				Logger.log("******************  Http Connection Ok   ******************");
				BufferedReader br = new BufferedReader(new InputStreamReader(
						(conn.getInputStream())));
				while ((output = br.readLine()) != null) {
					strOutput.append(Helper.correctNull(output));
				}

				Logger.log("************* Response from  CBS *************  "+"\n"+ strOutput);
				conn.disconnect();
				if (br != null)br.close();
			}
			Logger.log(conn.getResponseCode());

		} catch (ConnectException ce) {
			ce.printStackTrace();
			throw ce;
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw e;
		}
		return strOutput.toString();
	}
	
	

}
