package com.sai.laps.helper;

import java.security.Security;
import java.security.Signature;
import java.security.SignatureException;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.KeyStore;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Security;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Arrays;
import java.util.Base64;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

import java.security.cert.Certificate;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;

import org.bouncycastle.jce.provider.BouncyCastleProvider;

import sun.misc.BASE64Encoder;
import org.apache.commons.io.IOUtils;
public class KblEncyrptionDecyrption {
	
	 private static final String ENCODING = "UTF-8";
	    private static final String HEADER_ENC_ALGO = "RSA/ECB/OAEPPADDING";
	    private static final String SIGNATURE = "SHA256withRSA";
	    private static final String SEPARATOR = ":";
	    private static final String ALGO_AES = "AES";
	    private static final String ALGO_RSA = "RSA";
	
	static {
	    //addBCProvider();
		System.out.println("=================");
	    Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
	    System.out.println("++++++++++++++++++++++end++++++++++=");
	}
	public static void addBCProvider() {
	    // java.security.NoSuchProviderException: no such provider: BC
	    if (Security.getProvider(org.bouncycastle.jce.provider.BouncyCastleProvider.PROVIDER_NAME) == null) {
	        System.out.println("JVM Installing BouncyCastle Security Providers to the Runtime");
	        Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
	    } else {
	        System.out.println("JVM Installed with BouncyCastle Security Providers");
	    }
	}
	
	
	public static byte[] generateAESKey() 
	{
		SecretKey secretKey = null;
		try {
			KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
			keyGenerator.init(256);
			secretKey = keyGenerator.generateKey();
			//System.out.println("secretKey encoded======>"+secretKey.getEncoded().toString());
			//System.out.println("secretKey decoded======>"+Base64.getDecoder().decode(secretKey.getEncoded()));
		} 
		catch (Exception e) 
		{
		System.out.println("Exception in generateAESKey====="+e.toString());
		}
		
		return secretKey.getEncoded();
	}
	
	public static String getAESEncryptedData(String plainText, byte []aesKey)
	{
		String encryptedText = null; 
	
		try {
			
			SecretKeySpec key = new SecretKeySpec(aesKey, "AES");
			Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
			GCMParameterSpec params = new GCMParameterSpec(128,plainText.getBytes() , 0,12);
			cipher.init(Cipher.ENCRYPT_MODE, key,params);

			byte[] encrypted = cipher.doFinal(plainText.getBytes("UTF-8"));
			System.out.println("encrypted======>"+encrypted);
			byte[] message = new byte[12 + encrypted.length];
			System.out.println("message======>"+message);
			byte iv[] = cipher.getIV();
			System.out.println("iv======>"+iv);
			System.arraycopy(iv, 0, message, 0, 12);
			System.arraycopy(encrypted, 0, message, 12, encrypted.length);
			System.out.println("encrypted before= message=====>"+message);
			encryptedText = Base64.getEncoder().encodeToString(message);
			System.out.println("encryptedText======>"+encryptedText);
		}
		catch(Exception e)
		{
			System.out.println("Exception in getAESEncryptedData ======>"+e.toString());	
		}
		
		return encryptedText;
	}
	
	public static String getAESDecryptedData(String encryptedText,byte decKey[])
	{
		String plainText = null;
	
		try {
			//byte encd[] = Base64.getDecoder().decode(encryptedText);
			byte encd[] = encryptedText.getBytes();
			System.out.println("encd ======>"+encd);
			SecretKeySpec aesKey = new SecretKeySpec(decKey, "AES");
		
			Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
			GCMParameterSpec params = new GCMParameterSpec(128, encd, 0,12);
			cipher.init(Cipher.DECRYPT_MODE, aesKey,params);
	     
			plainText = new String(cipher.doFinal(encd,12,encd.length - 12),"UTF-8");
			System.out.println("plainText ======>"+plainText);
		}
		catch(Exception e)
		{
			System.out.println("Exception in getAESDecryptedData ======>"+e.toString());	
		}
		
		return plainText;
	}
	
	
	private static PublicKey getPublicKeyFromFile(String publicKeyFile)throws Exception {
		
		InputStream publicKeyStream = null;
		try {
			publicKeyStream = new FileInputStream(new File(publicKeyFile));
			CertificateFactory certFactory = CertificateFactory.getInstance("X.509");//, "BC");
			return ((X509Certificate)certFactory.generateCertificate(publicKeyStream)).getPublicKey();
		}
		
		finally {
			if(publicKeyStream  != null)
				publicKeyStream .close();
		}
	}
	
