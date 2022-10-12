import '../base_model.dart';
import 'game_bean.dart';

class GameDetails extends BaseModel<Data> {
  GameDetails.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data extends Game {
  int gameId;
  String gameName;
  String icon;
  String size;
  String category;
  List<String> type;
  List<String> singleTag;
  List<String> tagsArr;
  String downCnt;
  String downUrl;
  int giftCnt;
  String packageName;
  String oneWord;
  int runTime;
  int classify;
  String version;
  String appHotImage;
  num rate;
  int isBt;
  String ucId;
  int benefitType;
  int status;
  String desc;
  List<ImageMod> image;
  String rebateDescription;
  Vip vipDescription;
  int isReservation;
  Serlist serlist;
  List<News> news;
  LikeGameList gameList;
  String qqGroup;
  int hasCpsGame;

  CommentStar commentStar;
  List<String> player;

  Data(
      {this.gameId,
      this.gameName,
      this.icon,
      this.size,
      this.category,
      this.type,
      this.tagsArr,
      this.downCnt,
      this.downUrl,
      this.giftCnt,
      this.packageName,
      this.oneWord,
      this.runTime,
      this.classify,
      this.version,
      this.appHotImage,
      this.rate,
      this.singleTag,
      this.isBt,
      this.ucId,
      this.benefitType,
      this.status,
      this.desc,
      this.image,
      this.rebateDescription,
      this.vipDescription,
      this.isReservation,
      this.serlist,
      this.news,
      this.gameList});

  Data.fromJson(Map<String, dynamic> json) {
    gameId = json['game_id'];
    gameName = json['game_name'];
    icon = json['icon'];
    size = json['size'];
    category = json['category'];
    type = json['type'].cast<String>();
    tagsArr = json['tags_arr'].cast<String>();
    downCnt = json['down_cnt'].toString();
    downUrl = json['down_url'];
    giftCnt = json['gift_cnt'];
    packageName = json['package_name'];
    oneWord = json['one_word'];
    runTime = json['run_time'];
    classify = json['classify'];
    version = json['version'];
    appHotImage = json['app_hot_image'];
    rate = json['rate'];
    isBt = json['is_bt'];
    ucId = json['uc_id'];
    benefitType = json['benefit_type'];
    singleTag = tagToList(json['single_tag']);
    status = json['status'];
    starCnt = json['star_cnt'];
    desc = json['desc'];
    if (json['image'] != null) {
      image = new List<ImageMod>();
      json['image'].forEach((v) {
        image.add(new ImageMod.fromJson(v));
      });
    }
    rebateDescription = json['rebate_description'];
    vipDescription = json['vip_description'] != null
        ? Vip.fromJson(json['vip_description'])
        : null;
    isReservation = json['is_reservation'];
    serlist =
        json['serlist'] != null ? new Serlist.fromJson(json['serlist']) : null;

    hasCpsGame = json['has_cps_game'];
    isSdk = json['is_sdk'];

    if (json['news'] != null) {
      news = new List<News>();
      json['news'].forEach((v) {
        news.add(new News.fromJson(v));
      });
    }

    gameList = json['game_list'] != null
        ? new LikeGameList.fromJson(json['game_list'])
        : List();
    commentStar = CommentStar.fromJson(json['comment_star']);
    player = json['player'] != null ? json['player'].cast<String>() : List();
    qqGroup = json['qq_group'];

    if (json['bt_tags'] != null) {
      btTags = new List<BtTag>();
      json['bt_tags'].forEach((v) {
        btTags.add(new BtTag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_id'] = this.gameId;
    data['game_name'] = this.gameName;
    data['icon'] = this.icon;
    data['size'] = this.size;
    data['category'] = this.category;
    data['type'] = this.type;
    data['tags_arr'] = this.tagsArr;
    data['down_cnt'] = this.downCnt;
    data['down_url'] = this.downUrl;
    data['gift_cnt'] = this.giftCnt;
    data['package_name'] = this.packageName;
    data['one_word'] = this.oneWord;
    data['run_time'] = this.runTime;
    data['classify'] = this.classify;
    data['version'] = this.version;
    data['app_hot_image'] = this.appHotImage;
    data['rate'] = this.rate;
    data['is_bt'] = this.isBt;
    data['uc_id'] = this.ucId;
    data['benefit_type'] = this.benefitType;
    data['status'] = this.status;
    data['star_cnt'] = this.starCnt;
    data['desc'] = this.desc;
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    data['rebate_description'] = this.rebateDescription;
    data['vip_description'] = this.vipDescription;
    data['is_reservation'] = this.isReservation;
    if (this.serlist != null) {
      data['serlist'] = this.serlist.toJson();
    }
    data['news'] = this.news;
    if (this.gameList != null) {
      data['game_list'] = this.gameList.toJson();
    }
    return data;
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

class ImageMod {
  String url;
  String name;
  bool isVideo = false;

  ImageMod({this.url, this.name, this.isVideo});

  ImageMod.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}

class LikeGameList {
  int count;
  List<Game> list;

  LikeGameList({this.count, this.list});

  LikeGameList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Game>();
      json['list'].forEach((v) {
        list.add(new Game.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Serlist {
  int count;
  List<Ser> list;

  Serlist({this.count, this.list});

  Serlist.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Ser>();
      json['list'].forEach((v) {
        list.add(new Ser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ser {
  int id;
  int appId;
  String serverId;
  String serverName;
  String serverDesc;
  int status;
  int startTime;
  String gameName;
  String gameIcon;
  int classify;

  Ser(
      {this.id,
      this.appId,
      this.serverId,
      this.serverName,
      this.serverDesc,
      this.status,
      this.startTime,
      this.gameName,
      this.gameIcon,
      this.classify});

  Ser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    serverId = json['server_id'];
    serverName = json['server_name'];
    serverDesc = json['server_desc'];
    status = json['status'];
    startTime = json['start_time'];
    gameName = json['game_name'];
    gameIcon = json['game_icon'];
    classify = json['classify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_id'] = this.appId;
    data['server_id'] = this.serverId;
    data['server_name'] = this.serverName;
    data['server_desc'] = this.serverDesc;
    data['status'] = this.status;
    data['start_time'] = this.startTime;
    data['game_name'] = this.gameName;
    data['game_icon'] = this.gameIcon;
    data['classify'] = this.classify;
    return data;
  }
}

class News {
  int newsId;
  String title;
  String viewUrl;

  News({this.newsId, this.title, this.viewUrl});

  News.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    title = json['title'];
    viewUrl = json['view_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['title'] = this.title;
    data['view_url'] = this.viewUrl;
    return data;
  }
}

class Vip {
  String newsId;
  String title;
  String viewUrl;

  Vip({this.newsId, this.title, this.viewUrl});

  Vip.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    title = json['title'];
    viewUrl = json['view_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['title'] = this.title;
    data['view_url'] = this.viewUrl;
    return data;
  }
}

class CommentStar {
  double starCnt;
  int starAll;
  int star1;
  int star2;
  int star3;
  int star4;
  int star5;
  int isScore;

  CommentStar(
      {this.starCnt,
      this.starAll,
      this.star1,
      this.star2,
      this.star3,
      this.star4,
      this.star5,
      this.isScore});

  CommentStar.fromJson(Map<String, dynamic> json) {
    starCnt = double.parse(json['star_cnt'].toString());
    starAll = json['star_all'];
    star1 = json['star1'];
    star2 = json['star2'];
    star3 = json['star3'];
    star4 = json['star4'];
    star5 = json['star5'];
    isScore = json['is_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['star_cnt'] = this.starCnt;
    data['star_all'] = this.starAll;
    data['star1'] = this.star1;
    data['star2'] = this.star2;
    data['star3'] = this.star3;
    data['star4'] = this.star4;
    data['star5'] = this.star5;
    data['is_score'] = this.isScore;
    return data;
  }
}
