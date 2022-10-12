#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : OutputResult.py
# @Author: liuhongliang
# @Date  : 2018/8/15
# @Desc  :
import os

from huosdk.common import HuoConstants
from huosdk.util import JsonUtil


def writeError():
    outFile = os.path.join(HuoConstants.workspace, "out.json")
    data = {
        'code': 0,
        'msg': 'error'
    }
    JsonUtil.writeJsonToFile(outFile, data)


def writeSuccess(products):
    outFile = os.path.join(HuoConstants.workspace, "out.json")
    data = {
        'code': 1,
        'msg': 'success',
        'products': products
    }
    JsonUtil.writeJsonToFile(outFile, data)
