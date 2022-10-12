import 'package:flutter_huoshu_app/model/game/game_special.dart';

class FragmentConstant {
  static int classifySelectTypeId = 0;
  static int newGameNoticeTopicId = -1;
  static String newGameNoticeTopicTitle = '';
  static int gameQualitySelectIndex = 0;
  static int gameNewNoticeSelectIndex = 0;
  static Map<String, int> specialGameSelectIndex = <String, int>{};

  static void addSpecialGameSelectIndex(String key, int index) {
    if (specialGameSelectIndex.containsKey(key)) {
      specialGameSelectIndex[key] = index;
    } else {
      specialGameSelectIndex.addAll({key: index});
    }
  }

  static int getSpecialGameSelectIndex(String key) {
    if (specialGameSelectIndex.containsKey(key)) {
      return specialGameSelectIndex[key];
    } else {
      return 0;
    }
  }

  static void setNewGameNoticeTopic(int topicId, String topicName) {
    newGameNoticeTopicId = topicId;
    newGameNoticeTopicTitle = topicName;
  }
}

bool noGameList(GameSpecial gameSpecial) {
  return null == gameSpecial ||
      null == gameSpecial.gameList ||
      gameSpecial.gameList.length <= 0;
}

bool noCateList(GameSpecial gameSpecial) {
  return null == gameSpecial ||
      null == gameSpecial.cateList ||
      gameSpecial.cateList.length <= 0;
}

bool noServerList(GameSpecial gameSpecial) {
  return null == gameSpecial ||
      null == gameSpecial.serverList ||
      gameSpecial.serverList.length <= 0;
}