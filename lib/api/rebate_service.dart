import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_list.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_record.dart';
import 'package:flutter_huoshu_app/model/rebate/rebate_game_roles.dart';

class RebateService {
  //获取返利游戏列表
  static Future<RebateGameList> getRebateList(int page,int offset) async {
    dynamic response = await CommonDio.post("app/user/rebate/list",data: {
      "page":page,
      "offset":offset,
    });
    return RebateGameList.fromJson(response);
  }

  //获取返利记录
  static Future<RebateRecordList> getRebateRecordList(int page,int offset) async {
    dynamic response = await CommonDio.post("app/user/rebate/rlist",data: {
      "page":page,
      "offset":offset
    });
    return RebateRecordList.fromJson(response);
  }

  //获取游戏区服信息
  static Future<RebateRolesList> getRebateRolesInfo(int gameId) async {
    dynamic response = await CommonDio.post("app/user/rebate/roles_info",
        data: {"game_id": gameId});
    return RebateRolesList.fromJson(response);
  }

  //申请返利
  static Future addRebate(
      int gameId,
      int mgMemId,
      String serverId,
      String serverName,
      String roleId,
      String roleName,
      String mobile,
      String remark,
      String startDate,
      String endDate) async {
    dynamic response = await CommonDio.post("app/user/rebate/add",data: {
      "game_id":gameId,
      "mg_mem_id":mgMemId,
      "server_id":serverId,
      "server_name":serverName,
      "role_id":roleId,
      "role_name":roleName,
      "mobile":mobile,
      "remark":remark,
      "start_date":startDate,
      "end_date":endDate
    });
    return response;
  }

  //申请返利金钱
  static Future getAmount(int gameId,String date) async {
    dynamic response = await CommonDio.post("app/user/rebate/get_amount",
        data: {"game_id": gameId,"start_date":date,"end_date":date});
    return response;
  }
}
