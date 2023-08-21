package com.sai.laps.helper;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.SecureRandom;
import java.security.Security;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
public class RSAOAEPWithSHA1AndMGF1Padding {
	//Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
	static KeyPair pair;
	static Key pubKey;
	static Key privKey;
	
	public static byte[] getSecureRandomNonce(int numBytes) {
        byte[] random = new byte[numBytes];
        new SecureRandom().nextBytes(random);
        return random;
    }
	
	
	
	
	public static byte[] encyrptdata(byte[] input) throws InvalidKeyException, NoSuchAlgorithmException, NoSuchProviderException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException
	{
		Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
    //byte[] input = "abc".getBytes();
    Cipher cipher = Cipher.getInstance("RSA/OAEPWithSHA1AndMGF1Padding", "BC");
    SecureRandom random = new SecureRandom();
    KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA", "BC");

      generator.initialize(386, random);
	
      pair = generator.generateKeyPair();
	
     pubKey = pair.getPublic();

     privKey = pair.getPrivate();
     
    cipher.init(Cipher.ENCRYPT_MODE, pubKey, random);
    byte[] cipherText = cipher.doFinal(input);
    System.out.println("cipher: " + new String(cipherText));
    
    return cipherText;
    
	}

    
	public static byte[] decyrptdata(byte[] cipherText)throws InvalidKeyException, NoSuchAlgorithmException, NoSuchProviderException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException
	
	{
		Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
    //byte[] input = "abc".getBytes();
    Cipher cipher = Cipher.getInstance("RSA/OAEPWithSHA1AndMGF1Padding", "BC");
    SecureRandom random = new SecureRandom();
    KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA", "BC");

      generator.initialize(386, random);
	
      pair = generator.generateKeyPair();
	
     pubKey = pair.getPublic();

     privKey = pair.getPrivate();
     
    cipher.init(Cipher.DECRYPT_MODE, privKey);
    byte[] plainText = cipher.doFinal(cipherText);
    System.out.println("plain : " + new String(plainText));
    
    
    return cipherText;
    
	}

    
}
