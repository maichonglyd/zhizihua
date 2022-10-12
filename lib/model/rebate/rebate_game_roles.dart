import '../base_model.dart';

class RebateRolesList extends BaseModel<Data> {
  RebateRolesList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Server> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Server>();
      json['list'].forEach((v) {
        list.add(new Server.fromJson(v));
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

class Server {
  String serverId;
  String serverName;
  List<RoleList> roleList;

  Server({this.serverId, this.serverName, this.roleList});

  Server.fromJson(Map<String, dynamic> json) {
    serverId = json['server_id'];
    serverName = json['server_name'];
    if (json['role_list'] != null) {
      roleList = new List<RoleList>();
      json['role_list'].forEach((v) {
        roleList.add(new RoleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server_id'] = this.serverId;
    data['server_name'] = this.serverName;
    if (this.roleList != null) {
      data['role_list'] = this.roleList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoleList {
  int mgMemId;
  String roleId;
  String roleName;

  RoleList({this.mgMemId, this.roleId, this.roleName});

  RoleList.fromJson(Map<String, dynamic> json) {
    mgMemId = json['mg_mem_id'];
    roleId = json['role_id'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mg_mem_id'] = this.mgMemId;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    return data;
  }
}