	public static PrivateKey getRSAprivaetKeys(String private_key_file, char[] pass)
			throws Exception {
		Map<String, Object> keys = null;
		PrivateKey privateKey=null;
		try {
//			BouncyCastleProvider provider = new BouncyCastleProvider();
//			Security.addProvider(provider);
//			KeyStore ks = KeyStore.getInstance("PKCS12", provider.getName());
//			ks.load(new FileInputStream(private_key_file), pass);
//											
//			String alias = (String) ks.aliases().nextElement();
//			 privateKey = (PrivateKey) ks.getKey(alias, pass);
//			 System.out.println(privateKey);
//
//			keys = new HashMap<String, Object>();
//			keys.put("private", privateKey);
			//BASE64Encoder b64 = new BASE64Encoder();
			String privatekey1="";
			//String strprivateKeyfile="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";
			//private_key_file=strprivateKeyfile;
			
			
			System.out.println("privateKey ================> \n");
			BouncyCastleProvider provider = new BouncyCastleProvider();
			System.out.println("BouncyCastleProvider ================> \n");
			Security.addProvider(provider);
			System.out.println("Security ================> \n");
			KeyStore ks = KeyStore.getInstance("PKCS12", provider.getName());
			System.out.println("KeyStore ================> \n");
			//InputStream readStream = new FileInputStream(private_key_file);
			//ks.store(writeStream, pass);
			//writeStream.close();
			//ks.load(readStream, pass);ks.load(new FileInputStream(strprivateKeyfile), pwd);
			ks.load(new FileInputStream(private_key_file), pass);
			System.out.println("ks.load ================> \n");
			BASE64Encoder b64 = new BASE64Encoder();
			String alias = (String) ks.aliases().nextElement();
			System.out.println("alias ================> \n");
			privateKey = (PrivateKey) ks.getKey(alias, pass);
			System.out.println("getKey ================> \n");
			privatekey1=(b64.encode(privateKey.getEncoded()));
			
			
//			String alias = (String) ks.aliases().nextElement();
//			System.out.println("alias ================> \n");s
			//privateKey = (PrivateKey) ks.getKey(alias, pass);
			//System.out.println("getKey ================> \n");
			//privatekey1=(b64.encode(privateKey.getEncoded()));
			keys = new HashMap<String, Object>();
			keys.put("private", privateKey);
			
		} catch (Exception e) {
			System.out.println("Error:" + e.getMessage());
			keys.put("Error", e.getMessage());
		}
		return privateKey;
	}
	
	
	public static String encryptAESKey(String publicKeyFile,byte []aesKey)throws Exception
	{
		Cipher cipher = null;
		try
		{
		PublicKey pubkey = getPublicKeyFromFile(publicKeyFile);
		 cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");   
		cipher.init(Cipher.ENCRYPT_MODE, pubkey);  
		System.out.println("==============encyrption========================"+Base64.getEncoder().encodeToString(cipher.doFinal(aesKey)));
		
		
		}
		catch(Exception e)
		{
		System.out.println("Exception is encryptAESKey====="+e.toString())	;
		}
		return Base64.getEncoder().encodeToString(cipher.doFinal(aesKey));
	}
	
