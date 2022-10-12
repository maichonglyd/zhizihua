import '../base_model.dart';
import 'game_bean.dart';

class NewsDetailsData extends BaseModel<Data> {
  NewsDetailsData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int newsId;
  String postTitle;
  int appId;
  int publishedTime;
  int postType;
  int startTime;
  int endTime;
  String url;
  String postContent;
  String gameName;
  String gameIcon;
  String thumbnail;
  String typeTxt;
  Game game;
  String oneWord;
  List<String> type;
  String size;

  Data({
    this.newsId,
    this.postTitle,
    this.appId,
    this.publishedTime,
    this.postType,
    this.startTime,
    this.endTime,
    this.url,
    this.postContent,
    this.gameName,
    this.gameIcon,
    this.thumbnail,
    this.typeTxt,
    this.game,
    this.oneWord,
    this.type,
    this.size,
  });

  Data.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    postTitle = json['post_title'];
    appId = json['app_id'];
    publishedTime = json['published_time'];
    postType = json['post_type'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    url = json['url'];
    postContent = json['post_content'];
    gameName = json['game_name'];
    gameIcon = json['game_icon'];
    thumbnail = json['thumbnail'];
    typeTxt = json['type_txt'];
    print(json['game'].toString());
    game = (json['game'] != null && json['game'].toString() != "[]")
        ? new Game.fromJson(json['game'])
        : null;

    oneWord = json['one_word'];
    size = json['size'];
    type = json['type'] != null ? json['type'].cast<String>() : List();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['post_title'] = this.postTitle;
    data['app_id'] = this.appId;
    data['published_time'] = this.publishedTime;
    data['post_type'] = this.postType;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['url'] = this.url;
    data['post_content'] = this.postContent;
    data['game_name'] = this.gameName;
    data['game_icon'] = this.gameIcon;
    data['thumbnail'] = this.thumbnail;
    data['type_txt'] = this.typeTxt;
    if (this.game != null) {
      data['game'] = this.game.toJson();
    }
    return data;
  }
}
