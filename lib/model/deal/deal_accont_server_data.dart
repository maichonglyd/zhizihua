// 小号区服信息

import '../base_model.dart';

class DealAccountServerData extends BaseModel<Data> {
  DealAccountServerData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int mgMemId;
  String serverId;
  String serverName;
  String roleId;
  String roleName;

  Data(
      {this.mgMemId,
      this.serverId,
      this.serverName,
      this.roleId,
      this.roleName});

  Data.fromJson(Map<String, dynamic> json) {
    mgMemId = json['mg_mem_id'];
    serverId = json['server_id'];
    serverName = json['server_name'];
    roleId = json['role_id'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mg_mem_id'] = this.mgMemId;
    data['server_id'] = this.serverId;
    data['server_name'] = this.serverName;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    return data;
  }
}