	public static byte[] decryptAESKey(byte[] encryptedKey,String privateKeyFile,String filePassword)throws Exception
	{
		Cipher cipher = null;
		try
		{
		PrivateKey privateKey = getRSAprivaetKeys(privateKeyFile, filePassword.toCharArray());
		 cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		System.out.println("==============decyrption========================"+cipher.doFinal(encryptedKey));
		
		}
		catch(Exception e)
		{
			System.out.println("Exception is decryptAESKey====="+e.toString())	;	
		}
	
			
		return cipher.doFinal(encryptedKey);
	}
	
	
	 public static String decryptwhole(String encText, String privateKey, String publicKey,String EncyrptedAesSessionKey)
	            throws Exception {

	        /*String split[] = new String(Base64.getDecoder().decode(encText)).split(SEPARATOR);
	        System.out.println("one======split[]=======");
	        String headerKey = split[0];
	        System.out.println("one======headerKey======="+headerKey);
	        String encryptionRequestBody = split[1];
	        System.out.println("one======encryptionRequestBody======="+encryptionRequestBody);
	        String digitalSignature = split[2];
	        System.out.println("one======digitalSignature======="+digitalSignature);*/
	        String decryptedHeader =EncyrptedAesSessionKey; //decryptHeader(headerKey, privateKey);
	        System.out.println("one======decryptedHeader======="+decryptedHeader);
	        String encryptionRequestBody="";
	        String decrypt = decSignSHA256RSAnew(encText, SIGNATURE, publicKey);
	        System.out.println("one======decrypt======="+decrypt);
	        
	         decrypt = decSignSHA256RSA(encText, SIGNATURE, publicKey);
	        System.out.println("two======decrypt======="+decrypt);
	        
	        
	        byte[] aesKey = decryptedHeader.getBytes();
	        System.out.println("one======aesKey======="+aesKey);
	        byte[] iv = getIVFromAESKey(aesKey);
	        System.out.println("one======iv==getIVFromAESKey====="+iv);
	      //  return decryptRequestBody(Base64.getDecoder().decode(decrypt), decryptedHeader.getBytes(), iv);
	        return decryptRequestBody(org.apache.commons.codec.binary.Base64.encodeBase64String(encText.getBytes()), decryptedHeader.getBytes(), iv);

	        

	    }  
	 
	 public static String decryptRequestBody(String cipherText, byte[] key, byte[] IV)
	            throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, NoSuchProviderException {

	        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
	        SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
	        GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(16 * 8, IV);
	        cipher.init(Cipher.DECRYPT_MODE, keySpec, gcmParameterSpec);
	        byte[] decryptedText = cipher.doFinal(cipherText.getBytes());
	        return new String(decryptedText);
	    }
	 
	 
	 public static String decSignSHA256RSA(String encryptionRequestBody, String digitalSignature, String strPk)
	            throws Exception {

	        String k = strPk.replaceAll("\n", "").replace("\r", "");
	        Signature privateSignature = Signature.getInstance(SIGNATURE);
	       // privateSignature.initVerify(getPublicKey(k));
	        privateSignature.initVerify(getPublicKeyFromFile(ApplicationParams.getStrPostSancationEncryptionFile()));//k));
	        byte[] bytes = encryptionRequestBody.getBytes(ENCODING);
	        privateSignature.update(bytes);
	        privateSignature.verify(Base64.getDecoder().decode(digitalSignature));
	        return encryptionRequestBody;
	    }
	 
	 
	 public static PublicKey getPublicKey(String publicKeyStr) {

	        PublicKey publicKey = null;
	        try {
	            CertificateFactory certificateFactory = CertificateFactory.getInstance("X.509");
	            BufferedReader br = new BufferedReader(new StringReader(publicKeyStr));
	            String line = null;
	            StringBuilder keyBuffer = new StringBuilder();
	            while ((line = br.readLine()) != null) {
	                if (!line.startsWith("-")) {
	                    keyBuffer.append(line);
	                }
	            }
	            Certificate certificate = certificateFactory
	                    .generateCertificate(new ByteArrayInputStream(Base64.getDecoder().decode(keyBuffer.toString())));
	           
	            publicKey = certificate.getPublicKey();
	        } catch (Exception var8) {
	            var8.printStackTrace();
	        }
	        return publicKey;
	    }
	 public static String decryptHeader(String data, String privatekey) throws NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidKeyException, InvalidKeySpecException {

	        byte[] encryptedData = Base64.getDecoder().decode(data);
	        PrivateKey privateKey = getPrivateKey(privatekey);
	        Cipher cipher = Cipher.getInstance(HEADER_ENC_ALGO);
	        cipher.init(Cipher.DECRYPT_MODE, privateKey);
	        byte[] encryptedByte = cipher.doFinal(encryptedData);
	        return new String(encryptedByte);
	    }

