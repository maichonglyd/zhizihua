package com.game.sdk.http;

import com.game.sdk.util.NotProguard;

import java.util.Random;
/**
 * Created by liu hong liang on 2016/11/9.
 */

public class HttpParamsBuild {

    private static final String TAG = HttpParamsBuild.class.getSimpleName();
    private static String randChDict="qwertyuiopasdfghjklzxcvbnm123456789QWERTYUIOPASDFGHJKLZXCVBNM";
    /**
     * 随机从randChDict字典里获取length长度的字符串
     * @param length
     * @return
     */
    @NotProguard
    public static String getRandCh(int length){
        int dictLength = randChDict.length();
        Random random=new Random();
        StringBuffer buffer=new StringBuffer();
        for(int i=0;i<length;i++){
            buffer.append(randChDict.charAt(random.nextInt(dictLength)));
        }
        return buffer.toString();
    }
}
