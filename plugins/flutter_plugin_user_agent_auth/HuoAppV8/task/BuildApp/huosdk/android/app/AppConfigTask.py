#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : AppConfigTask.py
# @Author: liuhongliang
# @Date  : 2018/8/15
# @Desc  : 配置app特定需要的参数文件 productFlavorsConfig.gradle
import os

from huosdk.android import AndConstants
from huosdk.android.app import AppConfigLoad
from huosdk.common import HuoConstants
from huosdk.util import FileUtil


def start():
    configFile = os.path.join(os.path.abspath(HuoConstants.curProjectDir),
                              'config' + os.path.sep + 'productFlavorsConfig.gradle')
    content = "android {\n";
    content += "	productFlavors {\n"
    content += "		\"" + HuoConstants.config['channel']['channelName'] + "\" {\n"
    content += "			applicationId \"" + AndConstants.appPackageName + "\"\n"
    content += "			versionCode " + str(AppConfigLoad.versionCode) + "\n"
    content += "			versionName \"" + str(AppConfigLoad.versionName) + "\"\n"
    content += "			resValue( \"string\", \"app_name\", \"" + HuoConstants.config['channel'][
        'appName'] + "\" )\n"
    content += "			resValue( \"string\", \"accessibility_service_name\", \"" + HuoConstants.config['channel'][
        'appName'] + "自动安装\" )\n"

    # 加入项目编号
    content += "			buildConfigField(\"int\", \"projectCode\", \"" + \
               HuoConstants.config['channel']['channelNo'] + "\")\n"

    manifestConfig = "			manifestPlaceholders = ["
    for pluginConfig in AppConfigLoad.pluginConfigList:
        if pluginConfig['fieldTag'] == 'manifestPlaceholders':
            manifestConfig += pluginConfig['fieldName'] + " : \"" + pluginConfig['fieldValue'] + "\","
        if pluginConfig['fieldTag'] == 'buildConfigField':
            content += "			buildConfigField(\"String\", \"" + pluginConfig['fieldName'] + "\", '\"" + \
                       pluginConfig['fieldValue'] + "\"')\n"
    if not manifestConfig.endswith("["):
        manifestConfig = manifestConfig.strip(",") + "]\n"
        content += manifestConfig

    content+="		}\n"
    content+="	}\n"
    content+="}\n"
    FileUtil.writeTextToFile(configFile, content)
