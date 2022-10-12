# -*- coding:utf-8 -*-

from lxml import etree

from huosdk.util import FileUtil


# ios 用于更改plist文件
def updateKeyValuePlist(filePath, key, value):
    xml = etree.parse(filePath)
    # xpath 查找key节点，并且元素值等于给与的key 值的下一节点
    result = xml.xpath('//key[text()="' + key + '"]/following::*[1]')
    # 修改值
    result[0].text = value
    # 转成文本并格式化
    xmlStr = etree.tostring(xml, pretty_print=True)
    print(xmlStr)
    FileUtil.writeTextToFile(filePath, xmlStr)


# ios 用于更改plist文件
def updateKeyValueMapPlist(filePath, map):
    xml = etree.parse(filePath)

    for key, value in map.items():
        # xpath 查找key节点，并且元素值等于给与的key 值的下一节点
        result = xml.xpath('//key[text()="' + key + '"]/following::*[1]')
        # 修改值
        result[0].text = value
    # 转成文本并格式化
    xmlStr = etree.tostring(xml, pretty_print=True)
    print(xmlStr)
    FileUtil.writeTextToFile(filePath, xmlStr)

