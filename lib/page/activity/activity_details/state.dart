import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/newsdetails_bean.dart';

class ActivityDetailsState implements Cloneable<ActivityDetailsState> {
  int newsId;

  int type;

  int gameId;
  NewsDetailsData newsDetailsData;
  List<Game> channelGames;

  @override
  ActivityDetailsState clone() {
    return ActivityDetailsState()
      ..newsId = newsId
      ..newsDetailsData = newsDetailsData
      ..type = type
      ..gameId = gameId
      ..channelGames = channelGames;
  }
}

ActivityDetailsState initState(Map<String, dynamic> args) {
  return ActivityDetailsState()
    ..newsId = args["newsId"]
    ..type = args["type"]
    ..gameId = args["gameId"]
    ..channelGames = List();
}