	    public static byte[] getIVFromAESKey(byte[] encoded) {
	        return Arrays.copyOfRange(encoded, 0, 16);
	    }
	    
	    public static PrivateKey getPrivateKey(String privateKeyStr) throws NoSuchAlgorithmException, InvalidKeySpecException {

	        PrivateKey privateKey = null;
	        KeyFactory keyFactory = null;
	        byte[] encoded = DatatypeConverter.parseBase64Binary(privateKeyStr);
	        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(encoded);
	        keyFactory = KeyFactory.getInstance(ALGO_RSA);
	        privateKey = keyFactory.generatePrivate(keySpec);
	        return privateKey;
	    }
	    
	    
	    public static String signSHA256RSA(String input, String strPk) throws Exception {
	        // Remove markers and new line characters in private key
	        String realPK = strPk.replaceAll("-----END PRIVATE KEY-----", "")
	                             .replaceAll("-----BEGIN PRIVATE KEY-----", "")
	                             .replaceAll("\n", "");
	 
	        byte[] b1 = Base64.getDecoder().decode(realPK);
	        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(b1);
	        KeyFactory kf = KeyFactory.getInstance("RSA");
	 
	        Signature privateSignature = Signature.getInstance("SHA256withRSA");
	        privateSignature.initSign(kf.generatePrivate(spec));
	        privateSignature.update(input.getBytes("UTF-8"));
	        byte[] s = privateSignature.sign();
	        return Base64.getEncoder().encodeToString(s);
	    }
	    
	    public static byte[] decryptAESKeylatest(byte[] encryptedKey,String privateKeyFile,String filePassword)throws Exception
		{
			
			PrivateKey privateKey = getRSAprivaetKeyslatest(privateKeyFile, filePassword.toCharArray());
			Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
			cipher.init(Cipher.DECRYPT_MODE, privateKey);
			
			
		
				
			return cipher.doFinal(encryptedKey);
		}
	    
	    public static PrivateKey getRSAprivaetKeyslatest(String private_key_file, char[] pass)
				throws Exception {
			Map<String, Object> keys = null;
			PrivateKey privateKey=null;
			try {
				//private_key_file="D:/API/Plainuatpvt.key";
				BouncyCastleProvider provider = new BouncyCastleProvider();
				Security.addProvider(provider);
				KeyStore ks = KeyStore.getInstance("PKCS12", provider.getName());
				ks.load(new FileInputStream(private_key_file), pass);
												
				String alias = (String) ks.aliases().nextElement();
				 privateKey = (PrivateKey) ks.getKey(alias, pass);
				 System.out.println(privateKey);

				keys = new HashMap<String, Object>();
				keys.put("private", privateKey);
			} catch (Exception e) {
				System.out.println("Error:" + e.getMessage());
				keys.put("Error", e.getMessage());
			}
			return privateKey;
		}
	    
	    public static String getAESDecryptedDatalatest(String encryptedText,byte decKey[])
		{
			String plainText = null;
		
			try {
				byte encd[] = Base64.getDecoder().decode(encryptedText);
				SecretKeySpec aesKey = new SecretKeySpec(decKey, "AES");
			
				Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
				GCMParameterSpec params = new GCMParameterSpec(128, encd, 0,12);
				cipher.init(Cipher.DECRYPT_MODE, aesKey,params);
		     
				plainText = new String(cipher.doFinal(encd,12,encd.length - 12),"UTF-8");
			}
			catch(Exception e)
			{
				
			}
			
			return plainText;
		}
	    
