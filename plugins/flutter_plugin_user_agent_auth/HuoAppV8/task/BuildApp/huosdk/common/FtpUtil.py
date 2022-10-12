#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @File  : FtpUtil.py
# @Author: liuhongliang
# @Date  : 2018/8/20
# @Desc  :
from ftplib import FTP
import time
import tarfile
from ftplib import FTP

import os


def ftpconnect(host, username, password):
    ftp = FTP()
    ftp.set_pasv(False)
    # ftp.set_debuglevel(2)  # 打开调试级别2，显示详细信息
    ftp.connect(host, 21)  # 连接
    ftp.login(username, password)  # 登录，如果匿名登录则用空串代替即可
    return ftp



def ftpCreateDir(ftp, remoteDir):
    print os.path.dirname(remoteDir)
    # 一级一级创建目录，如果不存在
    try:
        ftp.cwd(remoteDir)
    except Exception:
        # 获取上一级目录
        ftpCreateDir(ftp, os.path.dirname(remoteDir))
        ftp.mkd(remoteDir)



def downloadfile(ftp, remotepath, localpath):
    bufsize = 1024  # 设置缓冲块大小
    fp = open(localpath, 'wb')  # 以写模式在本地打开文件
    ftp.retrbinary('RETR ' + remotepath, fp.write, bufsize)  # 接收服务器上文件并写入本地文件
    ftp.set_debuglevel(0)  # 关闭调试
    fp.close()  # 关闭文件


def uploadfile(ftp, remotepath, localpath):
    ftpCreateDir(ftp, os.path.dirname(remotepath))
    bufsize = 1024
    fp = open(localpath, 'rb')
    ftp.storbinary('STOR ' + remotepath, fp, bufsize)  # 上传文件
    ftp.set_debuglevel(0)
    fp.close()


if __name__ == "__main__":
    ftp = ftpconnect("120.77.181.243", "userftp", "userpassword")
    uploadfile(ftp, "/test/task.zip", "C:\\Users\\hongliang\\Desktop\\task.zip")
    ftp.quit()
