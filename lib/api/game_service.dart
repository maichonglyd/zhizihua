import 'package:flutter_huoshu_app/component/classify/model/classify_mod.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart';
import 'package:flutter_huoshu_app/model/game/game_jp.dart';
import 'package:flutter_huoshu_app/model/game/game_list.dart';
import 'package:flutter_huoshu_app/model/game/game_special_list.dart';
import 'package:flutter_huoshu_app/model/game/game_type.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:flutter_huoshu_app/model/game/newsdetails_bean.dart';
import 'package:flutter_huoshu_app/model/game/search_hot_list.dart';
import 'package:flutter_huoshu_app/model/game_dto.dart';
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';
import 'package:flutter_huoshu_app/model/sign/ipa_sign.dart';

import 'common_dio.dart';

class GameService {
  Future<GameDTO> getGameDetail(int id) async {
//    CommonDio.dio.get(path)
  }

  //手游模块
  static Future<HomeData> getHomeByHt() async {
    dynamic response = await CommonDio.post("mergeapp/home/mobile");
    return HomeData.fromJson(response);
  }

  static Future<HomeData> getHomeByBt() async {
    dynamic response = await CommonDio.post("mergeapp/home/bt");
    return HomeData.fromJson(response);
  }

  //自定义专栏
  static Future<HomeData> getHomeByCustom(String type) async {
    dynamic response =
        await CommonDio.post("mergeapp/home/customize", data: {"type": type});
    return HomeData.fromJson(response);
  }

  static Future<HomeData> getHomeByZk() async {
    dynamic response = await CommonDio.post("mergeapp/home/rate");
    return HomeData.fromJson(response);
  }

  static Future<HomeJPData> getHomeByJp(int page, int offset) async {
    dynamic response = await CommonDio.post("mergeapp/home/rmd",
        data: {"page": page, "offset": offset});
    return HomeJPData.fromJson(response);
  }

  static Future<HomeData> getHomeByH5() async {
    dynamic response = await CommonDio.post("mergeapp/home/h5");
    return HomeData.fromJson(response);
  }

  static Future<HomeData> getHomeByGM() async {
    dynamic response = await CommonDio.post("mergeapp/home/gm");
    return HomeData.fromJson(response);
  }

  static Future<GameList> getModGame(int page, int offset, String type) async {
    dynamic response = await CommonDio.post("app/modgame/list",
        data: {"page": page, "offset": offset, "type": type});
    return GameList.fromJson(response);
  }


  //获取用户收藏游戏列表
  static Future<GameList> getLikeGameList(int page, int offset) async {
    dynamic response = await CommonDio.post("app/game_like/list",
        data: {"page": page, "offset": offset});
    return GameList.fromJson(response);
  }

  static Future<GameType> getGameType() async {
    dynamic response = await CommonDio.post("app/game/gametype");
    return GameType.fromJson(response);
  }

  //类型筛选
  static Future<GameList> getGameListByType(data) async {
    dynamic response = await CommonDio.post("app/game/list", data: data);
    return GameList.fromJson(response);
  }

  //Gm游戏列表
  static Future<GameList> getGameListByGmHome(int page, int offset) async {
    dynamic response = await CommonDio.post("mergeapp/game/gm_home",
        data: {"page": page, "offset": offset});
    return GameList.fromJson(response);
  }

  //Gm游戏列表
  static Future<GameList> getGameListByGmMy(int page, int offset) async {
    dynamic response = await CommonDio.post("/mergeapp/game/gm_my",
        data: {"page": page, "offset": offset});
    return GameList.fromJson(response);
  }

  //游戏开服  // server_type 1今日 2即将 3已开服 4今日以后 0 所有
  static Future<GameList> getGameService(data) async {
    dynamic response = await CommonDio.post("app/gameserver/list", data: data);
    return GameList.fromJson(response);
  }