	    public static String DecryptDatanew(String header,String body, String publicfiledata,String privatefiledata,String password) throws Exception
	    {
			String plainRequest="",decryptdata="";
			try 
			{
//				StringWriter strwrt = new StringWriter();
//				IOUtils.copy(inputStream, strwrt,StandardCharsets.UTF_8);
//				plainRequest= strwrt.toString();
				
				//plainRequest = Helper.correctNull(inputStream);
				System.out.println("getNationalPortalDecryptData plainRequest Text : " + plainRequest);
				
				
				
				String privatekey1="", publicKey="",strprivateKeyfile="",strprivate_key_req="";
				
				BASE64Encoder b64 = new BASE64Encoder();
				strprivate_key_req ="no"; //Helper.correctNull(serviceProvider.getNpCommonPropertyService().findByNcpApiNameAndNcpKey("NP", "private_key_req").getNcpValue());
				strprivateKeyfile =privatefiledata;// Helper.correctNull(serviceProvider.getNpCommonPropertyService().findByNcpApiNameAndNcpKey("NP", "private_key")
						//.getNcpValue());
				publicKey =publicfiledata;// Helper.correctNull(serviceProvider.getNpCommonPropertyService().findByNcpApiNameAndNcpKey("NP", "public_key")
						//.getNcpValue());
				String strNeslPasswordKey = password; //Helper.correctNull(serviceProvider.getNpCommonPropertyService().findByNcpApiNameAndNcpKey("NP", "password")
						//.getNcpValue());
				
				System.out.println("publicKey Text : " + publicKey);
				
				char[] pwd = strNeslPasswordKey.toCharArray();
				System.out.println("strprivateKeyfile ================> \n"+strprivateKeyfile+"<<<pwd>>>"+pwd);
				if(strprivate_key_req != null && strprivate_key_req.equalsIgnoreCase("yes"))
				{
					privatekey1 = strprivateKeyfile;
					System.out.println("strprivateKeyfile privatekey1================> \n"+privatekey1);
				} else {
					try 
					{
						PrivateKey privateKey=null;
						System.out.println("privateKey ================> \n");
						BouncyCastleProvider provider = new BouncyCastleProvider();
						System.out.println("BouncyCastleProvider ================> \n");
						Security.addProvider(provider);
						System.out.println("Security ================> \n");
						KeyStore ks = KeyStore.getInstance("PKCS12", provider.getName());
						System.out.println("KeyStore ================> \n");
						strprivateKeyfile=ApplicationParams.getStrPostSancationDecryptionFile();
						ks.load(new FileInputStream(strprivateKeyfile), pwd);
						System.out.println("ks.load ================> \n");
						String alias = (String) ks.aliases().nextElement();
						System.out.println("alias ================> \n");
						privateKey = (PrivateKey) ks.getKey(alias, pwd);
						System.out.println("getKey ================> \n");
						privatekey1=(b64.encode(privateKey.getEncoded()));
					} catch (Exception ej) {
						ej.printStackTrace();
						System.out.println("getNationalPortalDecryptData Exception in reading private key ================> \n");
						return decryptdata = "Exception in reading private key";
					}
				}

			    System.out.println("getRSAprivaetKeys ================> \n"+privatekey1);
				
				//NationalPortalDecryptApi NationalPortalDecryptdata = new NationalPortalDecryptApi();
				System.out.println("getNationalPortalDecryptData.decrypt starts ================> \n");
				 decryptdata=decryptnew(header,body, privatekey1, publicKey);
				System.out.println("getNationalPortalDecryptData.decrypt Ends ================> \n");
				System.out.println("getNationalPortalDecryptData decryptdata Text : " + decryptdata);
			} catch (IOException e) {
				e.printStackTrace();
				return decryptdata= "Exception in getNationalPortalDecryptData";
			}
			return decryptdata;
			
	    }
	    public static String decryptnew(String encTextheader,String encTextboby, String privateKey, String publicKey)
	            throws Exception {

	        
	        String headerKey = encTextheader;
	        System.out.println("one======headerKey======="+headerKey);
	        String encryptionRequestBody = encTextboby;
	        System.out.println("one======encryptionRequestBody======="+encryptionRequestBody);
	        String digitalSignature = SIGNATURE;
	        System.out.println("one======digitalSignature======="+digitalSignature);
	        String decryptedHeader = decryptHeader(headerKey, privateKey);
	        System.out.println("one======decryptedHeader======="+decryptedHeader);
	        String decrypt = decSignSHA256RSAnew(encryptionRequestBody, digitalSignature, publicKey);
	        System.out.println("one======decrypt======="+decrypt);
	        byte[] aesKey = decryptedHeader.getBytes();
	        System.out.println("one======aesKey======="+aesKey);
	        byte[] iv = getIVFromAESKey(aesKey);
	        System.out.println("one======iv==getIVFromAESKey====="+iv);
	        //return decryptRequestBody(Base64.getDecoder().decode(decrypt), decryptedHeader.getBytes(), iv);
	        return decryptRequestBody(org.apache.commons.codec.binary.Base64.encodeBase64String(decrypt.getBytes()), decryptedHeader.getBytes(), iv);

	        

	    }

