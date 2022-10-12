import '../base_model.dart';

class VIPMemInfoData extends BaseModel<MemInfoData> {
  VIPMemInfoData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = MemInfoData.fromJson(jsonRes);
  }
}

//data	Object	数据
//data.vip_id	String	当前VIP ID
//data.vip_name	String	当前VIP 名称
//data.vip_no	String	当前VIP编号
//data.start_time	String	有效开始时间
//data.end_time	String	有效结束时间
//data.max_bonus	String	最高奖励加成
//data.is_invest 2020-07-01	String	是否投资VIP 1否 2是
//data.can_get_ptb 2020-07-01	String	是否可领取 1否 2是
//data.mem_vip_id 2020-07-01	String	当前会员VIP的ID
//data.top_image 2020-07-01	String	顶部图片
//data.rules 2020-07-01	Array	规则说明
//data.vip_rights	Array	权益
//data.vip_rights.name	String	标题
//data.vip_rights.sub_name	String	子标
class MemInfoData {
  int vipId;
  String vipName;
  String vipNo;
  int startTime;
  int endTime;
  int maxBonus;
  int isInvest;
  int canGetPtb;
  int memVipId;
  String topImage;

  List<VIPRightMod> vipRights;
  List<String> rules;

  MemInfoData(
      {this.vipId,
      this.vipName,
      this.vipNo,
      this.endTime,
      this.startTime,
      this.maxBonus,
      this.rules,
      this.vipRights});

  MemInfoData.fromJson(Map<String, dynamic> json) {
    vipId = json['vip_id'];
    vipName = json['vip_name'];
    vipNo = json['vip_no'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    maxBonus = json['max_bonus'];
    rules = json['rules'] != null ? json['rules'].cast<String>() : null;

    isInvest = json['is_invest'];
    canGetPtb = json['can_get_ptb'];
    memVipId = json['mem_vip_id'];
    topImage = json['top_image'];

    if (json['vip_rights'] != null) {
      vipRights = new List<VIPRightMod>();
      json['vip_rights'].forEach((v) {
        vipRights.add(new VIPRightMod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vip_id'] = this.vipId;
    return data;
  }
}

//data.vip_rights.name	String	标题
//data.vip_rights.sub_name	String	子标题
//data.vip_rights.icon	String	icon
class VIPRightMod {
  String name;
  String subName;
  String icon;

  VIPRightMod({
    this.name,
    this.subName,
    this.icon,
  });

  VIPRightMod.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subName = json['sub_name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
