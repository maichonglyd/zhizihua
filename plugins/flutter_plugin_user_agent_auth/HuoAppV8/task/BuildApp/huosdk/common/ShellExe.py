#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : ShellExe.py
# @Author: liuhongliang
# @Date  : 2018/8/16
# @Desc  : 
import platform

import subprocess
import tempfile


def exe(command, cwd=None, error_exit=True):
    sysstr = platform.system()
    if (sysstr == "Windows"):
        print ("Call Windows tasks")
    elif (sysstr == "Linux"):
        print ("Call Linux tasks")
    else:
        print ("Other System tasks")
    print "准备执行命令：\n" + command
    if cwd:
        print "准备执行命令的指定目录：" + cwd
    # 和java 类似必须将管道中的数据取出，否则输出结果过大超出管道buff后不及时取出，会等待，导致阻塞程序运行
    # 得到一个临时文件对象， 调用close后，此文件从磁盘删除
    out_temp = tempfile.TemporaryFile(mode='w+')
    # 获取临时文件的文件号
    fileno = out_temp.fileno()
    popen = subprocess.Popen(command, shell=True, cwd=cwd, stdout=fileno, stderr=fileno, stdin=subprocess.PIPE)
    popen.wait()
    out_temp.seek(0)
    result = out_temp.read()
    if sysstr == "Windows":
        result = result.decode("gbk").encode("utf-8")
    print "输出结果：\n" + result + "\n"
    if popen.returncode != 0:
        print "执行错误：", popen.returncode
        if error_exit:
            raise RuntimeError('执行:'+command+"错误")
    else:
        print "执行成功：", popen.returncode
        return result