  //获取专题下的游戏列表
  static Future<GameSpecialList> getSpecialListGame(
      int topicId, int page, int offset) async {
    dynamic response = await CommonDio.post("app/game/special_list_game",
        data: {"topic_id": topicId, "page": page, "offset": offset});
    return GameSpecialList.fromJson(response);
  }

  //获取游戏详情
  static Future<GameDetails> getGameDetails(
    int gameId,
  ) async {
    dynamic response = await CommonDio.post("app/game/detail", data: {
      "game_id": gameId,
    });
    return GameDetails.fromJson(response);
  }

  //游戏评论列表
  static Future<GameComments> getComments(
    int gameId,
  ) async {
    dynamic response = await CommonDio.post("app/comments/list",
        data: {"object_id": gameId, "type_name": "game"});
    return GameComments.fromJson(response);
  }

  //发表评论
  static Future commitComments(int gameId, String content, int starCnt) async {
    dynamic response = await CommonDio.post("app/comments/add", data: {
      "object_id": gameId,
      "type_name": "game",
      "content": content,
      "star_cnt": starCnt
    });
    return response;
  }

  //搜索游戏
  static Future<GameList> searchGame(String key, int page, int offset) async {
    dynamic response = await CommonDio.post("app/game/list",
        data: {"keywords": key, "page": page, "offect": offset});
    return GameList.fromJson(response);
  }

  //热门搜索（是融合app的热门搜索）
  static Future<SearchHotGameList> getHotSearch() async {
//    dynamic response = await CommonDio.post("app/home/get_search",);
    dynamic response = await CommonDio.post(
      "mergeapp/home/get_search",
    );
    return SearchHotGameList.fromJson(response);
  }

  static Future getDownUrl(int gameId,
      {String udid, bool isShowToast = true, bool local_sign = true}) async {
    dynamic response = await CommonDio.post("app/game/down",
        data: {
          "game_id": gameId,
          "udid": udid,
          "local_sign": local_sign ? 2 : 1
        },
        isShowToast: isShowToast);
    return response;
  }

  //请求游戏本地签名接口
  static Future<IpaSignModel> getIOSSignUrl(int gameId,
      {String udid, int port, bool isShowToast = true}) async {
    dynamic response = await CommonDio.post("app/ios/sign",
        data: {"game_id": gameId, "udid": udid, "port": port},
        isShowToast: isShowToast,
        connectTimeout: 120000,
        receiveTimeout: 120000);
    return IpaSignModel.fromJson(response);
  }

//活动资讯列表
  static Future<NewList> getNewList(int type, int page, int offset) async {
    dynamic response = await CommonDio.post("app/news/list",
        data: {"type": type, "page": page, "offect": offset});
    return NewList.fromJson(response);
  }

  //活动资讯列表
  static Future<NewList> getNewListByGameId(
      int gameId, int type, int page, int offset) async {
    dynamic response = await CommonDio.post("app/news/list", data: {
      "type": type,
      "game_id": gameId,
      "page": page,
      "offect": offset
    });
    return NewList.fromJson(response);
  }

  //活动资讯列表
  static Future<NewsDetailsData> getNewDetails(int newsid) async {
    dynamic response = await CommonDio.post("app/news/detail", data: {
      "news_id": newsid,
    });
    return NewsDetailsData.fromJson(response);
  }

  static Future<GameComments> getCommentsList(
      int objectId, int page, int offset) async {
    dynamic response = await CommonDio.post("app/comments/list", data: {
      "object_id": objectId,
      "type_name": "page",
      "page": page,
      "offect": offset
    });
    return GameComments.fromJson(response);
  }

  static Future addComments(int objectId, String content) async {
    dynamic response = await CommonDio.post("app/comments/add", data: {
      "object_id": objectId,
      "type_name": "page",
      "content": content,
      "star_cnt": "10"
    });
    return response;
  }

