import '../../common/util/app_util.dart';
import 'game_details.dart';

class Game {
  String serverId;
  String serverName;
  String serverDesc;
  int startTime;

  //这个是活动资讯详情的游戏id
  int id;

  //这个是活动资讯详情的游戏名称
  String name;

  int gameId;
  int clientId;
  String gameName;
  String enName;
  String icon;
  String size;
  List<String> type;
  String downCnt;
  String downUrl;
  int giftCnt;
  String packageName;
  String oneWord;
  int runTime;
  String version;
  String pcHomeImgStyle1;
  String pcHomeImgStyle2;
  String pcFineImage;
  String fineImage;
  String appHotImage;
  num rate;
  List<String> singleTag;
  int isBt;
  String appleId;
  String ucId;
  List<String> tagsArr;
  int classify = 0;
  int benefitType;
  int status;
  String qrcodeUrl;
  int isAnd;
  int isIos;
  num starCnt;
  String desc;
  int isReservation;
  String gmUrl;
  int install = 0;
  int commentCount = 0;
  int isSubscribe; //	是否已预约 1否 2是
  //如果isSdk==1表示是cps游戏
  int isSdk;

  //添加cpsInfo游戏
  CpsInfo cpsInfo;
  num cpsRate;
  num cpsFirstRate;

  Cps cps;
  num memRate;
  num firstMemRate;

  //ipa安装url
  String ipaInstallUrl;

  //视频链接
  String videoUrl;

  //0 未知 1横屏 2竖屏
  int direction = 0;

  num cplMoney;

  int newsId;
  String title;
  String newsImage;
  num pubTime;
  String excerpt;
  List<BtTag> btTags;

  num startCnt;
  num startMemCnt;
  num subscribeCnt;

  Serlist serlist;
  num cpId;

  Game(
      {this.serverId,
      this.serverName,
      this.serverDesc,
      this.startTime,
      this.gmUrl,
      this.gameId,
      this.clientId,
      this.gameName,
      this.enName,
      this.icon,
      this.size,
      this.type,
      this.downCnt,
      this.downUrl,
      this.giftCnt,
      this.packageName,
      this.oneWord,
      this.runTime,
      this.version,
      this.pcHomeImgStyle1,
      this.pcHomeImgStyle2,
      this.pcFineImage,
      this.fineImage,
      this.appHotImage,
      this.rate,
      this.singleTag,
      this.isBt,
      this.appleId,
      this.ucId,
      this.tagsArr,
      this.classify,
      this.benefitType,
      this.status,
      this.qrcodeUrl,
      this.isAnd,
      this.isIos,
      this.starCnt,
      this.desc,
      this.isReservation,
      this.commentCount,
      this.id,
      this.name,
      this.isSubscribe,
      this.isSdk,
      this.cpsInfo,
      this.cps,
      this.cpsFirstRate,
      this.direction,
      this.cpsRate,
      this.cplMoney,
      this.newsId,
      this.title,
      this.newsImage,
      this.pubTime,
      this.excerpt,
      this.btTags,
      this.startCnt,
      this.startMemCnt,
      this.subscribeCnt,
      this.serlist});

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gameId = json['game_id'];
    clientId = json['client_id'];
    gameName = json['game_name'];
    enName = json['en_name'];
    icon = json['icon'];
    size = json['size'];
    type = json['type'] != null ? json['type'].cast<String>() : List();
    gmUrl = json['gm_url'];
    downCnt = json['down_cnt'].toString();
    downUrl = json['down_url'];
    giftCnt = json['gift_cnt'];
    packageName = json['package_name'];
    oneWord = json['one_word'];
    runTime = json['run_time'];
    version = json['version'];
    pcHomeImgStyle1 = json['pc_home_img_style1'];
    pcHomeImgStyle2 = json['pc_home_img_style2'];
    pcFineImage = json['pc_fine_image'];
    fineImage = json['fine_image'];

    appHotImage = json['app_hot_image'];
    rate = json['rate'];
    singleTag = tagToList(json['single_tag']);
    isBt = json['is_bt'];
    appleId = json['apple_id'];
    ucId = json['uc_id'];
    tagsArr =
        json['tags_arr'] != null ? json['tags_arr'].cast<String>() : List();
    classify = json['classify'];
    benefitType = json['benefit_type'];
    status = json['status'];
    qrcodeUrl = json['qrcode_url'];
    isAnd = json['is_and'];
    isIos = json['is_ios'];
    starCnt = json['star_cnt'];
    desc = json['desc'];
    isReservation = json['is_reservation'];

    serverId = json['server_id'];
    serverName = json['server_name'];
    serverDesc = json['server_desc'];
    startTime = json['start_time'];
    commentCount = json['comment_count'];

    isSubscribe = json['is_subscribe'];

    isSdk = json['is_sdk'];

    cpsInfo = (json['cps_info'] != null && json['cps_info'] is Map)
        ? CpsInfo.fromJson(json['cps_info'])
        : null;
    cps = (json['cps_info'] != null && json['cps_info'] is Map)
        ? Cps.fromJson(json['cps_info'])
        : null;

    videoUrl = json['video_url'];

    cpsRate = json['cps_rate'];
    cpsFirstRate = json['cps_first_rate'];

    memRate = json['mem_rate'];
    firstMemRate = json['first_mem_rate'];

    if (json['direction'] is String &&
        json['direction'].toString().isNotEmpty &&
        json['direction'] != null) {
      direction = int.parse(json['direction']);
    } else {
      if (json['direction'] == null ||
          json['direction'].toString().isNotEmpty) {
        direction = 0;
      } else {
        direction = json['direction'];
      }
    }

