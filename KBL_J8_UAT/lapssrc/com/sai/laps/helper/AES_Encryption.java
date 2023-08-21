package com.sai.laps.helper;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

public class AES_Encryption {
	//------------------Added for encryption---------------------------//
	  public static String AESencrypt(String key, String initVector, String value) 
	  {
			 try
			 {
			   IvParameterSpec iv 	   = new IvParameterSpec(initVector.getBytes("UTF-8"));
		       SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
		       Cipher cipher 		   = Cipher.getInstance("AES/CBC/PKCS5PADDING");
		       cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
		       byte[] encrypted 	   = cipher.doFinal(value.getBytes());
		       System.out.println("encrypted string: " + Base64.encodeBase64String(encrypted));
		       return Base64.encodeBase64String(encrypted);
		     } 
				 catch (Exception ex) 
		        {
		            ex.printStackTrace();
		        }
		      return null;
	  	}
	//------------------Added for Decryption---------------------------//
	  public static String AESdecrypt(String key, String initVector, String encrypted) 
	  {
	 	 byte[] original;
	     try 
	     {
	         IvParameterSpec iv 	  = new IvParameterSpec(initVector.getBytes("UTF-8"));
	         SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
	         Cipher cipher 		  = Cipher.getInstance("AES/CBC/PKCS5PADDING");
	         cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
	         original 			  = cipher.doFinal(Base64.decodeBase64(encrypted));
	         String decryptVal 	  = new String(original);
	         return decryptVal;
	     } 
	     catch (Exception ex) 
	     {
	     		throw new RuntimeException();
	     }
	 }

}