  static Future commentsLike(int commentId, int type) async {
    dynamic response = await CommonDio.post("app/comments/like", data: {
      "comment_id": commentId,
      "type": type,
    });
    return response;
  }

  static Future videoLike(int newsId) async {
    dynamic response = await CommonDio.post("app/news/like", data: {
      "news_id": newsId,
    });
    return response;
  }

  static Future shareNotify(int newsId) async {
    dynamic response = await CommonDio.post("app/news/share", data: {
      "news_id": newsId,
    });
    return response;
  }

  //预约游戏
  static Future<BaseModel> subscribe(int gameId) async {
    dynamic response =
        await CommonDio.post("app/game/subscribe", data: {"game_id": gameId});
    return BaseModel.fromJson(response);
  }

  static Future<GameList> getSubscribeGameList(int subscribe, int page,
      {int isBt, int isRate, int classify}) async {
    dynamic response = await CommonDio.post("app/game/list", data: {
      "subscribe": subscribe,
      "page": page,
      "offset": 20,
      "is_rate": isRate,
      "is_bt": isBt,
      "classify": classify
    });
    return GameList.fromJson(response);
  }

  //通过游戏名获取cps游戏
  static Future<GameList> getGamesByGameName(
    String gameName,
  ) async {
    dynamic response = await CommonDio.post("app/game/list", data: {
      "mul_game_name": gameName,
    });
    return GameList.fromJson(response);
  }

  static Future<GameList> getCpsGame(int page, int gameId) async {
    dynamic response = await CommonDio.post("ncps/app/game/list",
        data: {"page": page, "game_id": gameId});
    return GameList.fromJson(response);
  }

  //获取分类游戏
  static Future<ClassifyListMod> getGamesType() async {
    dynamic response = await CommonDio.post("app/game/gametype");
    return ClassifyListMod.fromJson(response);
  }

  //获取分类列表数据
  static Future<GameList> getTypeGameList(int typeId, int page) async {
    dynamic response = await CommonDio.post("app/game/list",
        data: {"type_id": typeId, "page": page, "offset": 20});
    return GameList.fromJson(response);
  }

  static Future<GameList> getReverseGameList(int page) async {
    dynamic response = await CommonDio.post("app/game/subscribe/list",
        data: {"page": page, "offset": 20});
    return GameList.fromJson(response);
  }

  static Future<HomeData> getHomeByRp() async {
    dynamic response = await CommonDio.post("mergeapp/home/rp");
    return HomeData.fromJson(response);
  }

  static Future<HomeData> getHomeByRmd() async {
    dynamic response = await CommonDio.post("mergeapp/home/new_rmd");
    return HomeData.fromJson(response);
  }

  static Future<HomeData> getHomeByNew() async {
    dynamic response = await CommonDio.post("mergeapp/home/new");
    return HomeData.fromJson(response);
  }

  static Future<GameList> getGameTop(int type, int page, int offset,) async {
    dynamic response = await CommonDio.post("app/game/top", data: {
      "top_type": type,
      "page": page,
      "offect": offset,
    });
    return GameList.fromJson(response);
  }

  static Future<IndexTopTabModel> getTopTabList(String type) async {
    dynamic response = await CommonDio.post("app/game/special_list", data: {'type': type});
    return IndexTopTabModel.fromJson(response);
  }

  //游戏评论回复列表
  static Future<GameComments> getCommentResponseList(num gameId, num parentId, int page) async {
    dynamic response = await CommonDio.post("app/comments/list",
        data: {"object_id": gameId, 'parent_id': parentId, "type_name": "game", 'page': page});
    return GameComments.fromJson(response);
  }

  //发表评论
  static Future<BaseModel> responseComment(int id, String content, int starCnt) async {
    dynamic response = await CommonDio.post("app/comments/add", data: {
      "object_id": id,
      "type_name": "comment",
      "content": content,
      "star_cnt": starCnt
    });
    return BaseModel.fromJson(response);
  }
}