	    public static String decSignSHA256RSAnew(String encryptionRequestBody, String digitalSignature, String strPk)
	            throws Exception {
	    	//strPk=ApplicationParams.getStrPostSancationDecryptionFile();
	        String k = strPk.replaceAll("\n", "").replace("\r", "");
	        Signature privateSignature = Signature.getInstance(SIGNATURE);
	        privateSignature.initVerify(getPublicKey(k));
	        //privateSignature.initVerify(getPublicKeyFromFile(strPk));
	        byte[] bytes = encryptionRequestBody.getBytes(ENCODING);
	        privateSignature.update(bytes);
	        privateSignature.verify(Base64.getDecoder().decode(digitalSignature));
	        return encryptionRequestBody;
	    }
	    
	    
	    public static String signSHA256RSANew(String input, String privateKeyStr) throws NoSuchAlgorithmException,
	    InvalidKeyException, InvalidKeySpecException, SignatureException, UnsupportedEncodingException {

	        byte[] b1 = DatatypeConverter.parseBase64Binary(privateKeyStr);
	        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(b1);
	        KeyFactory kf = KeyFactory.getInstance(ALGO_RSA);
	        Signature privateSignature = Signature.getInstance(SIGNATURE);
	        privateSignature.initSign(kf.generatePrivate(spec));
	        byte[] bytes = input.getBytes(ENCODING);
	        privateSignature.update(bytes);
	        byte[] s = privateSignature.sign();
	       // return Base64.getEncoder().encodeToString(s);
	        return org.apache.commons.codec.binary.Base64.encodeBase64String(s);
	    }
	    
	    
	    public static String getAESDecryptedDatalatnew(String encryptedText,byte decKey[])
		{
			String plainText = null;
		
			try {
				byte encd[] = Base64.getDecoder().decode(encryptedText);
				SecretKeySpec aesKey = new SecretKeySpec(decKey, "AES");
			
				Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
				GCMParameterSpec params = new GCMParameterSpec(128, encd, 0,12);
				cipher.init(Cipher.DECRYPT_MODE, aesKey,params);
		     
				plainText = new String(cipher.doFinal(encd,12,encd.length - 12),"UTF-8");
			}
			catch(Exception e)
			{
				
			}
			
			return plainText;
		}
	    
	    
	    public static byte[] decryptAESKeylatnew(byte[] encryptedKey,String privateKeyFile,String filePassword)throws Exception
		{
			
			PrivateKey privateKey = getRSAprivaetKeyslatnew(privateKeyFile, filePassword.toCharArray());
			Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
			cipher.init(Cipher.DECRYPT_MODE, privateKey);
			
			
		
				
			return cipher.doFinal(encryptedKey);
		}
	    
