package com.game.sdk.domain;

/**
 * Created by liu hong liang on 2016/11/9.
 */

public class DeviceBean {
    private String device_id = "";//	是	STRING	玩家设备ID IOS为openUDID ANDROID 为IMEI码
    private String imei = "";//	是	安卓为imei
    private String idfv;//	否	STRING	玩家设备IDFV 有传，安卓为androidid
    private String mac;//	否	STRING	玩家设备MAC 有传
    private String ip;//	否	设备网络IP地址
    private String model;//	否	机型
    private String os = "android";//	否	设备的平台（android、ios、wp）
    private String os_version;//	否	操作系统版本
    private String screen;//	否	分辨率
    private String net;//	否	设备的联网方式 3G,4G,WIFI
    private String imsi;//	否	设备的imsi
    private String disk_space;//	否	磁盘信息
    private String open_time;//	否	开机时长
    private String is_charge = "0";//	否	开机时长
    private String has_sim = "0";//	否	开机时长
    private String is_break = "0";//	否	开机时长
    private String userua = "";//	是	STRING	玩家设备UA
    private String ipaddrid;//	否	INT	玩家IP所在地编号
    private String deviceinfo;//	否	STRING	玩家设备信息 包括手机号码,用户系统版本,双竖线隔开
    private String local_ip;//	否	STRING	玩家设备本地IP 有传
    private String brand;//	否	STRING	玩家设备MAC 有传

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getDevice_id() {
        return device_id;
    }

    public void setDevice_id(String device_id) {
        this.device_id = device_id;
    }

    public String getUserua() {
        return userua;
    }

    public void setUserua(String userua) {
        this.userua = userua;
    }

    public String getIpaddrid() {
        return ipaddrid;
    }

    public void setIpaddrid(String ipaddrid) {
        this.ipaddrid = ipaddrid;
    }

    public String getDeviceinfo() {
        return deviceinfo;
    }

    public void setDeviceinfo(String deviceinfo) {
        this.deviceinfo = deviceinfo;
    }

    public String getIdfv() {
        return idfv;
    }

    public void setIdfv(String idfv) {
        this.idfv = idfv;
    }


    public String getLocal_ip() {
        return local_ip;
    }

    public void setLocal_ip(String local_ip) {
        this.local_ip = local_ip;
    }

    public String getMac() {
        return mac;
    }

    public void setMac(String mac) {
        this.mac = mac;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
    }

    public String getOs_version() {
        return os_version;
    }

    public void setOs_version(String os_version) {
        this.os_version = os_version;
    }

    public String getScreen() {
        return screen;
    }

    public void setScreen(String screen) {
        this.screen = screen;
    }

    public String getNet() {
        return net;
    }

    public void setNet(String net) {
        this.net = net;
    }

    public String getImsi() {
        return imsi;
    }

    public void setImsi(String imsi) {
        this.imsi = imsi;
    }

    public String getDisk_space() {
        return disk_space;
    }

    public void setDisk_space(String disk_space) {
        this.disk_space = disk_space;
    }

    public String getOpen_time() {
        return open_time;
    }

    public void setOpen_time(String open_time) {
        this.open_time = open_time;
    }

    public String getIs_charge() {
        return is_charge;
    }

    public void setIs_charge(String is_charge) {
        this.is_charge = is_charge;
    }

    public String getHas_sim() {
        return has_sim;
    }

    public void setHas_sim(String has_sim) {
        this.has_sim = has_sim;
    }

    public String getIs_break() {
        return is_break;
    }

    public void setIs_break(String is_break) {
        this.is_break = is_break;
    }

    public String getImei() {
        return imei;
    }

    public void setImei(String imei) {
        this.imei = imei;
    }
}
