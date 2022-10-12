import '../base_model.dart';
import 'game_banner.dart';
import 'game_bean.dart';
import 'game_special.dart';

class HomeData extends BaseModel<Data> {
  HomeData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  HomeTopper homeTopper;
  RmdGame rmdGame;
  HotGame hotGame;
  NewGame newGame;
  SubscribeGame subscribeGame;
  SpecialList specialList;
  HomePush homePush;
  List<HomeNotice> homeNotice;
  PlayedList playedList;
  AppIndexTextList appIndexTextList;

  Data(
      {this.homeTopper,
      this.rmdGame,
      this.hotGame,
      this.newGame,
      this.subscribeGame,
      this.specialList,
      this.homePush,
      this.homeNotice,
      this.playedList,
      this.appIndexTextList});

  Data.fromJson(Map<String, dynamic> json) {
    homeTopper = json['home_topper'] != null
        ? new HomeTopper.fromJson(json['home_topper'])
        : null;
    rmdGame = json['rmd_game'] != null
        ? new RmdGame.fromJson(json['rmd_game'])
        : RmdGame(count: 0, list: []);
    hotGame = json['hot_game'] != null
        ? new HotGame.fromJson(json['hot_game'])
        : null;
    newGame = json['new_game'] != null
        ? new NewGame.fromJson(json['new_game'])
        : null;
    subscribeGame = json['subscribe_list'] != null
        ? new SubscribeGame.fromJson(json['subscribe_list'])
        : null;
    specialList = json['special_list'] != null
        ? new SpecialList.fromJson(json['special_list'])
        : null;

    appIndexTextList = json['app_index_text'] != null
        ? new AppIndexTextList.fromJson(json['app_index_text'])
        : null;

    playedList = json['play_game_list'] != null
        ? new PlayedList.fromJson(json['play_game_list'])
        : null;

    homePush = json['home_push'] != null
        ? new HomePush.fromJson(json['home_push'])
        : null;

    if (json['home_notice'] != null) {
      homeNotice = new List<HomeNotice>();
      json['home_notice']['list'].forEach((v) {
        homeNotice.add(new HomeNotice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.homeTopper != null) {
      data['home_topper'] = this.homeTopper.toJson();
    }
    if (this.rmdGame != null) {
      data['rmd_game'] = this.rmdGame.toJson();
    }
    if (this.hotGame != null) {
      data['hot_game'] = this.hotGame.toJson();
    }
    if (this.newGame != null) {
      data['new_game'] = this.newGame.toJson();
    }
    if (this.subscribeGame != null) {
      data['subscribe_list'] = this.subscribeGame.toJson();
    }
    if (this.specialList != null) {
      data['special_list'] = this.specialList.toJson();
    }

    if (this.playedList != null) {
      data['play_game_list'] = this.playedList.toJson();
    }

    if (this.appIndexTextList != null) {
      data['app_index_text'] = this.appIndexTextList.toJson();
    }

    if (this.homePush != null) {
      data['home_push'] = this.homePush.toJson();
    }

    if (this.homeNotice != null) {
      data['home_notice'] = this.homeNotice.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomePush {
  int appId;
  String image;
  String newsTitle;
  String newsUrl;

  HomePush({this.appId, this.image, this.newsTitle, this.newsUrl});

  HomePush.fromJson(Map<String, dynamic> json) {
    appId = json['app_id'];
    image = json['image'];
    newsTitle = json['news_title'];
    newsUrl = json['news_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_id'] = this.appId;
    data['image'] = this.image;
    data['news_title'] = this.newsTitle;
    data['news_url'] = this.newsUrl;
    return data;
  }
}

class HomeTopper {
  int count;
  List<GameBannerItem> list;

  HomeTopper({this.count, this.list});

  HomeTopper.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<GameBannerItem>();
      json['list'].forEach((v) {
        list.add(new GameBannerItem.fromJson(v));
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

class RmdGame {
  int count;
  List<Game> list;

  RmdGame({this.count, this.list});

  RmdGame.fromJson(Map<String, dynamic> json) {
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

  @override
  String toString() {
    return 'RmdGame{count: $count, list: $list}';
  }
}

//新游预约
class SubscribeGame {
  int count;
  List<Game> list;

  SubscribeGame({this.count, this.list});

  SubscribeGame.fromJson(Map<String, dynamic> json) {
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

class HotGame {
  int count;
  List<Game> list;

  HotGame({this.count, this.list});

  HotGame.fromJson(Map<String, dynamic> json) {
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

class NewGame {
  int count;
  List<Game> list;

  NewGame({this.count, this.list});

  NewGame.fromJson(Map<String, dynamic> json) {
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

class SpecialList {
  int count;
  List<GameSpecial> list;

  SpecialList({this.count, this.list});

  SpecialList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<GameSpecial>();
      json['list'].forEach((v) {
        list.add(new GameSpecial.fromJson(v));
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

class HomeNotice {
  int appId;
  int classify;
  String costIntegral;
  int endTime;
  String excerpt;
  String gameIcon;
  int gameId;
  String gameName;
  int id;
  String img;
  More more;
  int newsId;
  String noticeUrl;
  int postHits;
  int postStatus;
  String postTitle;
  int postType;
  int pubTime;
  int publishedTime;
  int startTime;
  String thumbnail;
  String title;
  String type;
  String typeTxt;
  String url;
  int userId;
  String userNicename;

  HomeNotice(
      {this.appId,
      this.classify,
      this.costIntegral,
      this.endTime,
      this.excerpt,
      this.gameIcon,
      this.gameId,
      this.gameName,
      this.id,
      this.img,
      this.more,
      this.newsId,
      this.noticeUrl,
      this.postHits,
      this.postStatus,
      this.postTitle,
      this.postType,
      this.pubTime,
      this.publishedTime,
      this.startTime,
      this.thumbnail,
      this.title,
      this.type,
      this.typeTxt,
      this.url,
      this.userId,
      this.userNicename});

  HomeNotice.fromJson(Map<String, dynamic> json) {
    appId = json['app_id'];
    classify = json['classify'];
    costIntegral = json['cost_integral'];
    endTime = json['end_time'];
    excerpt = json['excerpt'];
    gameIcon = json['game_icon'];
    gameId = json['game_id'];
    gameName = json['game_name'];
    id = json['id'];
    img = json['img'];
    more = json['more'] != null ? new More.fromJson(json['more']) : null;
    newsId = json['news_id'];
    noticeUrl = json['notice_url'];
    postHits = json['post_hits'];
    postStatus = json['post_status'];
    postTitle = json['post_title'];
    postType = json['post_type'];
    pubTime = json['pub_time'];
    publishedTime = json['published_time'];
    startTime = json['start_time'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    type = json['type'].toString();
    typeTxt = json['type_txt'];
    url = json['url'];
    userId = json['user_id'];
    userNicename = json['user_nicename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_id'] = this.appId;
    data['classify'] = this.classify;
    data['cost_integral'] = this.costIntegral;
    data['end_time'] = this.endTime;
    data['excerpt'] = this.excerpt;
    data['game_icon'] = this.gameIcon;
    data['game_id'] = this.gameId;
    data['game_name'] = this.gameName;
    data['id'] = this.id;
    data['img'] = this.img;
    if (this.more != null) {
      data['more'] = this.more.toJson();
    }
    data['news_id'] = this.newsId;
    data['notice_url'] = this.noticeUrl;
    data['post_hits'] = this.postHits;
    data['post_status'] = this.postStatus;
    data['post_title'] = this.postTitle;
    data['post_type'] = this.postType;
    data['pub_time'] = this.pubTime;
    data['published_time'] = this.publishedTime;
    data['start_time'] = this.startTime;
    data['thumbnail'] = this.thumbnail;
    data['title'] = this.title;
    data['type'] = this.type;
    data['type_txt'] = this.typeTxt;
    data['url'] = this.url;
    data['user_id'] = this.userId;
    data['user_nicename'] = this.userNicename;
    return data;
  }
}

class More {
  String thumbnail;

  More({this.thumbnail});

  More.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class PlayedList {
  int count;
  List<PlayedListData> list;

  PlayedList({this.count, this.list});

  PlayedList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<PlayedListData>();
      json['list'].forEach((v) {
        list.add(new PlayedListData.fromJson(v));
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

class PlayedListData {
  int accountCnt;
  String gameIcon;
  int gameId;
  String gameName;
  Game game;

  PlayedListData({this.accountCnt, this.gameIcon, this.gameId, this.gameName});

  PlayedListData.fromJson(Map<String, dynamic> json) {
    accountCnt = json['account_cnt'];
    gameIcon = json['game_icon'];
    gameId = json['game_id'];
    gameName = json['game_name'];
    game = json['game'] != null ? new Game.fromJson(json['game']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_cnt'] = this.accountCnt;
    data['game_icon'] = this.gameIcon;
    data['game_id'] = this.gameId;
    data['game_name'] = this.gameName;
    if (this.game != null) {
      data['game'] = this.game.toJson();
    }

    return data;
  }
}

class AppIndexTextList {
  int count;
  List<AppIndexTextListData> list;

  AppIndexTextList({this.count, this.list});

  AppIndexTextList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<AppIndexTextListData>();
      json['list'].forEach((v) {
        list.add(new AppIndexTextListData.fromJson(v));
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

class AppIndexTextListData {
  String content;
  String desc;
  String image;
  String name;
  int targetId;
  String typeName;
  String url;
  Game game;

  String nickname;
  String gameName;
  num money;

  AppIndexTextListData(
      {this.content,
      this.desc,
      this.image,
      this.name,
      this.targetId,
      this.typeName,
      this.url,
      this.game,
      this.nickname,
      this.gameName,
      this.money,});

  AppIndexTextListData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    desc = json['desc'];
    image = json['image'];
    name = json['name'];
    targetId = json['target_id'];
    typeName = json['type_name'];
    url = json['url'];
    game = json['game'] != null ? new Game.fromJson(json['game']) : null;
    nickname = json['nickname'];
    gameName = json['game_name'];
    money = json['money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['name'] = this.name;
    data['target_id'] = this.targetId;
    data['type_name'] = this.typeName;
    data['url'] = this.url;
    if (this.game != null) {
      data['game'] = this.game.toJson();
    }
    data['nickname'] = this.nickname;
    data['game_name'] = this.gameName;
    data['money'] = this.money;
    return data;
  }
}
