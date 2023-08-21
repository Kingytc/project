package com.sai.laps.helper;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class EncryptorAesGcmPassword {
	private static final String ENCRYPT_ALGO ="AES/GCM/OAEPWithSHA1AndMGF1Padding";// "AES/GCM/NoPadding";

    private static final int TAG_LENGTH_BIT = 128; // must be one of {128, 120, 112, 104, 96}
    private static final int IV_LENGTH_BYTE = 12;
    private static final int SALT_LENGTH_BYTE = 16;
    
    private static final int AES_KEY_BIT = 256;

   
    
    private static final Charset UTF_8 = StandardCharsets.UTF_8;

    // return a base64 encoded AES encrypted text
    public static String encrypt(byte[] pText, String password) throws Exception {

        // 16 bytes salt
        byte[] salt = AES256GCMAlgorithm.getRandomNonce(SALT_LENGTH_BYTE);

        // GCM recommended 12 bytes iv?
        byte[] iv = AES256GCMAlgorithm.getRandomNonce(IV_LENGTH_BYTE);

        // secret key from password
        SecretKey aesKeyFromPassword = AES256GCMAlgorithm.getAESKeyFromPassword(password.toCharArray(), salt);

        Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);

        // ASE-GCM needs GCMParameterSpec
        cipher.init(Cipher.ENCRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));

        byte[] cipherText = cipher.doFinal(pText);

        // prefix IV and Salt to cipher text
        byte[] cipherTextWithIvSalt = ByteBuffer.allocate(iv.length + salt.length + cipherText.length)
                .put(iv)
                .put(salt)
                .put(cipherText)
                .array();

        // string representation, base64, send this string to other for decryption.
        return Base64.getEncoder().encodeToString(cipherTextWithIvSalt);

    }

    // we need the same password, salt and iv to decrypt it
    private static String decrypt(String cText, String password) throws Exception {

        byte[] decode = Base64.getDecoder().decode(cText.getBytes(UTF_8));

        // get back the iv and salt from the cipher text
        ByteBuffer bb = ByteBuffer.wrap(decode);

        byte[] iv = new byte[IV_LENGTH_BYTE];
        bb.get(iv);

        byte[] salt = new byte[SALT_LENGTH_BYTE];
        bb.get(salt);

        byte[] cipherText = new byte[bb.remaining()];
        bb.get(cipherText);

        // get back the aes key from the same password and salt
        SecretKey aesKeyFromPassword = AES256GCMAlgorithm.getAESKeyFromPassword(password.toCharArray(), salt);

        Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);

        cipher.init(Cipher.DECRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));

        byte[] plainText = cipher.doFinal(cipherText);

        return new String(plainText, UTF_8);

    }
    
    
    public static void main(String[] args) throws Exception {

        String OUTPUT_FORMAT = "%-30s:%s";

        String pText = "Hello World keerthana, Welcome to Cryptography!";

        // encrypt and decrypt need the same key.
        // get AES 256 bits (32 bytes) key
        SecretKey secretKey = AES256GCMAlgorithm.getAESKey(AES_KEY_BIT);
        System.out.println(String.format(OUTPUT_FORMAT,"secretKey value", secretKey.toString()));
        // encrypt and decrypt need the same IV.
        // AES-GCM needs IV 96-bit (12 bytes)
        byte[] iv = AES256GCMAlgorithm.getRandomNonce(IV_LENGTH_BYTE);
        System.out.println(String.format(OUTPUT_FORMAT, "iv value", iv));
        byte[] encryptedText = AES256EncyrptorDecyrptIV.encryptWithPrefixIV(pText.getBytes(UTF_8), secretKey, iv);
        System.out.println(String.format(OUTPUT_FORMAT, "encryptedText", encryptedText));
        System.out.println("\n------ AES GCM Encryption ------");
        System.out.println(String.format(OUTPUT_FORMAT, "Input (plain text)", pText));
        System.out.println(String.format(OUTPUT_FORMAT, "Key (hex)", AES256GCMAlgorithm.hex(secretKey.getEncoded())));
        System.out.println(String.format(OUTPUT_FORMAT, "IV  (hex)", AES256GCMAlgorithm.hex(iv)));
        System.out.println(String.format(OUTPUT_FORMAT, "Encrypted (hex) ", AES256GCMAlgorithm.hex(encryptedText)));
        System.out.println(String.format(OUTPUT_FORMAT, "Encrypted (hex) (block = 16)", AES256GCMAlgorithm.hexWithBlockSize(encryptedText, 16)));

        System.out.println("\n------ AES GCM Decryption ------");
        System.out.println(String.format(OUTPUT_FORMAT, "Input (hex)", AES256GCMAlgorithm.hex(encryptedText)));
        System.out.println(String.format(OUTPUT_FORMAT, "Input (hex) (block = 16)", AES256GCMAlgorithm.hexWithBlockSize(encryptedText, 16)));
        System.out.println(String.format(OUTPUT_FORMAT, "Key (hex)", AES256GCMAlgorithm.hex(secretKey.getEncoded())));

        String decryptedText = AES256EncyrptorDecyrptIV.decryptWithPrefixIV(encryptedText, secretKey);

        System.out.println(String.format(OUTPUT_FORMAT, "Decrypted (plain text)", decryptedText));

    }


}
