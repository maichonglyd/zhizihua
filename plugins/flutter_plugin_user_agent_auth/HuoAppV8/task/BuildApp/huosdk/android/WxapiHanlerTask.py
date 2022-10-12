#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : WxapiHanlerTask.py
# @Author: liuhongliang
# @Date  : 2018/8/15
# @Desc  : 微信特殊处理wxapi目录

# 1.将wxapi目录移动到对应的包名目录下
# 2.对清单文件中的对应的activity文件进行改名


import os
import shutil

from huosdk.util import FileUtil


# 更新清单文件中的wxapi包下的activity的声明
def updateWxapiManifest(manifestPath, oldPackageName, newPackageName):
    content = FileUtil.readTextToFile(manifestPath)
    content = content.replace(oldPackageName + '.wxapi.', newPackageName + '.wxapi.')
    content = content.replace("\".wxapi.", "\"" + newPackageName + ".wxapi.")
    FileUtil.writeTextToFile(manifestPath, content)


def start(javaPath, newPackageName, manifestPath):
    # 1.mainPath查找wxapi
    wxapiPath = FileUtil.findDir(javaPath, 'wxapi', [])
    if len(wxapiPath) == 0:
        return
    oldPackageName = wxapiPath[0].replace(javaPath, '')
    oldPackageName = oldPackageName.replace('wxapi', '')
    oldPackageName = oldPackageName.replace(os.path.sep, '.').strip('.')
    newWxapiPath = newPackageName.replace('.', os.path.sep)
    newWxapiPath = os.path.join(javaPath, newWxapiPath)
    # print newWxapiPath
    if not os.path.exists(newWxapiPath):
        os.makedirs(newWxapiPath)
    if oldPackageName != newPackageName:
        # 修改文件中包名
        dirList = os.listdir(wxapiPath[0])
        for wxFile in dirList:
            wxFile = os.path.join(wxapiPath[0], wxFile)
            if os.path.isfile(wxFile):
                FileUtil.replaceFileValue(wxFile, oldPackageName, newPackageName)
                shutil.move(wxapiPath[0], newWxapiPath)
    # 修改清单文件中的wxapi的activity
    updateWxapiManifest(manifestPath, oldPackageName, newPackageName)
