class GameCurrBean {
  int gameId;
  String gameName;
  String icon;

  //剩余游戏币
  num remain;
  String classifyLabel;

  GameCurrBean(
      {this.gameId, this.gameName, this.icon, this.classifyLabel, this.remain});

  GameCurrBean.fromJson(Map<String, dynamic> json) {
    gameId = json['app_id'];
    gameName = json['gamename'];
    icon = json['gameicon'];
    remain = json['remain'];
    classifyLabel = json['classify_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_id'] = this.gameId;
    data['game_name'] = this.gameName;
    data['icon'] = this.icon;
    data['classify_label'] = this.classifyLabel;
    return data;
  }
}
