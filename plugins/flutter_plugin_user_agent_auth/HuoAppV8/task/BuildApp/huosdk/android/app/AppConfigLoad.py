#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : AppMain.py
# @Author: liuhongliang
# @Date  : 2018/8/15
# @Desc  :
import os

from huosdk.android import AndConstants
from huosdk.common import HuoConstants

mainManifestPath = ''

mainJavaDir = ''
versionCode = 1
versionName = '1.0'
pluginConfigList = ''


# 将后续多次需要用到的值预先取出
def preSetValue():
    global versionCode
    global versionName
    global mainJavaDir
    global mainManifestPath
    global pluginConfigList

    pluginConfigList = []
    pluginMap = HuoConstants.config['pluginMap'];

    for plugin in pluginMap.values():
        if (plugin['status'] == 1):
            for pluginConfig in plugin['pluginConfigList']:
                pluginConfigList.append(pluginConfig)
        else:
            for pluginConfig in plugin['pluginConfigList']:
                # 不开启插件时，此值为不使用
                pluginConfig['fieldValue'] = "0"
                pluginConfigList.append(pluginConfig)

    # pluginConfigList = HuoConstants.config['pluginMap']['appV8']['pluginConfigList']
    #
    # v8_app_has_h5=HuoConstants.config['pluginMap']['v8_app_has_h5']['status']
    # third_login=HuoConstants.config['pluginMap']['third_login']['status']
    # if v8_app_has_h5==1:
    for pluginConfig in pluginConfigList:
        if pluginConfig['fieldName'] == 'APPLICATION_ID':
            AndConstants.appPackageName = pluginConfig['fieldValue']
        if pluginConfig['fieldName'] == 'VERSION_CODE':
            versionCode = pluginConfig['fieldValue']
        if pluginConfig['fieldName'] == 'VERSION_NAME':
            versionName = pluginConfig['fieldValue']

    mainJavaDir = os.path.join(os.path.abspath(HuoConstants.config['project']['dir']), "app/src/main/java")
    mainManifestPath = os.path.join(os.path.abspath(HuoConstants.config['project']['dir']),
                                    "app/src/main/AndroidManifest.xml")
