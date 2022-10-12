import '../base_model.dart';

class GameType extends BaseModel<Data> {
  GameType.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Type> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Type>();
      json['list'].forEach((v) {
        list.add(new Type.fromJson(v));
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

class Type {
  int id;
  int typeId;
  String typeName;
  int gameCnt;
  String image;
  int parentId;
  int subCnt;

  Type({
    this.id,
    this.typeId,
    this.typeName,
    this.gameCnt,
    this.image,
    this.parentId,
    this.subCnt,
  });

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['type_id'];
    typeName = json['type_name'];
    gameCnt = json['game_cnt'];
    image = json['image'];
    parentId = json['parent_id'];
    subCnt = json['sub_cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    data['game_cnt'] = this.gameCnt;
    data['image'] = this.image;
    data['parent_id'] = this.parentId;
    data['sub_cnt'] = this.subCnt;

    return data;
  }
}
