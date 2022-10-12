#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : NativeConfigTask.py
# @Author: liuhongliang
# @Date  : 2018/8/15
# @Desc  :
import os

from huosdk.android import AndConstants
from huosdk.common import HuoConstants
from huosdk.util import FileUtil


def start():
    templateConfigPath = os.path.abspath(HuoConstants.taskDir) + os.path.sep \
                         + "BuildApp" + os.path.sep \
                         + "resource" + os.path.sep \
                         + "template" + os.path.sep \
                         + "hs_constant.h"
    destConfigPath = os.path.abspath(HuoConstants.curProjectDir) + os.path.sep \
                     + 'sdkNative' + os.path.sep \
                     + 'src' + os.path.sep \
                     + 'main' + os.path.sep \
                     + 'cpp' + os.path.sep \
                     + 'hs_constant.h'

    destCommonPath = os.path.abspath(HuoConstants.curProjectDir) + os.path.sep \
                     + 'sdkNative' + os.path.sep \
                     + 'src' + os.path.sep \
                     + 'main' + os.path.sep \
                     + 'cpp' + os.path.sep \
                     + 'common.h'

    destNetPath = os.path.abspath(HuoConstants.curProjectDir) + os.path.sep \
                  + 'sdkNative' + os.path.sep \
                  + 'src' + os.path.sep \
                  + 'main' + os.path.sep \
                  + 'cpp' + os.path.sep \
                  + 'install_net.h'

    content = FileUtil.readTextToFile(templateConfigPath)
    pluginConfigList = HuoConstants.config['pluginMap']['appV8']['pluginConfigList']

    for pluginConfig in pluginConfigList:
        if pluginConfig['fieldTag'] == 'SdkNative':
            oldValue = "#{" + pluginConfig['fieldName'] + "}"
            newValue = pluginConfig['fieldValue']
            content = content.replace(oldValue, newValue)

    # 修改 PROJECT_CODE

    oldValue = "#{PROJECT_CODE}"
    newValue = HuoConstants.config['channel']['channelNo']
    content = content.replace(oldValue, newValue)

    # 修改 APP_PACKAGE_NAME sdk require

    oldValue = "#{APP_PACKAGE_NAME}"
    newValue = AndConstants.appPackageName
    content = content.replace(oldValue, newValue)

    FileUtil.writeTextToFile(destConfigPath, content)

    # 修改debug模式
    if HuoConstants.config['buildType'] == 0:
        FileUtil.replaceFileLine(destCommonPath, ['#define', 'DEBUG', '0'], '#define DEBUG 1')
        FileUtil.replaceFileValue(destNetPath, "setSdkConstantField(env,BASE_URL,jStrUrl)",
                                  "//setSdkConstantField(env,BASE_URL,jStrUrl)")
    else:
        FileUtil.replaceFileLine(destCommonPath, ['#define', 'DEBUG', '1'], '#define DEBUG 0')
