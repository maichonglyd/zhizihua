//
// Created by liu hong liang on 2016/11/11.
//

#ifndef HUOSUSO_HS_CONSTANT_H
#define HUOSUSO_HS_CONSTANT_H

static char *RSA_HS_PUBLIC_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDihk0eBdpiW/HWpWUvwN+OkL4C4a/vC+P9SQap7lZFf9plKFNaMoMVI4VGtjkpTKmdz+vr0g11/Z5V/Ehs9xeft1quw4/gblWR2gK7qAJSs9K2vRBcyiD7V3kEoAd0QVzpyNLmInZ+Mi03WNXUonGqEshEdzfODlwa8V6DBuld9QIDAQAB";
static char *HS_URL_INSTALL2 = "https://hv.huosdk.com/v7/install";
static char *HS_URL_INSTALL = "https://ha.huosdk.com:8443/v7/install";

static char *RSA_CUSTOM_PUBLIC_KEY = "#{RSA_CUSTOM_PUBLIC_KEY}";//客户公钥
static char *auth_type = "#{AUTH_TYPE}";//1.不认证，2不强制认证，3强制认证


static char *schema = "#{URL_SCHEMA}";
static char *config_pre_url = "#{URL_PRE}";
static char *config_url = "#{URL}";
static char *config_suffix_url = "#{URL_SUFFIX}";
static char *config_ip = "#{IP}";

static char *appPackageName = "#{APP_PACKAGE_NAME}";

static char *agent_game = "#{agentgame}";

static char *ecagentgame = "#{ecagentgame}";

//渠道编号
static char *config_project_code = "#{PROJECT_CODE}";

//使用请求地址方式
static char *config_use_url_type = "#{USE_URL}";//1域名，2ip

#endif //HUOSUSO_HS_CONSTANT_H

