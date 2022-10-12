#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : main.py
# @Author: liuhongliang
# @Date  : 2018/8/16
# @Desc  :

import sys
import os

# from android.app import AppMain

# 把当前目录加入到python的包寻找目录中，防止控制台执行时找不到包
curPath = os.path.abspath(os.path.dirname(__file__))
rootPath = os.path.split(curPath)[0]
print "curPath=" + curPath
sys.path.append(rootPath)

from huosdk.android.app import AppMain


def main():
    AppMain.main()


if __name__ == '__main__':
    main()
