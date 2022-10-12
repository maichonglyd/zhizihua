package com.leon.channel.writer;

import android.text.TextUtils;
import android.util.Log;

import com.leon.channel.reader.ChannelReader;
import com.leon.channel.verify.VerifyApk;

import java.io.File;

public class ChannelGenerateUtil {
    private static final String TAG = ChannelGenerateUtil.class.getSimpleName();

    public static void generateChannelApk(File file, String agent) {
        if (null == file || !file.isFile() || TextUtils.isEmpty(agent)) {
            Log.d(TAG, "generateChannelApk: file or agent was null");
            return;
        }

        if (ChannelReader.containV2Signature(file)) {
            generateV2ChannelApk(file, agent);
        } else if (ChannelReader.containV1Signature(file)) {
            generateV1ChannelApk(file, agent);
        } else {
            Log.e(TAG, "generateChannelApk: not have precise channel package mode");
        }
    }

    public static void generateV1ChannelApk(File file, String agent) {
        Log.d(TAG, "generateV1ChannelApk: ");
        try {
            ChannelWriter.addChannelByV1(file, agent);
            //1. verify channel info
            if (ChannelReader.verifyChannelByV1(file, agent)) {
                Log.d(TAG, "generateV1ChannelApk: " + file.getName() + " add channel success");
            } else {
                Log.d(TAG, "generateV1ChannelApk: " + file.getName() + " add channel failure");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void generateV2ChannelApk(File file, String agent) {
        Log.d(TAG, "generateV2ChannelApk: ");
        try {
            ChannelWriter.addChannelByV2(file, agent, true);
            //1. verify channel info
            if (ChannelReader.verifyChannelByV2(file, agent)) {
                Log.d(TAG, "generateV2ChannelApk: " + file.getName() + " add channel success");
            } else {
                Log.d(TAG, "generateV2ChannelApk: " + file.getName() + " add channel failure");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
