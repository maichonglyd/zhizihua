import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

class ClassifyListMod extends BaseModel<ClassifyData> {
  ClassifyListMod.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = ClassifyData.fromJson(jsonRes);
  }
}

class ClassifyData {
  int count;
  List<GameClassifyType> list;

  ClassifyData(this.count, this.list);

  ClassifyData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<GameClassifyType>();
      json['list'].forEach((v) {
        list.add(new GameClassifyType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

//data.list.type_id	INT	类型ID
//data.list.type_name	STRING	类型名称	类型名称
//data.list.game_cnt	INT	游戏数量	此类型游戏数量
//data.list.image	STRING(URL)	类型名称	类型图标
//data.list.subcount	INT	子类型数量	表示子类型sublist
class GameClassifyType {
  int typeId; //		类型ID
  String typeName; //	STRING	类型名称
  int gameCnt; //此类型游戏数量
  String image; //类型图标
  int subCount; //		表示子类型sublist
  //是否选中
  bool isSelected = false;
  List<GameClassifyType> sublist;

  GameClassifyType(this.typeId, this.typeName, this.gameCnt, this.image,
      this.subCount, this.isSelected);

  GameClassifyType.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    typeName = json['type_name'];
    gameCnt = json['game_cnt'];
    image = json['image'];
    subCount = json['subcount'];

    if (json['sublist'] != null) {
      sublist = new List<GameClassifyType>();
      json['sublist'].forEach((v) {
        sublist.add(new GameClassifyType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    data['game_cnt'] = this.gameCnt;
    data['image'] = this.image;
    data['subcount'] = this.subCount;
    return data;
  }
}
