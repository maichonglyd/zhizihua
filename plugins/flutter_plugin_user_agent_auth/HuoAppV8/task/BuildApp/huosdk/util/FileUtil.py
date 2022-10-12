# -*- coding:utf-8 -*-
import re
import sys

import os

# 查找文件，根据后缀名
from huosdk.common import HuoConstants


# 获取相对于工作空间的相对路径
def getWorkSapceRelativePath(absultePath):
    relativePath = absultePath.replace(HuoConstants.workspace, '')
    return relativePath


# 查找文件，根据后缀名
def findFileBySuffix(srcFile, destSuffix, destFindPaths):
    if srcFile.endswith(destSuffix) and os.path.isfile(srcFile):
        destFindPaths.append(srcFile)
    else:
        if os.path.isdir(srcFile):
            for tempFile in os.listdir(srcFile):
                tempDir = os.path.join(srcFile, tempFile)
                findDir(tempDir, destSuffix, destFindPaths)
    return destFindPaths


# 查找文件,根据文件目录
def findDir(srcDir, destDirName, destFindPaths):
    if srcDir.endswith(destDirName):
        destFindPaths.append(srcDir)
    else:
        if os.path.isdir(srcDir):
            for tempFile in os.listdir(srcDir):
                tempDir = os.path.join(srcDir, tempFile)
                findDir(tempDir, destDirName, destFindPaths)

    return destFindPaths


# 文件文本替换
# oldValue 老的文件内容
# newValue 新的文件内容
def replaceFileValue(filePath, oldValue, newValue):
    src_file = open(filePath, "r")
    contents = src_file.read()
    contents = contents.replace(oldValue, newValue)
    src_file.close()
    src_file = open(filePath, "w")
    src_file.writelines(contents)
    src_file.close()


# 行替换
# oldLineIncludes 数组，这一行中包含的字符串
# newline 字符串，要替换的新串
def replaceFileLine(filePath, oldLineIncludes, newline):
    src_file = open(filePath, "r")
    contents = src_file.readlines()
    for index, line in enumerate(contents):
        # define    CHANNEL_URL
        isFind = True;

        for include in oldLineIncludes:
            if line.rfind(include) == -1:
                isFind = False
        if isFind:
            contents[index] = line.replace(line, newline) + "\n"

    src_file.close()
    src_file = open(filePath, "w")
    src_file.writelines(contents)
    src_file.close()


# 写入文本内容到文件中
def writeTextToFile(filePath, text):
    src_file = open(filePath, "w")
    src_file.write(text)
    src_file.close()


# 读取文本文件
def readTextToFile(filePath):
    src_file = open(filePath, "r")
    data = src_file.read()
    src_file.close()
    return data


def removeGradleSettingModule(settingPath, moduleName):
    data = readTextToFile(settingPath)
    if moduleName in data:
        # ':sdkNative'\s*,
        # \s*,\s*':sdkNative'
        pattern = "\s*,\s*':" + moduleName + "'"
        data = re.sub(pattern, "", data, count=1, flags=0)
        pattern = "':" + moduleName + "'\s*,"
        data = re.sub(pattern, "", data, count=1, flags=0)
        writeTextToFile(settingPath, data)
