#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : AppOutTask.py
# @Author: liuhongliang
# @Date  : 2018/8/17
# @Desc  :
import shutil

import os

from huosdk.common import HuoConstants, ShellExe, OutputResult
from huosdk.util import FileUtil


def cleanTempFile():
    # 删除task目录
    shutil.rmtree(HuoConstants.taskDir, True)
    ShellExe.exe("gradle clean", cwd=HuoConstants.curProjectDir, error_exit=True)
    buildPath = os.path.join(HuoConstants.curProjectDir, 'build')
    if os.path.exists(buildPath):
        shutil.rmtree(buildPath, True)
    gradlePath = os.path.join(HuoConstants.curProjectDir, '.gradle')
    if os.path.exists(gradlePath):
        shutil.rmtree(gradlePath, True)
    nativePath = os.path.join(HuoConstants.curProjectDir, 'sdkNative')
    if os.path.exists(nativePath):
        shutil.rmtree(nativePath, True)
        settingPath = os.path.join(HuoConstants.curProjectDir, 'settings.gradle')
        FileUtil.removeGradleSettingModule(settingPath, 'sdkNative')
    os._exit(0)


def start():
    # 查找app 产物apk，复制到工作空间目录
    appPath = os.path.abspath(HuoConstants.curProjectDir) + os.path.sep + "app"
    resultApks = FileUtil.findFileBySuffix(appPath, '.apk', [])
    destFile = os.path.join(HuoConstants.workspace, os.path.basename(resultApks[0]))
    shutil.copy(resultApks[0], destFile)
    # 取相对路径
    apkPath = FileUtil.getWorkSapceRelativePath(destFile)
    data = {
        "app": apkPath
    }
    OutputResult.writeSuccess(data)
    cleanTempFile()
