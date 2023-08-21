package com.sai.laps.ejb.loaninterestrate;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;


import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.net.ssl.HttpsURLConnection;

import org.apache.log4j.Logger;

import com.sai.laps.ejb.authenticate.AuthenticateBean;
import com.sai.laps.ejb.authenticate.AuthenticateRemote;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.BeanAdapter;
import com.sai.laps.helper.KBLEncryption;

@Stateless(name = "LoanInterestRateBean", mappedName = "LoanInterestRateHome")
@Remote (LoanInterestRateRemote.class)
public class LoanInterestRateBean extends BeanAdapter {

	private static final long serialVersionUID = 1L;
	static Logger log=Logger.getLogger(AuthenticateBean.class);
	
	public HashMap checkLoanInterestModify(HashMap hshRequestValues)
	{
		HashMap hshRequest= new HashMap();
		try
		{
		String strRequest="",ReqUUID="",ServiceReqId="",strVersionId="10.2",strChannelId="CRM",strBankId="01",StrMessageDateTime="2012-10-02T14:14:27.262";
		String StrCustId="114021219",strAppurl="",strResponse="";
		strRequest="<FIXML xsi:schemaLocation=\"http://www.finacle.com/fixml AcctTrnInq.xsd\" xmlns=\"http://www.finacle.com/fixml\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">"+
			"<Header>"+
			"<RequestHeader>"+
			"<MessageKey>"+
			"<RequestUUID>"+ReqUUID+"</RequestUUID>"+
			"<ServiceRequestId>"+ServiceReqId+"</ServiceRequestId>"+
			"<ServiceRequestVersion>"+strVersionId+"</ServiceRequestVersion>"+
			"<ChannelId>"+strChannelId+"</ChannelId>"+
			"</MessageKey>"+
			"<RequestMessageInfo>"+
			"<BankId>"+strBankId+"</BankId>"+
			"<TimeZone></TimeZone>"+
			"<EntityId></EntityId>"+
			"<EntityType></EntityType>"+
			"<ArmCorrelationId></ArmCorrelationId>"+
			"<MessageDateTime></MessageDateTime>"+
			"</RequestMessageInfo>"+
			"<Security>"+
			"<Token>"+
			"<PasswordToken>"+
			"<UserId></UserId>"+
			"<Password></Password>"+
			"</PasswordToken>"+
			"</Token>"+
			"<FICertToken></FICertToken>"+
			"<RealUserLoginSessionId></RealUserLoginSessionId>"+
			"<RealUser></RealUser>"+
			"<RealUserPwd></RealUserPwd>"+
			"<SSOTransferToken></SSOTransferToken>"+
			"</Security>"+
			"</RequestHeader>"+
			"</Header>"+
			"<Body>"+
			"<CustInqRequest>"+
			"<CustInqRq>"+
			"<CustId>"+StrCustId+"</CustId>"+
			"</CustInqRq>"+
			"<CustInq_CustomData/>"+
			"</CustInqRequest>"+
			"</Body>"+
			"</FIXML>";
		
		byte[] Sessionkey=KBLEncryption.generateAESKey();
		String EncyrptedAesSessionKey=KBLEncryption.encryptAESKey(ApplicationParams.getStrPostSancationEncryptionFile(), Sessionkey);
		
		String strEncyrpteddata=KBLEncryption.getAESEncryptedData(strRequest, Sessionkey);   //strRequest
		
		String encrequest="<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
		"<xenc:EncryptedData Type=\"http://www.w3.org/2001/04/xmlenc#Element\""+
	   " xmlns:xenc=\"http://www.w3.org/2001/04/xmlenc#\">"+
	    "<xenc:EncryptionMethod Algorithm=\"http://www.w3.org/2009/xmlenc11#aes256-gcm\"/>"+
	    "<dsig:KeyInfo xmlns:dsig=\"http://www.w3.org/2000/09/xmldsig#\">"+
	        "<xenc:EncryptedKey>"+
	            "<xenc:EncryptionMethod Algorithm=\"http://www.w3.org/2009/xmlenc11#rsa-oaep\">"+
	               " <dsig:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/>"+
	               " <xenc:OAEPparams/>"+
	                "<xenc:MGFAlgorithm Algorithm=\"http://www.w3.org/2009/xmlenc11#mgf1sha256\"/>"+
	            "</xenc:EncryptionMethod>"+
	            "<dsig:KeyInfo>"+
	               " <dsig:KeyName>pronteff_sha</dsig:KeyName>"+
	           " </dsig:KeyInfo>"+
	           " <xenc:CipherData>"+
	                "<xenc:CipherValue>"+EncyrptedAesSessionKey+"+</xenc:CipherValue>"+
	            "</xenc:CipherData>"+
	       " </xenc:EncryptedKey>"+
	   " </dsig:KeyInfo>"+
	   " <xenc:CipherData>"+
	        "<xenc:CipherValue>"+strEncyrpteddata+"</xenc:CipherValue>"+
	   " </xenc:CipherData>"+
	"</xenc:EncryptedData>";

		
		strAppurl="https://apiuat.ktkbank.com:8443/non-production/development/fi-lintmodify/filint";
		
		URL url;
		HttpsURLConnection connection;
		InputStream is = null;
		Date connectionStartTime=null;

		String ip=strAppurl;
		url = new URL(ip);
		log.debug("URL=======================>"+ip);
		log.debug("Request=======================>"+encrequest);
		
		
		connection = (HttpsURLConnection) url.openConnection();
		connection.setRequestMethod("POST");
		connection.setRequestProperty("Content-Type","application/xml");
		//connection.setRequestProperty("SOAPAction","CBLosLoanCreation:CBLosLoanCreationRqstMsg");
		//en-US,en;q=0.5   Accept-Language
		connection.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
		//connection.setUseCaches (false);
		//connection.setDoInput(true);
		connection.setDoOutput(true);
		
		System.out.println("====before outputStream======");
		OutputStream os = connection.getOutputStream();
		System.out.println("====after outputStream======");
		OutputStreamWriter osw = new OutputStreamWriter(os);
		System.out.println("====after OutputStreamWriter======");
		osw.write(encrequest);//strRequest);
		osw.flush();
		connectionStartTime=new Date();
		System.out.println("::Request Sent At: " + connectionStartTime);
		System.out.println("::Request Data: "+ strRequest);
		osw.close();
		is =connection.getInputStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(is));	
		String strResponseLine="";
		while((strResponseLine = br.readLine()) != null)
		{
			strResponse+=strResponseLine;
		}if(br!=null)br.close();

		System.out.println("Output================>"+strResponse);
		is.close();
		connection.disconnect();
		
		/*local file reader
	
		BufferedReader br1 = null;
		FileReader fr1 = null;
		String ResponseXML="";
		
		fr1 = new FileReader("E:\\LoanCreationResponse.xml");
		br1 = new BufferedReader(fr1);	
		
		StringBuilder sb1 = new StringBuilder();
	    String line = br1.readLine();
	    
		while(line != null) {
			sb1.append(line);
			line = br1.readLine();
			//System.out.println(line);
		}
		strResponse=sb1.toString();
		System.out.println("=========>"+strResponse);*/
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			
		}
		return hshRequest;
	}
	
	
	
	
	
}