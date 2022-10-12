import '../base_model.dart';

class DealPropServerData extends BaseModel<Data> {
  DealPropServerData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Service> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Service>();
      json['list'].forEach((v) {
        list.add(new Service.fromJson(v));
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

class Service {
  String serverId;
  String serverName;

  Service({this.serverId, this.serverName});

  Service.fromJson(Map<String, dynamic> json) {
    serverId = json['server_id'];
    serverName = json['server_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server_id'] = this.serverId;
    data['server_name'] = this.serverName;
    return data;
  }
}
