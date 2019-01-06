package com.board.hugh.config;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PassEncryption {
	public static String encPwd(String pwd) {
	    try {
	        MessageDigest sh = MessageDigest.getInstance("SHA-256"); 
	        sh.update(pwd.getBytes()); 
	        byte byteData[] = sh.digest();
	        StringBuffer sb = new StringBuffer(); 
	        for(int i = 0 ; i < byteData.length ; i++){
	            sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
	        }
	        pwd = sb.toString();
	    } catch(NoSuchAlgorithmException e){
	        e.printStackTrace(); 
	        pwd = "";
	    }
	    return pwd;
	}
}
