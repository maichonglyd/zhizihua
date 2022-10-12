package com.game.sdk.util;

import android.util.Base64;

import com.blankj.utilcode.util.LogUtils;
import com.game.sdk.util.NotProguard;

import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Calendar;
import java.util.Random;

@NotProguard
public class AuthCodeUtil {
	private final static int LENGTH=128;
	 public enum DiscuzAuthcodeMode {     
	        Encode, Decode     
	    };     
	    
	    /// <summary>     
	    /// 从字符串的指定位置截取指定长度的子字符串     
	    /// </summary>     
	    /// <param name="str">原字符串</param>     
	    /// <param name="startIndex">子字符串的起始位置</param>     
	    /// <param name="length">子字符串的长度</param>     
	    /// <returns>子字符串</returns>     
	    public static String CutString(String str, int startIndex, int length) {     
	        if (startIndex >= 0) {     
	            if (length < 0) {     
	                length = length * -1;     
	                if (startIndex - length < 0) {     
	                    length = startIndex;     
	                    startIndex = 0;     
	                } else {     
	                    startIndex = startIndex - length;     
	                }     
	            }     
	    
	            if (startIndex > str.length()) {     
	                return "";     
	            }     
	    
	        } else {     
	            if (length < 0) {     
	                return "";     
	            } else {     
	                if (length + startIndex > 0) {     
	                    length = length + startIndex;     
	                    startIndex = 0;     
	                } else {     
	                    return "";     
	                }     
	            }     
	        }     
	    
	        if (str.length() - startIndex < length) {     
	    
	            length = str.length() - startIndex;     
	        }     
	    
	        return str.substring(startIndex, startIndex + length);     
	    }     
	    
	    /// <summary>     
	    /// 从字符串的指定位置开始截取到字符串结尾的了符串     
	    /// </summary>     
	    /// <param name="str">原字符串</param>     
	    /// <param name="startIndex">子字符串的起始位置</param>     
	    /// <returns>子字符串</returns>     
	    public static String CutString(String str, int startIndex) {     
	        return CutString(str, startIndex, str.length());     
	    }     
	    
	    /// <summary>     
	    /// 返回文件是否存在     
	    /// </summary>     
	    /// <param name="filename">文件名</param>     
	    /// <returns>是否存在</returns>     
	    public static boolean FileExists(String filename) {     
	        File f = new File(filename);     
	        return f.exists();     
	    }     
	    
	    /// <summary>     
	    /// MD5函数     
	    /// </summary>     
	    /// <param name="str">原始字符串</param>     
	    /// <returns>MD5结果</returns>     
//	    public static String MD5(String str) {     
//	        return md5.getMD5ofStr(str);     
//	    }     
	    
	    /// <summary>     
	    /// 字段串是否为Null或为""(空)     
	    /// </summary>     
	    /// <param name="str"></param>     
	    /// <returns></returns>     
	    public static boolean StrIsNullOrEmpty(String str) {     
	        //#if NET1     
	        if (str == null || str.trim().equals("")) {     
	            return true;     
	        }     
	    
	        return false;     
	    }     
	    
	    /// <summary>     
	    /// 用于 RC4 处理密码     
	    /// </summary>     
	    /// <param name="pass">密码字串</param>     
	    /// <param name="kLen">密钥长度，一般为 LENGTH</param>     
	    /// <returns></returns>     
	    static private byte[] GetKey(byte[] pass, int kLen) {     
	        byte[] mBox = new byte[kLen];     
	    
	        for (int i = 0; i < kLen; i++) {     
	            mBox[i] = (byte) i;     
	        }     
	    
	        int j = 0;     
	        for (int i = 0; i < kLen; i++) {     
	    
	            j = (j + (int) ((mBox[i] + LENGTH) % LENGTH) + pass[i % pass.length])     
	                    % kLen;     
	    
	            byte temp = mBox[i];     
	            mBox[i] = mBox[j];     
	            mBox[j] = temp;     
	        }     
	    
	        return mBox;     
	    }     
	    
