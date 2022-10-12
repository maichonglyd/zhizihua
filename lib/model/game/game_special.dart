import 'game_bean.dart';

class GameSpecial {
  int topicId;
  String topicName;
  String image;
  String gameId;
  String enName;
  String gameUrl;
  List<Game> gameList;
  int direction;
  String videoUrl;

  //最新上架和人气热门做成专栏
  List<GameListBean> gameListArray;
  int styleType;
  int listOrder;
  Game game;

  String desc;
  List<CateList> cateList;
  List<ServerBean> serverList;

  GameSpecial(
      {this.topicId,
      this.topicName,
      this.image,
      this.gameId,
      this.enName,
      this.gameUrl,
      this.gameList,
      this.gameListArray,
      this.styleType,
      this.game,
      this.videoUrl,
      this.direction,
      this.listOrder});

  GameSpecial.fromJson(Map<String, dynamic> json) {
    topicId = json['topic_id'];
    // direction = json['direction'];
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
    topicName = json['topic_name'];
    image = json['image'];
    gameId = json['game_id'].toString();
    enName = json['en_name'];
    gameUrl = json['game_url'];
    videoUrl = json['video_url'];

    styleType = json['style_type'];
    listOrder = json['list_order'];
    game = json['game'] != null ? new Game.fromJson(json['game']) : null;
    if (json['game_list_array'] != null) {
      gameListArray = new List<GameListBean>();
      json['game_list_array'].forEach((v) {
        gameListArray.add(new GameListBean.fromJson(v));
      });
    }

    if (json['game_list'] != null) {
      gameList = new List<Game>();
      json['game_list'].forEach((v) {
        gameList.add(new Game.fromJson(v));
      });
    }
    desc = json['desc'];
    if (json['cate_list'] != null) {
      cateList = new List<CateList>();
      json['cate_list'].forEach((v) {
        cateList.add(new CateList.fromJson(v));
      });
    }

    if (json['server_list'] != null) {
      serverList = new List<ServerBean>();
      json['server_list'].forEach((v) {
        serverList.add(new ServerBean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic_id'] = this.topicId;
    data['topic_name'] = this.topicName;
    data['image'] = this.image;
    data['game_id'] = this.gameId;
    data['en_name'] = this.enName;
    data['game_url'] = this.gameUrl;
    data['style_type'] = this.styleType;
    data['list_order'] = this.listOrder;
    if (this.game != null) {
      data['game'] = this.game.toJson();
    }
    if (this.gameListArray != null) {
      data['gameListArray'] =
          this.gameListArray.map((v) => v.toJson()).toList();
    }
    if (this.gameList != null) {
      data['game_list'] = this.gameList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GameListBean {
  String title;
  List<Game> gameList;

  GameListBean({
    this.title,
    this.gameList,
  });

  GameListBean.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['game_list'] != null) {
      gameList = new List<Game>();
      json['game_list'].forEach((v) {
        gameList.add(new Game.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.gameList != null) {
      data['game_list'] = this.gameList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CateList {
  num typeId;
  String typeName;

  CateList.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    typeName = json['type_name'];
  }
}

class ServerBean {
  num id;
  num appId;
  String serverId;
  String serverName;
  String serverDesc;
  num status;
  num startTime;
  String gameName;
  String gameIcon;
  num classify;
  List<String> singleTag;

  ServerBean.fromJson(Map<String, dynamic> json) {
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
    singleTag = tagToList(json['single_tag']);
  }
}