	    public static PrivateKey getRSAprivaetKeyslatnew(String private_key_file, char[] pass)
				throws Exception {
			Map<String, Object> keys = null;
			PrivateKey privateKey=null;
			try {
				BouncyCastleProvider provider = new BouncyCastleProvider();
				Security.addProvider(provider);
				KeyStore ks = KeyStore.getInstance("PKCS12", provider.getName());
				ks.load(new FileInputStream(private_key_file), pass);
												
				String alias = (String) ks.aliases().nextElement();
				 privateKey = (PrivateKey) ks.getKey(alias, pass);
				 System.out.println(privateKey);

				keys = new HashMap<String, Object>();
				keys.put("private", privateKey);
			} catch (Exception e) {
				System.out.println("Error:" + e.getMessage());
				keys.put("Error", e.getMessage());
			}
			return privateKey;
		}
	    
	    
	    public static String decryptHeadernow(String data, String privatekey) throws NoSuchAlgorithmException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, InvalidKeyException, InvalidKeySpecException {

	        byte[] encryptedData = Base64.getDecoder().decode(data);
	        PrivateKey privateKey = getPrivateKeynow(privatekey);
	       // Cipher cipher = Cipher.getInstance(HEADER_ENC_ALGO);
	        Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
	        cipher.init(Cipher.DECRYPT_MODE, privateKey);
	        byte[] encryptedByte = cipher.doFinal(encryptedData);
	        return new String(encryptedByte);
	    }

	    public static byte[] getIVFromAESKeynow(byte[] encoded) {
	        return Arrays.copyOfRange(encoded, 0, 16);
	    }

	    public static PrivateKey getPrivateKeynow(String privateKeyStr) throws NoSuchAlgorithmException, InvalidKeySpecException {

	        PrivateKey privateKey = null;
	        KeyFactory keyFactory = null;
	        byte[] encoded = DatatypeConverter.parseBase64Binary(privateKeyStr);
	        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(encoded);
	        keyFactory = KeyFactory.getInstance(ALGO_RSA);
	        privateKey = keyFactory.generatePrivate(keySpec);
	        return privateKey;
	    }
	    
	    
	    public static PrivateKey getRSAprivaetKeys1(String private_key_file, char[] pass)
				throws Exception {
			Map<String, Object> keys = null;
			PrivateKey privateKey=null;
			try {
				BouncyCastleProvider provider = new BouncyCastleProvider();
				Security.addProvider(provider);
				KeyStore ks = KeyStore.getInstance("PKCS12", provider.getName());
				ks.load(new FileInputStream(private_key_file), pass);
												
				String alias = (String) ks.aliases().nextElement();
				 privateKey = (PrivateKey) ks.getKey(alias, pass);
				 System.out.println(privateKey);

				keys = new HashMap<String, Object>();
				keys.put("private", privateKey);
			} catch (Exception e) {
				System.out.println("Error:" + e.getMessage());
				keys.put("Error", e.getMessage());
			}
			return privateKey;
		}
	    
	    /////////////////////////26122022///////////////////////
	    
	    public static String decrypt(String encText, String privateKey, String publicKey)
	            throws Exception {

	      //  String split[] = new String(Base64.getDecoder().decode(encText)).split(SEPARATOR);
			
			String split[] = (encText.split(SEPARATOR));
			
			
	        System.out.println("one======split[]=======");
	        String headerKey = split[0];
	        System.out.println("one======headerKey======="+headerKey);
	        String encryptionRequestBody = split[1];
	        System.out.println("one======encryptionRequestBody======="+encryptionRequestBody);
	        String digitalSignature = split[2];
	        System.out.println("one======digitalSignature======="+digitalSignature);
	        String decryptedHeader =decryptHeader(headerKey, privateKey);
	        System.out.println("one======decryptedHeader======="+decryptedHeader);
	      //  String decrypt = decSignSHA256RSA(encryptionRequestBody, digitalSignature, publicKey);
	        String decrypt = decSignSHA256RSAnew(encryptionRequestBody, digitalSignature, publicKey);
	        
	        System.out.println("one======decrypt======="+decrypt);
	        byte[] aesKey = decryptedHeader.getBytes();
	        System.out.println("one======aesKey======="+aesKey);
	        byte[] iv = getIVFromAESKey(aesKey);
	        System.out.println("one======iv==getIVFromAESKey====="+iv);
	       // return decryptRequestBody(Base64.getDecoder().decode(decrypt), decryptedHeader.getBytes(), iv);
	        
	        return decryptRequestBody(org.apache.commons.codec.binary.Base64.encodeBase64String(encText.getBytes()), decryptedHeader.getBytes(), iv);

	    }

	}