	    /// <summary>     
	    /// 生成随机字符     
	    /// </summary>     
	    /// <param name="lens">随机字符长度</param>     
	    /// <returns>随机字符</returns>     
	    public static String RandomString(int lens) {     
	        char[] CharArray = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k',     
	                'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',     
	                'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };     
	        int clens = CharArray.length;     
	        String sCode = "";     
	        Random random = new Random();     
	        for (int i = 0; i < lens; i++) {     
	            sCode += CharArray[Math.abs(random.nextInt(clens))];     
	        }     
	        return sCode;     
	    }     
	    
	    /// <summary>     
	    /// 使用 Discuz authcode 方法对字符串加密     
	    /// </summary>     
	    /// <param name="source">原始字符串</param>     
	    /// <param name="key">密钥</param>     
	    /// <param name="expiry">加密字串有效时间，单位是秒</param>     
	    /// <returns>加密结果</returns>     
	    public static String authcodeEncode(String source, String key, int expiry) {     
	        return authcode(source, key, DiscuzAuthcodeMode.Encode, expiry);     
	    
	    }     
	    
	    /// <summary>     
	    /// 使用 Discuz authcode 方法对字符串加密     
	    /// </summary>     
	    /// <param name="source">原始字符串</param>     
	    /// <param name="key">密钥</param>     
	    /// <returns>加密结果</returns>     
	    public static String authcodeEncode(String source, String key) {
			LogUtils.d("source="+source);
			LogUtils.d("key="+key);
			String authcode = authcode(source, key, DiscuzAuthcodeMode.Encode, 0);
			LogUtils.d("authcode="+authcode);
			return authcode;
	    
	    }     
	    
	    /// <summary>     
	    /// 使用 Discuz authcode 方法对字符串解密     
	    /// </summary>     
	    /// <param name="source">原始字符串</param>     
	    /// <param name="key">密钥</param>     
	    /// <returns>解密结果</returns>     
	    public static String authcodeDecode(String source, String key) {     
	        return authcode(source, key, DiscuzAuthcodeMode.Decode, 0);     
	    
	    }     
	    
	    /// <summary>     
	    /// 使用 变形的 rc4 编码方法对字符串进行加密或者解密     
	    /// </summary>     
	    /// <param name="source">原始字符串</param>     
	    /// <param name="key">密钥</param>     
	    /// <param name="operation">操作 加密还是解密</param>     
	    /// <param name="expiry">加密字串过期时间</param>     
	    /// <returns>加密或者解密后的字符串</returns>     
	    private static String authcode(String source, String key,     
	            DiscuzAuthcodeMode operation, int expiry) {     
	        try {     
	            if (source == null || key == null) {     
	                return "";     
	            }     	    
	            int ckey_length = 4;     
	            String keya, keyb, keyc, cryptkey, result;     
	     
	            key = MD52(key);     
	            keya = MD52(CutString(key, 0, 16));
	            keyb = MD52(CutString(key, 16, 16));
	            keyc = ckey_length > 0 ? (operation == DiscuzAuthcodeMode.Decode ? CutString(
	                    source, 0, ckey_length)     
	                    : RandomString(ckey_length))     
	                    : "";     
	            cryptkey = keya + MD52(keya + keyc);
	            if (operation == DiscuzAuthcodeMode.Decode) {
	                byte[] temp;     
	                     
	                temp = Base64.decode(CutString(source, ckey_length), Base64.NO_WRAP);
	                result = new String(RC4(temp, cryptkey));     
	                if (CutString(result, 10, 16).equals(CutString(MD52(CutString(result, 26) + keyb), 0, 16))) {     
	                    return CutString(result, 26);     
	                } else {     
	                    temp = Base64.decode(CutString(source+"=", ckey_length), Base64.NO_WRAP);
	                    //temp = Base64.decode(CutString(source+"", ckey_length), 0);   
	                    result = new String(RC4(temp, cryptkey));     
	                    if (CutString(result, 10, 16).equals(CutString(MD52(CutString(result, 26) + keyb), 0, 16))) {     
	                        return CutString(result, 26);     
	                    } else {     
	                        temp = Base64.decode(CutString(source+"==", ckey_length), Base64.NO_WRAP);
	                        //temp = Base64.decode(CutString(source+"", ckey_length), 0);     
	                        result = new String(RC4(temp, cryptkey));     
	                        if (CutString(result, 10, 16).equals(CutString(MD52(CutString(result, 26) + keyb), 0, 16))) {     
	                            return CutString(result, 26);     
	                        }else{     
	                            return "2";     
	                        }     
	                    }     
	                }     
	            } else {     
	                source = "0000000000" + CutString(MD52(source + keyb), 0, 16)     
	                        + source;     
	    
	                byte[] temp = RC4(source.getBytes("UTF-8"), cryptkey);     
	               // String str=keyc+Base64.encodeToString(temp, 0);
	                return keyc+Base64.encodeToString(temp, Base64.NO_WRAP);
	                //return keyc + Base64.encodeBytes(temp);     
	                
	            }     
	        } catch (Exception e) {     
	            return "";     
	        }     
	    
	    }     
	    
