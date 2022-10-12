#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : AppMain.py
# @Author: liuhongliang
# @Date  : 2018/8/15
# @Desc  :

import traceback

import time

import sys

from huosdk.android import CopyPluginConfigFileTask, NativeConfigTask, WxapiHanlerTask, AndConstants, ShareConfigTask
from huosdk.android.app import AppConfigTask, AppConfigLoad, AppOutTask
from huosdk.common import LoadCommonConfig, ShellExe, HuoConstants, OutputResult


def main():
    try:
        LoadCommonConfig.start()
        AppConfigLoad.preSetValue()
        NativeConfigTask.start()
        CopyPluginConfigFileTask.start(['png', 'jpg', 'jpeg'])
        ShareConfigTask.start()  # 配置sharesdk
        # WxapiHanlerTask.start(AppConfigLoad.mainJavaDir, AndConstants.appPackageName, AppConfigLoad.mainManifestPath)
        AppConfigTask.start()
        ShellExe.exe("gradle clean", cwd=HuoConstants.curProjectDir, error_exit=True)
        ShellExe.exe("gradle copySo", cwd=HuoConstants.curProjectDir, error_exit=True)
        ShellExe.exe("gradle :app:assembleRelease", cwd=HuoConstants.curProjectDir, error_exit=True)
        AppOutTask.start()
    except:
        print "运行报错：请查看报错日志\n"
        time.sleep(0.1)
        OutputResult.writeError()
        traceback.print_exc(file=sys.stdout)


if __name__ == '__main__':
    main()
