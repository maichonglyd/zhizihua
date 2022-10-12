import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import '../base_model.dart';

class NewList extends BaseModel<Data> {
  NewList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<New> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<New>();
      json['list'].forEach((v) {
        list.add(new New.fromJson(v));
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

class New {
  int id;
  int newsId;
  int userId;
  String title;
  String postTitle;
  String excerpt;
  int appId;
  int gameId;
  int postHits;
  int postStatus;
  int publishedTime;
  int pubTime;
  More more;
  int postType;
  String type;
  int startTime;
  int endTime;
  String url;
  String costIntegral;
  String gameName;
  int classify;
  String gameIcon;
  String userNicename;
  String thumbnail;
  String typeTxt;
  String noticeUrl;
  String videoUrl;
  Game game;
  int likeCnt;
  int shareCnt;
  int commentCnt;
  int isLike;
  double videoScale;

  New(
      {this.id,
      this.newsId,
      this.userId,
      this.title,
      this.postTitle,
      this.excerpt,
      this.appId,
      this.gameId,
      this.postHits,
      this.postStatus,
      this.publishedTime,
      this.pubTime,
      this.more,
      this.postType,
      this.type,
      this.startTime,
      this.endTime,
      this.url,
      this.costIntegral,
      this.gameName,
      this.classify,
      this.gameIcon,
      this.userNicename,
      this.thumbnail,
      this.typeTxt,
      this.noticeUrl,
      this.videoUrl,
      this.game,
      this.likeCnt,
      this.shareCnt,
      this.commentCnt,
      this.isLike,
      this.videoScale});

  New.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsId = json['news_id'];
    userId = json['user_id'];
    title = json['title'];
    postTitle = json['post_title'];
    excerpt = json['excerpt'];
    appId = json['app_id'];
    gameId = json['game_id'];
    postHits = json['post_hits'];
    postStatus = json['post_status'];
    publishedTime = json['published_time'];
    pubTime = json['pub_time'];
    more = json['more'] != null ? new More.fromJson(json['more']) : null;
    postType = json['post_type'];
    type = json['type'].toString();
    startTime = json['start_time'];
    endTime = json['end_time'];
    url = json['url'];
    costIntegral = json['cost_integral'];
    gameName = json['game_name'];
    classify = json['classify'];
    gameIcon = json['game_icon'];
    userNicename = json['user_nicename'];
    thumbnail = json['thumbnail'];
    typeTxt = json['type_txt'];
    noticeUrl = json['notice_url'];
    videoUrl = json['video_url'];
    likeCnt = json['post_like'];
    shareCnt = json['post_share'];
    isLike = json['is_like'];
    commentCnt = json['comment_cnt'];
    game =
        json['game_info'] != null ? new Game.fromJson(json['game_info']) : null;
    videoScale = _parseVideoScale(json['video_scale'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['news_id'] = this.newsId;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['post_title'] = this.postTitle;
    data['excerpt'] = this.excerpt;
    data['app_id'] = this.appId;
    data['game_id'] = this.gameId;
    data['post_hits'] = this.postHits;
    data['post_status'] = this.postStatus;
    data['published_time'] = this.publishedTime;
    data['pub_time'] = this.pubTime;
    if (this.more != null) {
      data['more'] = this.more.toJson();
    }
    data['post_type'] = this.postType;
    data['type'] = this.type;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['url'] = this.url;
    data['cost_integral'] = this.costIntegral;
    data['game_name'] = this.gameName;
    data['classify'] = this.classify;
    data['game_icon'] = this.gameIcon;
    data['user_nicename'] = this.userNicename;
    data['thumbnail'] = this.thumbnail;
    data['type_txt'] = this.typeTxt;
    data['notice_url'] = this.noticeUrl;
    data['video_url'] = this.videoUrl;
    data['is_like'] = this.isLike;
    if (this.game != null) {
      data['game_info'] = this.game.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'New{id: $id, newsId: $newsId, userId: $userId, title: $title, postTitle: $postTitle, excerpt: $excerpt, appId: $appId, gameId: $gameId, postHits: $postHits, postStatus: $postStatus, publishedTime: $publishedTime, pubTime: $pubTime, more: $more, postType: $postType, type: $type, startTime: $startTime, endTime: $endTime, url: $url, costIntegral: $costIntegral, gameName: $gameName, classify: $classify, gameIcon: $gameIcon, userNicename: $userNicename, thumbnail: $thumbnail, typeTxt: $typeTxt, noticeUrl: $noticeUrl, videoUrl: $videoUrl, game: $game, likeCnt: $likeCnt, shareCnt: $shareCnt, commentCnt: $commentCnt, isLike: $isLike}';
  }

  double _parseVideoScale(String str) {
    if (str.isEmpty || "null" == str || str.length == 0) return 16 / 9;

    String widthStr = str.substring(0, str.indexOf(":"));
    String heightStr = str.substring(str.indexOf(":") + 1, str.length);
    try {
      double width = double.parse(widthStr);
      double height = double.parse(heightStr);
      return width / height;
    } catch (e) {
      print("error: video scale parse failed! json['video_scale'] = $str");
      return 16 / 9;
    }
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
