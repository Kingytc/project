package com.sai.laps.helper;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStream;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
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
import java.util.Arrays;
import java.util.Base64;
import java.util.Scanner;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.OAEPParameterSpec;
import javax.crypto.spec.PSource;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;



public class PostSanctionAPIdecyrptfile {
	static {
	    
		System.out.println("=================");
	    Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
	    System.out.println("++++++++++++++++++++++end++++++++++=");
	}
	public static void addBCProvider() {
	    
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
		} 
		catch (Exception e) 
		{
			
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
		}
		catch(Exception e)
		{
			
		}
		
		return encryptedText;
	}
	
	
	private static byte[] getIVFromAESKey(byte[] encoded) {
        return Arrays.copyOfRange(encoded, 0, 16);
    }
	
	public static String getAESDecryptedData(String encryptedText,byte decKey[])
	{
		String plainText = null;
		byte[] decryptedText = null;
		
		try {
			byte encd[] = Base64.getDecoder().decode(encryptedText);
			 SecretKeySpec aesKey = new SecretKeySpec(decKey, "AES");
			
		
			Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
			
			
			
			 byte[] iv = getIVFromAESKey(decKey);
			 
			
		        GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(128, encd, 0,12);
		        cipher.init(Cipher.DECRYPT_MODE, aesKey, gcmParameterSpec);
		         decryptedText = cipher.doFinal(encd);

			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return new String(decryptedText);
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
			// TODO: handle exception
		}
		return publickey;
		
		}
	
	 public static PrivateKey  getPrivateKey(String pathtoprivatekey) {
		 PrivateKey  pk = null;
	        
	        try {
	         	
	 	       String privateKeyPEM = pathtoprivatekey
	 	      .replace("-----BEGIN PRIVATE KEY-----", "")
	 	      .replaceAll(System.lineSeparator(), "")
	 	      .replace("-----END PRIVATE KEY-----", "")
	 	     .replaceAll("\\s", "");
	 	 
	 	             byte[] encoded =  Base64.getDecoder().decode(privateKeyPEM.getBytes());
	 	        
	 	             KeyFactory keyFactory = KeyFactory.getInstance("RSA");
	 	              PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(encoded);
	 	                  pk=(PrivateKey) keyFactory.generatePrivate(keySpec);
					

	        } catch (Exception e) {
	            e.printStackTrace();

	        }
	        return pk;
	    }

	public static String encryptAESKey(String publicKeyFile,byte []aesKey)throws Exception
	{
		
		
		Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPPadding");
		OAEPParameterSpec oaepParams = new OAEPParameterSpec( "SHA-256", "MGF1", MGF1ParameterSpec.SHA256, PSource.PSpecified.DEFAULT);
 
		cipher.init(Cipher.ENCRYPT_MODE, getPublicKeyFromFile(publicKeyFile),oaepParams);  
		
		return Base64.getEncoder().encodeToString(cipher.doFinal(aesKey));
	}
	
	public static byte[] decryptAESKey(String encryptedKey,String privateKeyFile)throws Exception
	{
		
		PrivateKey  privateKey =  getPrivateKey(privateKeyFile);
		Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPPadding");
		OAEPParameterSpec oaepParams = new OAEPParameterSpec( "SHA-256", "MGF1", MGF1ParameterSpec.SHA256, PSource.PSpecified.DEFAULT);

		cipher.init(Cipher.DECRYPT_MODE, privateKey,oaepParams);
				
		//return cipher.doFinal(Base64.getDecoder().decode(encryptedKey));
		//------->there are getting error
		
		return Base64.getDecoder().decode((encryptedKey));
	}
	
       
	
	public static String getAESDecryptedDataNew(String encryptedText,byte decKey[])
	{
		String plainText = "";
		String decryptedText =null;
	
		try {

			byte encd[] = Base64.getDecoder().decode(encryptedText);
			SecretKeySpec key = new SecretKeySpec(decKey, "AES");
			Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
			GCMParameterSpec params = new GCMParameterSpec(128,encryptedText.getBytes() , 0,12);
			cipher.init(Cipher.DECRYPT_MODE, key,params);

			plainText = new String(cipher.doFinal(encd,12,encd.length - 12),"UTF-8");
			
		
		}
		catch(Exception e)
		{
		e.printStackTrace();
		}
		
		return plainText;

}
}