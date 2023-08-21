//Added By Zahoorunnisa for Single User sign ON as provided by CRISIL
package com.sai.laps.helper;

public class IRB_Encryption {
	
	static byte[] encodeData;

	static String charSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

	
	static {

        encodeData = new byte[64];

        for (int i = 0; i < 64; i++) {

              byte c = (byte) charSet.charAt(i);

              encodeData[i] = c;

        }

  }

	public static String cEncrypt_Base64(String s) {
        return cEncrypt_Base64(s.getBytes());
  }

  public static String cEncrypt_Base64(byte[] src) {
        return cEncrypt_Base64(src, 0, src.length);
  }

  public static String cEncrypt_Base64(byte[] src, int start, int length) {
        byte[] dst = new byte[(length + 2) / 3 * 4 + length / 72];
        int x = 0;
        int dstIndex = 0;
        int state = 0; // which char in pattern
        int old = 0; // previous byte
        int len = 0; // length decoded so far
        int max = length + start;
        try {
              for (int srcIndex = start; srcIndex < max; srcIndex++) {
                    x = src[srcIndex];
                    switch (++state) {
                    case 1:  
                          dst[dstIndex++] = encodeData[(x >> 2) & 0x3f];
                          break;
                    case 2:
                          dst[dstIndex++] = encodeData[((old << 4) & 0x30)
                                      | ((x >> 4) & 0xf)];
                          break;
                    case 3:
                          dst[dstIndex++] = encodeData[((old << 2) & 0x3C)
                                      | ((x >> 6) & 0x3)];
                          dst[dstIndex++] = encodeData[x & 0x3F];
                          state = 0;
                          break;
                    }
                    old = x;
                    if (++len >= 72) {
                          dst[dstIndex++] = (byte) '\n';
                          len = 0;
                    }
              }

              switch (state) {
              case 1:
                    dst[dstIndex++] = encodeData[(old << 4) & 0x30];
                    dst[dstIndex++] = (byte) '=';
                    dst[dstIndex++] = (byte) '=';
                    break;
              case 2:
                    dst[dstIndex++] = encodeData[(old << 2) & 0x3c];
                    dst[dstIndex++] = (byte) '=';
                    break;
              }
        } catch (ArrayIndexOutOfBoundsException e) {
        }
        return new String(dst);
  }

  public static byte[] dEncrypt_Base64(String s) {
        int end = 0; // end state
        if (s.endsWith("=")) {
              end++;
        }
        if (s.endsWith("==")) {
              end++;
        }
        int len = (s.length() + 3) / 4 * 3 - end;
        byte[] result = new byte[len];
        int dst = 0;
        try {
              for (int src = 0; src < s.length(); src++) {
                    int code = charSet.indexOf(s.charAt(src));
                    if (code == -1) {
                          break;
                    }
                    switch (src % 4) {
                    case 0:
                          result[dst] = (byte) (code << 2);
                          break;
                    case 1:
                          result[dst++] |= (byte) ((code >> 4) & 0x3);
                          result[dst] = (byte) (code << 4);
                          break;
                    case 2:
                          result[dst++] |= (byte) ((code >> 2) & 0xf);
                          result[dst] = (byte) (code << 6);
                          break;
                    case 3:
                          result[dst++] |= (byte) (code & 0x3f);
                          break;
                    }
              }
        } catch (ArrayIndexOutOfBoundsException e) {
        }
        return result;
  }

}
//END