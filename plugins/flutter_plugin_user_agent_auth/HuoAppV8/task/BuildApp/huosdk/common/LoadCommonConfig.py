#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : LoadCommonConfig.py
# @Author: liuhongliang
# @Date  : 2018/8/15
# @Desc  :
import os

# 改变编码，python2默认不是使用utf-8编码，需要修改
from huosdk.common import HuoConstants
from huosdk.util import JsonUtil


def changeEncoding():
    import sys
    reload(sys)
    sys.setdefaultencoding('utf8')


def start():
    changeEncoding()
    HuoConstants.taskDir = os.path.abspath(os.path.dirname(os.path.realpath(__file__)) + os.path.sep + "../../../")
    HuoConstants.logFile = os.path.join(os.path.abspath(HuoConstants.taskDir), 'log.txt')
    configPath = os.path.abspath(HuoConstants.taskDir) + os.path.sep + "config.json"
    print configPath
    HuoConstants.config = JsonUtil.loadJsonFile(configPath)
    HuoConstants.projectDirName = HuoConstants.config['project']['fileDirName']

    HuoConstants.curProjectDir = os.path.abspath(HuoConstants.config['workspace']) + os.path.sep + \
                                 (HuoConstants.config['project']['fileDirName'])
    HuoConstants.workspace = os.path.abspath(HuoConstants.config['workspace']) + os.path.sep
    print "load config success from ", configPath
