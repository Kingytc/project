package com.sai.laps.helper;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.SecureRandom;
import java.security.Security;
import java.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.bouncycastle.jce.provider.BouncyCastleProvider;

public class AESEncyrptionDecyrption {

	public static final int AES_KEY_SIZE_BITS = 256; 
	 public static final int IV_SIZE_BITS = 16;  
	 //private static final String ENCRYPT_ALGO = "AES/GCM/NoPadding","BC";//AES/CBC/PKCS5Padding
	 
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
	    
	
	public static SecretKey generateKey() throws NoSuchAlgorithmException {
	    KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
	   
	    //keyGenerator.init(256, SecureRandom.getInstanceStrong());
	   // return keyGenerator.generateKey();
	    keyGenerator.init(AES_KEY_SIZE_BITS);
	    SecretKey key = keyGenerator.generateKey();
	    return key;
	}
	
	
	public static IvParameterSpec generateIv() {
	    byte[] iv = new byte[IV_SIZE_BITS];
	    new SecureRandom().nextBytes(iv);
	    return new IvParameterSpec(iv);
	    
	    
	}
	
//	String initialVectorString;
//	IvParameterSpec initialVector = new IvParameterSpec(
//    	    (new org.apache.commons.codec.binary.Base64()).decode(
//    	    initialVectorString.getBytes()));
	
	
	
	public static byte[] getRandomNonce() {
        byte[] nonce = new byte[16];
        new SecureRandom().nextBytes(nonce);
        return nonce;
  }
	
	
	public static byte[] encrypt( String input, SecretKey key,
			IvParameterSpec iv) throws NoSuchPaddingException, NoSuchAlgorithmException,
		    InvalidAlgorithmParameterException, InvalidKeyException,
		    BadPaddingException, IllegalBlockSizeException, IllegalStateException, UnsupportedEncodingException {
		   		
		    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		    
//		    cipher.init(Cipher.ENCRYPT_MODE, key, iv);
//		    byte[] cipherText = cipher.doFinal(input.getBytes());
//		    //return Base64.getEncoder()
//		      //  .encodeToString(cipherText);
//		    
//		    return Base64.encodeBase64String(cipherText);
		    
		    
		     
		      
		    cipher.init(Cipher.ENCRYPT_MODE, key, iv);
	        byte[] encryptedText = cipher.doFinal(input.getBytes("UTF-8"));
	        return encryptedText;
		}
	
	
	public static String decrypt( String cipherText, SecretKey key,
		    IvParameterSpec iv) throws NoSuchPaddingException, NoSuchAlgorithmException,
		    InvalidAlgorithmParameterException, InvalidKeyException,
		    BadPaddingException, IllegalBlockSizeException, NoSuchProviderException {
		    
		    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding","BC");
		    cipher.init(Cipher.DECRYPT_MODE, key, iv);
		    byte[] plainText = cipher.doFinal(Base64.getDecoder()
		        .decode(cipherText));
		    return new String(plainText);
		}
	
	
	public static IvParameterSpec getIVSecureRandom(String algorithm) throws NoSuchAlgorithmException, NoSuchPaddingException {
	    SecureRandom random = SecureRandom.getInstanceStrong();
	    byte[] iv = new byte[16];
	    random.nextBytes(iv);
	    return new IvParameterSpec(iv);
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
	
	public static byte[] getIVSecureRandomiv() throws NoSuchAlgorithmException, NoSuchPaddingException {
	    SecureRandom random = SecureRandom.getInstanceStrong();
	    byte[] iv = new byte[16];
	    random.nextBytes(iv);
		return iv;
	   
	}
	
	public static byte[] getRandomIVWithSize() {
	    byte[] nonce = new byte[16];
	    new SecureRandom().nextBytes(nonce);
	    return nonce;
	}
	
	
	public static byte[] encryptwithkeyandIv( String input, byte[] key,
			byte[] iv) throws NoSuchPaddingException, NoSuchAlgorithmException,
		    InvalidAlgorithmParameterException, InvalidKeyException,
		    BadPaddingException, IllegalBlockSizeException, IllegalStateException, UnsupportedEncodingException, NoSuchProviderException {
		SecretKeySpec skey = new SecretKeySpec(key, "AES");
		IvParameterSpec initialVector = new IvParameterSpec(iv);
		    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding","BC");
		    
//		    cipher.init(Cipher.ENCRYPT_MODE, key, iv);
//		    byte[] cipherText = cipher.doFinal(input.getBytes());
//		    //return Base64.getEncoder()
//		      //  .encodeToString(cipherText);
//		    
//		    return Base64.encodeBase64String(cipherText);
		    
		    
		     
		      
		    cipher.init(Cipher.ENCRYPT_MODE, skey, initialVector);
	        byte[] encryptedText = cipher.doFinal(input.getBytes("UTF-8"));
	        return encryptedText;
		}
	
	
	public static byte[] decyrptkeyiv( String input, byte[] key,
			byte[] iv) throws NoSuchPaddingException, NoSuchAlgorithmException,
		    InvalidAlgorithmParameterException, InvalidKeyException,
		    BadPaddingException, IllegalBlockSizeException, IllegalStateException, UnsupportedEncodingException {
		SecretKeySpec skey = new SecretKeySpec(key, "AES");
		IvParameterSpec initialVector = new IvParameterSpec(iv);
		    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		          
		    cipher.init(Cipher.DECRYPT_MODE, skey, initialVector);
	        byte[] encryptedText = cipher.doFinal(input.getBytes("UTF-8"));
	        return encryptedText;
		}
	
	public static String decryptnew( String cipherText, byte[] key,
		    byte[] iv) throws NoSuchPaddingException, NoSuchAlgorithmException,
		    InvalidAlgorithmParameterException, InvalidKeyException,
		    BadPaddingException, IllegalBlockSizeException, NoSuchProviderException {
		    
		SecretKeySpec skey = new SecretKeySpec(key, "AES");
		IvParameterSpec initialVector = new IvParameterSpec(iv);
		
		    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding","BC");
		    cipher.init(Cipher.DECRYPT_MODE, skey, initialVector);
		    byte[] plainText = cipher.doFinal(Base64.getDecoder()
		        .decode(cipherText));
		    return new String(plainText);
		}
}
