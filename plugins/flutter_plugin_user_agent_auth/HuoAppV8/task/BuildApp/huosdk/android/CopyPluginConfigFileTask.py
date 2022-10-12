#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : CopyPluginConfigFileTask.py
# @Author: liuhongliang
# @Date  : 2018/8/15
# @Desc  :
import shutil

import os

from huosdk.common import HuoConstants


def start(includeTypes):
    pluginConfigList = HuoConstants.config['pluginMap']['appV8']['pluginConfigList']
    fileDir = HuoConstants.config['filePath']
    for pluginConfig in pluginConfigList:
        if pluginConfig['fieldType'] == 'file':
            for includeType in includeTypes:
                if pluginConfig['fieldName'].endswith(includeType):
                    srcPath = os.path.abspath(fileDir) + os.path.sep + pluginConfig['fieldValue']
                    destPath = os.path.abspath(HuoConstants.curProjectDir) + os.path.sep + pluginConfig['fieldTag'] + os.path.sep + \
                               pluginConfig['fieldName']
                    shutil.copy(srcPath, destPath)
                    break