	    // / <summary>     
	    // / RC4 原始算法     
	    // / </summary>     
	    // / <param name="input">原始字串数组</param>     
	    // / <param name="pass">密钥</param>     
	    // / <returns>处理后的字串数组</returns>     
	    private static byte[] RC4(byte[] input, String pass) {     
	        if (input == null || pass == null)     
	            return null;     
	    
	    
	    
	        byte[] output = new byte[input.length];     
	        byte[] mBox = GetKey(pass.getBytes(), LENGTH);     
	    
	        // 加密     
	        int i = 0;     
	        int j = 0;     
	    
	        for (int offset = 0; offset < input.length; offset++) {     
	            i = (i + 1) % mBox.length;     
	            j = (j + (int) ((mBox[i] + LENGTH) % LENGTH)) % mBox.length;     
	    
	            byte temp = mBox[i];     
	            mBox[i] = mBox[j];     
	            mBox[j] = temp;     
	            byte a = input[offset];     
	    
	            //byte b = mBox[(mBox[i] + mBox[j] % mBox.Length) % mBox.Length];     
	            // mBox[j] 一定比 mBox.Length 小，不需要在取模     
	            byte b = mBox[(toInt(mBox[i]) + toInt(mBox[j])) % mBox.length];     
	    
	            output[offset] = (byte) ((int) a ^ (int) toInt(b));     
	        }     
	    
	        return output;     
	    }     
	      
	    public static String MD52(String MD5) {  
	        StringBuffer sb = new StringBuffer();  
	        String part = null;  
	        try {  
	            MessageDigest md = MessageDigest.getInstance("MD5");  
	            byte[] md5 = md.digest(MD5.getBytes());  
	  
	            for (int i = 0; i < md5.length; i++) {  
	                part = Integer.toHexString(md5[i] & 0xFF);  
	                if (part.length() == 1) {  
	                    part = "0" + part;  
	                }  
	                sb.append(part);  
	            }  
	  
	        } catch (NoSuchAlgorithmException ex) {  
	        }  
	        return sb.toString();  
	  
	    }  
	    
	    public static int toInt(byte b) {     
	        return (int) ((b + LENGTH) % LENGTH);     
	    }     
	    
	    public long getUnixTimestamp() {     
	        Calendar cal = Calendar.getInstance();     
	        return cal.getTimeInMillis() / 1000;     
	    }     
	    
	    public static void main(String[] args) {     
	        String test = "13148984056";
	        String key = "62b7aa0af4b700031b1342700cf5fe75";
	        String afStr = AuthCodeUtil.authcodeEncode(test, key);
	        System.out.println("--------encode:" + afStr);
	        String deStr = AuthCodeUtil.authcodeDecode("d3en4BGq7+BiFkLQFvbuNioIXxJbruTbUx0RRea0sNrhK/JYoq0WQw==", key);
			System.out.println("--------decode:" + deStr);
	    
	    }     

}
