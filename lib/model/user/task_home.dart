class TaskHome {
  int code;
  String msg;
  Data data;

  TaskHome({this.code, this.msg, this.data});

  TaskHome.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Daily daily;
  One one;

  Data({this.daily, this.one});

  Data.fromJson(Map<String, dynamic> json) {
    daily = json['daily'] != null ? new Daily.fromJson(json['daily']) : null;
    one = json['one'] != null ? new One.fromJson(json['one']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.daily != null) {
      data['daily'] = this.daily.toJson();
    }
    if (this.one != null) {
      data['one'] = this.one.toJson();
    }
    return data;
  }
}

class Daily {
  int count;
  List<TaskBean> list;

  Daily({this.count, this.list});

  Daily.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<TaskBean>();
      json['list'].forEach((v) {
        list.add(new TaskBean.fromJson(v));
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

class One {
  int count;
  List<TaskBean> list;

  One({this.count, this.list});

  One.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<TaskBean>();
      json['list'].forEach((v) {
        list.add(new TaskBean.fromJson(v));
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

class TaskBean {
  int iaId;
  String iaCode;
  String iaName;
  String icon;
  String iaDesc;
  int integral;
  int startTime;
  int endTime;
  String type;
  int finishFlag;
  //vip加成
  String vipBonus;

  TaskBean(
      {this.iaId,
      this.iaCode,
      this.iaName,
      this.icon,
      this.iaDesc,
      this.integral,
      this.startTime,
      this.endTime,
      this.type,
      this.vipBonus,
      this.finishFlag});

  TaskBean.fromJson(Map<String, dynamic> json) {
    iaId = json['ia_id'];
    iaCode = json['ia_code'];
    iaName = json['ia_name'];
    icon = json['icon'];
    iaDesc = json['ia_desc'];
    integral = json['integral'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    type = json['type'];
    vipBonus = json['vip_bonus'];
    finishFlag = json['finish_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ia_id'] = this.iaId;
    data['ia_code'] = this.iaCode;
    data['ia_name'] = this.iaName;
    data['icon'] = this.icon;
    data['ia_desc'] = this.iaDesc;
    data['integral'] = this.integral;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['type'] = this.type;
    data['finish_flag'] = this.finishFlag;
    return data;
  }
}
