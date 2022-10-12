import 'game_bean.dart';

class GameBannerItem {
  String name;
  String typeName;
  int targetId;
  String url;
  String image;
  String content;
  String desc;
  Null gift;
  Game game;
  Null posts;
  double videoScale;

  GameBannerItem(
      {this.name,
      this.typeName,
      this.targetId,
      this.url,
      this.image,
      this.content,
      this.desc,
      this.gift,
      this.game,
      this.posts,
      this.videoScale});

  GameBannerItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    typeName = json['type_name'];
    targetId = json['target_id'];
    url = json['url'];
    image = json['image'];
    content = json['content'];
    desc = json['desc'];
    gift = json['gift'];
    game = json['game'] != null ? new Game.fromJson(json['game']) : null;
    posts = json['posts'];
    videoScale = _parseVideoScale(json['video_scale'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type_name'] = this.typeName;
    data['target_id'] = this.targetId;
    data['url'] = this.url;
    data['image'] = this.image;
    data['content'] = this.content;
    data['desc'] = this.desc;
    data['gift'] = this.gift;
    if (this.game != null) {
      data['game'] = this.game.toJson();
    }
    data['posts'] = this.posts;
    return data;
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
