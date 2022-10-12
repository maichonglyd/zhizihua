import '../base_model.dart';

class GameComments extends BaseModel<Data> {
  GameComments.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Comment> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Comment>();
      json['list'].forEach((v) {
        list.add(new Comment.fromJson(v));
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

class Comment {
  int id;
  int memId;
  String memAvatar;
  String memName;
  int likeCnt;
  int starCnt;
  int createTime;
  String timeStr;
  int isLike;
  String content;
 List<SubComment> sub;
  int sum;

  Comment(
      {this.id,
      this.memId,
      this.memAvatar,
      this.memName,
      this.likeCnt,
      this.starCnt,
      this.createTime,
      this.timeStr,
      this.isLike,
      this.content,
//        this.sub,
      this.sum});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memId = json['mem_id'];
    memAvatar = json['mem_avatar'];
    memName = json['mem_name'];
    likeCnt = json['like_cnt'];
    starCnt = json['star_cnt'];
    createTime = json['create_time'];
    timeStr = json['time_str'];
    isLike = json['is_like'];
    content = json['content'];
   if (json['sub'] != null) {
     sub = new List<SubComment>();
     json['sub'].forEach((v) {
       sub.add(new SubComment.fromJson(v));
     });
   }
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mem_id'] = this.memId;
    data['mem_avatar'] = this.memAvatar;
    data['mem_name'] = this.memName;
    data['like_cnt'] = this.likeCnt;
    data['star_cnt'] = this.starCnt;
    data['create_time'] = this.createTime;
    data['time_str'] = this.timeStr;
    data['is_like'] = this.isLike;
    data['content'] = this.content;
//    if (this.sub != null) {
//      data['sub'] = this.sub.map((v) => v.toJson()).toList();
//    }
    data['sum'] = this.sum;
    return data;
  }
}

class SubComment {
  int id;
  int memId;
  String memAvatar;
  String memName;
  int likeCnt;
  int starCnt;
  int createTime;
  String timeStr;
  int isLike;
  String content;
  num toMemId;
  String toMemAvatar;
  String toMemName;

  SubComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memId = json['mem_id'];
    memAvatar = json['mem_avatar'];
    memName = json['mem_name'];
    likeCnt = json['like_cnt'];
    starCnt = json['star_cnt'];
    createTime = json['create_time'];
    timeStr = json['time_str'];
    isLike = json['is_like'];
    content = json['content'];
    toMemId = json['to_mem_id'];
    toMemAvatar = json['to_mem_avatar'];
    toMemName = json['to_mem_name'];
  }

}
