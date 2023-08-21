package com.sai.laps.helper;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.Key;
import java.security.KeyFactory;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Security;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.MGF1ParameterSpec;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.HashMap;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.OAEPParameterSpec;
import javax.crypto.spec.PSource;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

import org.bouncycastle.jce.provider.BouncyCastleProvider;
public class KBLEncryption {
//	static {
//		Security.addProvider(new BouncyCastleProvider ());
//	}
	
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
			System.out.println("=================secretKey================"+secretKey.toString());
			System.out.println("=================secretKey getEncoded================"+secretKey.getEncoded());
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println("=================secretKey getEncoded================"+e.toString());
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
			
			byte[] message = new byte[12 + encrypted.length];
			byte iv[] = cipher.getIV();
			System.arraycopy(iv, 0, message, 0, 12);
			System.arraycopy(encrypted, 0, message, 12, encrypted.length);

			encryptedText = Base64.getEncoder().encodeToString(message);
			
			System.out.println("===============encryptedText=========="+encryptedText);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("========================="+e.toString());
		}
		
		return encryptedText;
	}
	
//	public static String getAESDecryptedData(String encryptedText,byte decKey[])
//	{
//		String plainText = null;
//	
//		try {
//			byte encd[] = Base64.getDecoder().decode(encryptedText);
//			SecretKeySpec aesKey = new SecretKeySpec(decKey, "AES");
//		
//			Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
//			GCMParameterSpec params = new GCMParameterSpec(128, encd, 0,12);
//			cipher.init(Cipher.DECRYPT_MODE, aesKey,params);
//	     
//			plainText = new String(cipher.doFinal(encd,12,encd.length - 12),"UTF-8");
//		}
//		catch(Exception e)
//		{
//			e.printStackTrace();
//		}
//		
//		return plainText;
//	}
	
	
//	private static PublicKey getPublicKeyFromFile(String publicKeyFile)throws Exception {
//		
//		InputStream publicKeyStream = null;
//		try {
//			publicKeyFile=ApplicationParams.getStrPostSancationEncryptionFile();
//			System.out.println("=================+publicKeyFile+======="+publicKeyFile);
//			publicKeyStream = new FileInputStream(new File(publicKeyFile));
//			CertificateFactory certFactory = CertificateFactory.getInstance("X.509");//, "BC");
//			return ((X509Certificate)certFactory.generateCertificate(publicKeyStream)).getPublicKey();
//		}
//		
//		finally {
//			if(publicKeyStream  != null)
//				publicKeyStream .close();
//		}
//	}
//	
	
	
	
	public static byte[] decryptAESKey(byte[] encryptedKey,String privateKeyFile,String filePassword)throws Exception
	{
		
		PrivateKey privateKey = getRSAprivaetKeys(privateKeyFile, filePassword.toCharArray());
		Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		
		
	//System.out.println("==========================="+cipher.doFinal(encryptedKey));
			
		return cipher.doFinal(encryptedKey);
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

	 public static PublicKey readPublicKey(String pkey)  {
         PublicKey publickey= null;
		try {
			byte[] encoded = Base64.getDecoder().decode(pkey);

			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			X509EncodedKeySpec keySpec = new X509EncodedKeySpec(encoded);
			publickey= (PublicKey) keyFactory.generatePublic(keySpec);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return publickey;
		
		}
	
	 public static PrivateKey  getPrivateKey(String pathtoprivatekey) {
		 PrivateKey  pk = null;
		 PrivateKey privateKey = null; 
	        try {
	        	//pathtoprivatekey=ApplicationParams.getStrPostSancationDecryptionFile();
	        	
	          //  String key = new String(Files.readAllBytes(Paths.get(pathtoprivatekey)), Charset.defaultCharset());
	            
	        //    String privateKeyPEM = key;
//	          	      .replace("-----BEGINCERTIFICATE-----", "")
//	          	      .replaceAll(System.lineSeparator(), "")
//	          	      .replace("-----ENDCERTIFICATE-----", "")
//	          	     .replaceAll("\\s", "");
	          	 
	            
	    /*   String privateKeyPEM = key
	      .replace("-----BEGIN PRIVATE KEY-----", "")
	      .replaceAll(System.lineSeparator(), "")
	      .replace("-----END PRIVATE KEY-----", "")
	     .replaceAll("\\s", "");*/
	 
	           //  byte[] encoded =  Base64.getDecoder().decode(privateKeyPEM.getBytes());
	             
	       //PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(Base64.getDecoder().decode(privateKeyPEM.getBytes()));
	        
	           /*  KeyFactory keyFactory = KeyFactory.getInstance("RSA");
	             /* PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(encoded);
	                  pk=(PrivateKey) keyFactory.generatePrivate(keySpec);*/
	          /*  ObjectInputStream inputStream = null;
	            inputStream = new ObjectInputStream(new FileInputStream(pathtoprivatekey));
			     
			       pk = (PrivateKey) inputStream.readObject();*/
			       
			       
//			       byte[] encoded = Base64.getDecoder().decode(pathtoprivatekey);
//
//					KeyFactory keyFactory = KeyFactory.getInstance("RSA");
//					X509EncodedKeySpec keySpec = new X509EncodedKeySpec(encoded);
//					pk= (PrivateKey) keyFactory.generatePrivate(keySpec);
					
	        	
	        	
	        	
	            KeyFactory keyFactory = null;
	            byte[] encoded = DatatypeConverter.parseBase64Binary(pathtoprivatekey);
	            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(encoded);
	            keyFactory = KeyFactory.getInstance("RSA");
	            privateKey = keyFactory.generatePrivate(keySpec);
	            

	        } catch (Exception e) {
	            e.printStackTrace();

	        }
	        return privateKey;
	    }

	public static String encryptAESKey(String publicKeyFile,byte []aesKey)throws Exception
	{
		
		System.out.println("=====publicKeyFile======"+publicKeyFile);
		Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPPadding");
		OAEPParameterSpec oaepParams = new OAEPParameterSpec( "SHA-256", "MGF1", MGF1ParameterSpec.SHA256, PSource.PSpecified.DEFAULT);
 
		cipher.init(Cipher.ENCRYPT_MODE, getPublicKeyFromFile(publicKeyFile),oaepParams);  
		
		
		System.out.println("=====publicKeyFile======"+Base64.getEncoder().encodeToString(cipher.doFinal(aesKey)));
		return Base64.getEncoder().encodeToString(cipher.doFinal(aesKey));
	}
	
	public static byte[] decryptAESKeyold(String encryptedKey,String privateKeyFile,String pass)throws Exception
	{
	
		//privateKeyFile=ApplicationParams.getStrPostSancationDecryptionFile();
		PrivateKey  privateKey =  getPrivateKey(privateKeyFile);
		Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPPadding");
		OAEPParameterSpec oaepParams = new OAEPParameterSpec( "SHA-256", "MGF1", MGF1ParameterSpec.SHA256, PSource.PSpecified.DEFAULT);

		cipher.init(Cipher.DECRYPT_MODE, privateKey,oaepParams);
	

		return cipher.doFinal(Base64.getDecoder().decode(encryptedKey));
		//------->there are getting error
	}
	
	public static String getAESDecryptedData(String encryptedText,byte decKey[])
	{
		String plainText = null;
	
		try {
			byte encd[] = Base64.getDecoder().decode(encryptedText);
			SecretKeySpec aesKey = new SecretKeySpec(decKey, "AES");
		
			Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
			GCMParameterSpec params = new GCMParameterSpec(128, encd, 0,12);
			cipher.init(Cipher.DECRYPT_MODE, aesKey,params);
	     
			plainText = new String(cipher.doFinal(encd,12,encd.length - 12),"UTF-8");
			System.out.println("plainText==========================="+plainText);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("============================================="+e.toString());
		}
		
		return plainText;
	}
	
//	public static byte[] decryptAESKey(byte[] encryptedKey,String privateKeyFile,String filePassword)throws Exception
//	{
//		
//		PrivateKey privateKey = getRSAprivaetKeys(privateKeyFile, filePassword.toCharArray());
//		Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
//		cipher.init(Cipher.DECRYPT_MODE, privateKey);
//		
//		
//	
//			
//		return cipher.doFinal(encryptedKey);
//	}
//	
	
	public static PrivateKey getRSAprivaetKeys(String private_key_file, char[] pass)
			throws Exception {
		HashMap<String, Object> keys = null;
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


	
	public static String decryptAESKeys(String publicKeyFile,byte []aesKey)throws Exception
	{
		
		System.out.println("=====publicKeyFile======"+publicKeyFile);
		Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPPadding");
		OAEPParameterSpec oaepParams = new OAEPParameterSpec( "SHA-256", "MGF1", MGF1ParameterSpec.SHA256, PSource.PSpecified.DEFAULT);
 
		cipher.init(Cipher.DECRYPT_MODE, getPrivateKey(publicKeyFile),oaepParams);  
		
		
		System.out.println("=====publicKeyFile======"+Base64.getDecoder().decode(cipher.doFinal(aesKey)));
		return new String(Base64.getDecoder().decode(cipher.doFinal(aesKey)));
	}
	
	public static String getAESDecryptedDatanew(String encryptedText,byte decKey[])
	
	{
		String plainText = null;
	
		try {
			byte encd[] = Base64.getDecoder().decode(encryptedText);
			SecretKeySpec aesKey = new SecretKeySpec(decKey, "AES");
		
			Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
			GCMParameterSpec params = new GCMParameterSpec(128, encd, 0,12);
			cipher.init(Cipher.DECRYPT_MODE, aesKey,params);
	     
			plainText = new String(cipher.doFinal(encd,12,encd.length - 12),"UTF-8");
			System.out.println("plainText==========================="+plainText);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("============================================="+e.toString());
		}
		
		return plainText;
	}
}