    cplMoney = json['cpl_money'];

    // 新游快报专题的数据
    newsId = AppUtil.stringToNum(json['news_id'].toString());
    title = json['title'];
    newsImage = AppUtil.getObjectToString(json, 'image');
    pubTime = json['pub_time'];
    excerpt = json['excerpt'];

    if (json['bt_tags'] != null) {
      btTags = new List<BtTag>();
      json['bt_tags'].forEach((v) {
        btTags.add(new BtTag.fromJson(v));
      });
    }

    startCnt = json['start_cnt'];
    startMemCnt = json['start_mem_cnt'];
    subscribeCnt = json['subscribe_cnt'];
    serlist = json['serlist'] != null ? new Serlist.fromJson(json['serlist']) : null;
    cpId = json['cp_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    data['game_id'] = this.gameId;
    data['client_id'] = this.clientId;
    data['game_name'] = this.gameName;
    data['en_name'] = this.enName;
    data['icon'] = this.icon;
    data['size'] = this.size;
    data['type'] = this.type;
    data['down_cnt'] = this.downCnt;
    data['down_url'] = this.downUrl;
    data['gift_cnt'] = this.giftCnt;
    data['package_name'] = this.packageName;
    data['one_word'] = this.oneWord;
    data['run_time'] = this.runTime;
    data['version'] = this.version;
    data['pc_home_img_style1'] = this.pcHomeImgStyle1;
    data['pc_home_img_style2'] = this.pcHomeImgStyle2;
    data['pc_fine_image'] = this.pcFineImage;
    data['app_hot_image'] = this.appHotImage;
    data['rate'] = this.rate;
    data['is_bt'] = this.isBt;
    data['apple_id'] = this.appleId;
    data['uc_id'] = this.ucId;
    data['tags_arr'] = this.tagsArr;
    data['classify'] = this.classify;
    data['benefit_type'] = this.benefitType;
    data['status'] = this.status;
    data['qrcode_url'] = this.qrcodeUrl;
    data['is_and'] = this.isAnd;
    data['is_ios'] = this.isIos;
    data['star_cnt'] = this.starCnt;
    data['desc'] = this.desc;
    data['is_reservation'] = this.isReservation;
    data['gm_url'] = this.gmUrl;
    data['server_id'] = this.serverId;
    data['server_name'] = this.serverName;
    data['server_desc'] = this.serverDesc;
    data['start_time'] = this.startTime;
    data['comment_count'] = this.commentCount;
    return data;
  }

  @override
  String toString() {
    return 'Game{serverId: $serverId, serverName: $serverName, serverDesc: $serverDesc, startTime: $startTime, id: $id, name: $name, gameId: $gameId, clientId: $clientId, gameName: $gameName, enName: $enName, icon: $icon, size: $size, type: $type, downCnt: $downCnt, downUrl: $downUrl, giftCnt: $giftCnt, packageName: $packageName, oneWord: $oneWord, runTime: $runTime, version: $version, pcHomeImgStyle1: $pcHomeImgStyle1, pcHomeImgStyle2: $pcHomeImgStyle2, pcFineImage: $pcFineImage, appHotImage: $appHotImage, rate: $rate, singleTag: $singleTag, isBt: $isBt, appleId: $appleId, ucId: $ucId, tagsArr: $tagsArr, classify: $classify, benefitType: $benefitType, status: $status, qrcodeUrl: $qrcodeUrl, isAnd: $isAnd, isIos: $isIos, starCnt: $starCnt, desc: $desc, isReservation: $isReservation, gmUrl: $gmUrl, install: $install, commentCount: $commentCount, isSubscribe: $isSubscribe, isSdk: $isSdk, cpsInfo: $cpsInfo, cps: $cps, cpsRate: $cpsRate, cpsFirstRate: $cpsFirstRate}';
  }
}

List<String> tagToList(String labelString) {
  if (labelString != null && labelString.isNotEmpty) {
    List<String> list = labelString.split('|');
    return list;
  } else {
    return List();
  }
}

class Cps {
  String cpsName;
  String cpsImage;

  Cps({this.cpsName, this.cpsImage});

  Cps.fromJson(Map<String, dynamic> json) {
    cpsName = json['name'];
    cpsImage = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cps_name'] = this.cpsName;
    data['cps_image'] = this.cpsImage;
    return data;
  }
}

class CpsInfo {
  int id;
  String channelName;
  String companyName;
  String linkMan;
  String mobile;
  String position;
  String image;
  int isDelete;
  int deleteTime;
  int createTime;
  int updateTime;

  CpsInfo(
      {this.id,
      this.channelName,
      this.companyName,
      this.linkMan,
      this.mobile,
      this.position,
      this.image,
      this.isDelete,
      this.deleteTime,
      this.createTime,
      this.updateTime});

  CpsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelName = json['channel_name'];
    companyName = json['company_name'];
    linkMan = json['link_man'];
    mobile = json['mobile'];
    position = json['position'];
    image = json['image'];
    isDelete = json['is_delete'];
    deleteTime = json['delete_time'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['channel_name'] = this.channelName;
    data['company_name'] = this.companyName;
    data['link_man'] = this.linkMan;
    data['mobile'] = this.mobile;
    data['position'] = this.position;
    data['image'] = this.image;
    data['is_delete'] = this.isDelete;
    data['delete_time'] = this.deleteTime;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    return data;
  }
}

class BtTag {
  int id;
  String tag;

  BtTag(this.id, this.tag);

  BtTag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
  }
}
