# -*- coding:utf-8 -*-
import json


def loadJsonFile(jsonPath):
    f = open(jsonPath)
    read = f.read()
    f.close()
    print read
    loads = json.loads(read)
    return loads


def writeJsonToFile(jsonPath, data):
    jsonStr = json.dumps(data, indent=4, sort_keys=True, ensure_ascii=False)
    f = open(jsonPath, "w+")
    f_read = f.read()
    print f_read
    f.write(jsonStr)
    f.close()
