package com.spring.common;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

// === #43. �뼇諛⑺뼢 �븫�샇�솕 �븣怨좊━利섏씤 AES256 �븫�샇�솕瑜� 吏��썝�븯�뒗 �겢�옒�뒪 �깮�꽦�븯湲�=== //
//			bean�쑝濡� �삱由ш린 �쐞�빐�꽌�뒗 湲곕낯�깮�꽦�옄媛� �엳�뼱�빞 �븳�떎.
// 			(湲곕낯 �깮�꽦�옄媛� �뾾�쑝誘�濡� @Component瑜� �벐硫� �삤瑜섍� 諛쒖깮�븳�떎.
//			 洹몃옒�꽌 servlet-context.xml �뙆�씪�뿉 吏곸젒 �뙆�씪誘명꽣媛� �엳�뒗 �깮�꽦�옄濡� bean �벑濡앹쓣 �빐二쇱뿀�떎.)


/**
 * �뼇諛⑺뼢 �븫�샇�솕 �븣怨좊━利섏씤 AES256 �븫�샇�솕瑜� 吏��썝�븯�뒗 �겢�옒�뒪
 */
public class AES256 {
    private String iv;
    private Key keySpec;

    /**
     * 16�옄由ъ쓽 �궎媛믪쓣 �엯�젰�븯�뿬 媛앹껜瑜� �깮�꽦�븳�떎.
     * @param key �븫�샇�솕/蹂듯샇�솕瑜� �쐞�븳 �궎媛�
     * @throws UnsupportedEncodingException �궎媛믪쓽 湲몄씠媛� 16�씠�븯�씪 寃쎌슦 諛쒖깮
     */
    
    // 가나다가나다
    public AES256(String key) throws UnsupportedEncodingException {
        this.iv = key.substring(0, 16);
        byte[] keyBytes = new byte[16];
        byte[] b = key.getBytes("UTF-8");
        int len = b.length;
        if(len > keyBytes.length){
            len = keyBytes.length;
        }
        System.arraycopy(b, 0, keyBytes, 0, len);
        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");

        this.keySpec = keySpec;
    }

    /**
     * AES256 �쑝濡� �븫�샇�솕 �븳�떎.
     * @param str �븫�샇�솕�븷 臾몄옄�뿴
     * @return
     * @throws NoSuchAlgorithmException
     * @throws GeneralSecurityException
     * @throws UnsupportedEncodingException
     */
    public String encrypt(String str) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException{
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
        byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
        String enStr = new String(Base64.encodeBase64(encrypted));
        return enStr;
    }

    /**
     * AES256�쑝濡� �븫�샇�솕�맂 txt 瑜� 蹂듯샇�솕�븳�떎.
     * @param str 蹂듯샇�솕�븷 臾몄옄�뿴
     * @return
     * @throws NoSuchAlgorithmException
     * @throws GeneralSecurityException
     * @throws UnsupportedEncodingException
     */
    public String decrypt(String str) throws NoSuchAlgorithmException, GeneralSecurityException, UnsupportedEncodingException {
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
        byte[] byteStr = Base64.decodeBase64(str.getBytes());
        return new String(c.doFinal(byteStr), "UTF-8");
    }

}// end of class AES256///////////////////////////////////////
