import '../base_model.dart';
import 'game_bean.dart';

class SearchHotGameList extends BaseModel<Data> {
  SearchHotGameList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  List<DataBean> list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<DataBean>();
      json['list'].forEach((v) {
        list.add(new DataBean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataBean {
  String appId;
  Game game;
  String searchType;

  DataBean({this.appId, this.game, this.searchType});

  DataBean.fromJson(Map<String, dynamic> json) {
    appId = json['app_id'];
    game = json['game'] != null ? new Game.fromJson(json['game']) : null;
    searchType = json['search_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_id'] = this.appId;
    if (this.game != null) {
      data['game'] = this.game.toJson();
    }
    data['search_type'] = this.searchType;
    return data;
  }
}
