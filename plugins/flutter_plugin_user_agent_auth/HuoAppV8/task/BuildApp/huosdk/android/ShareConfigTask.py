import os

from huosdk.common import HuoConstants
from huosdk.util import FileUtil


def start():
    templateConfigPath = os.path.abspath(HuoConstants.taskDir) + os.path.sep \
                         + "BuildApp" + os.path.sep \
                         + "resource" + os.path.sep \
                         + "template" + os.path.sep \
                         + "shareSdkConfig.gradle"

    destConfigPath = os.path.abspath(HuoConstants.curProjectDir) + os.path.sep \
                     + 'config' + os.path.sep \
                     + 'shareSdkConfig.gradle'

    content = FileUtil.readTextToFile(templateConfigPath)
    pluginConfigList = HuoConstants.config['pluginMap']['appV8']['pluginConfigList']

    for pluginConfig in pluginConfigList:
        if pluginConfig['fieldTag'] == 'buildConfigField':
            oldValue = "#{" + pluginConfig['fieldName'] + "}"
            newValue = pluginConfig['fieldValue']
            content = content.replace(oldValue, newValue)

    FileUtil.writeTextToFile(destConfigPath, content)
