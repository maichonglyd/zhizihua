import 'dart:core';

import 'package:flutter_huoshu_app/common/util/huo_log.dart';

//页面和视频都分是否可见
//页面下只能有一个页面可见
//页面下只能有一个视频可见
//视频可见表示的当前视频在页面下是活动的，是否播放还要依赖上层是否可见   （页面不可见时的自动滚动轮播
// 视频 有活跃状态，和 播放状态
// type 格式  num#num#num#num#num
// num数字表示当前级别下第几个,从0开始计数
// num 表示这一级别自己

class HuoVideoListener {
  void huoVideoPlay(String type, {int textureId}) {}

  void huoVideoPause(String type, {int textureId}) {}

  void huoVideoVolumePlay(String type, {int textureId}) {}

  void huoVideoVolumePause(String type, {int textureId}) {}
}

class HuoVideoViewExt {
  //类型
  String type;

  //视频id
  int textureId;

  //页面是否活跃，只是只在当前父页面中活跃，不代表真的可见，还有依赖上层是否可见
  bool active = false;

  //声音是否打开
  bool openAudio;

  //是否播放状态，可见但是可能受到别的影响导致不能播放（4g）
  bool play;

  //控制监听
  HuoVideoListener listener;

  HuoVideoViewExt(this.type, {this.active = false});

  @override
  String toString() {
    return '''{
    type:${type},
    textureId:${type},
    active:${active},
    play:${play},
    }''';
  }
}

///
/// 触发进行播放的操作：
/// 1、设置页面可见
/// 2、完善视频信息
///
/// 触发视频暂停的操作
/// 1、设置页面不活跃
///
///
class HuoVideoManager {
  static final String type_home = "1";
  static final String type_game_detail = "2";
  static final String type_other = "99";

  //type->HuoVideoViewExt
  static final huoVideoMap = <String, HuoVideoViewExt>{};

  //初始化主界面模型
  static void init() {
    add(HuoVideoViewExt(type_home));
    add(HuoVideoViewExt(type_game_detail));
    add(HuoVideoViewExt(type_other));
  }

  //添加，只是单纯记录
  static void add(HuoVideoViewExt ext) {
    //重复添加？
    if (huoVideoMap.containsKey(ext.type)) {
    } else {
      HuoLog.d("video add：${ext}");
      huoVideoMap[ext.type] = ext;
    }
  }

  //更新完善视频信息，可查询是否可以播放
  //在视频初始化完成后会调用
  static void updateVideoInfo(
      String type, int textureId, HuoVideoListener listener) {
    HuoLog.d("video updateVideoInfo：${type}");
    _debug();
    if (huoVideoMap.containsKey(type)) {
      HuoVideoViewExt ext = huoVideoMap[type];
      ext.textureId = textureId;
      ext.listener = listener;
      //判断当前自己是否可以播放，可以则播放
      if (_isCanPlay(ext)) {
        if (ext.listener != null && ext.textureId != null) {
          ext.listener.huoVideoPlay(ext.type, textureId: ext.textureId);
        }
      }
    } else {
      HuoVideoViewExt ext = HuoVideoViewExt(type);
      ext.textureId = textureId;
      ext.listener = listener;
      HuoVideoManager.add(ext);
      HuoLog.i("video error:${type}页面还没添加就完善视频信息！！！！");
    }
  }

  //移除
  static void remove(String type) {
    HuoLog.d("video remove：${type}");
    if (huoVideoMap.containsKey(type)) {
      huoVideoMap[type].active = false;
      huoVideoMap[type].listener = null;
      huoVideoMap[type].textureId = null;
    }
  }

  static void videoPause(String type) {
    HuoLog.d("video videoPause：${type}");
    if (huoVideoMap.containsKey(type)) {
      HuoVideoViewExt ext = huoVideoMap[type];
      ext.play = false;
      if (ext.active == false) {
        setViewActive(type);
        //todo liuhongliang 上级需要可见
      }
      if (ext.listener != null && ext.textureId != null) {
        return ext.listener.huoVideoPause(type);
      }
    }
  }

  static void videoPlay(String type) {
    HuoLog.d("video videoPlay：${type}");
    if (huoVideoMap.containsKey(type)) {
      HuoVideoViewExt ext = huoVideoMap[type];
      ext.play = true;
      //数据有问题了，需要进行修复，上级都需要可见
      if (ext.active == false) {
        setViewActive(type);
        //todo liuhongliang 上级需要可见
      }
      if (ext.listener != null && ext.textureId != null) {
        return ext.listener.huoVideoPlay(type);
      }
    }
  }

  static void pauseVolumeByType(String type) {
    HuoLog.d("video pauseVolumeByType：${type}");
    if (huoVideoMap.containsKey(type)) {
      HuoVideoViewExt ext = huoVideoMap[type];
      ext.openAudio = false;
      if (ext.listener != null && ext.textureId != null) {
        return ext.listener.huoVideoVolumePause(type);
      }
    }
  }

  static void playVolumeByType(String type) {
    HuoLog.d("video playVolumeByType：${type}");
    if (huoVideoMap.containsKey(type)) {
      HuoVideoViewExt ext = huoVideoMap[type];
      ext.openAudio = true;
      if (ext.listener != null && ext.textureId != null) {
        return ext.listener.huoVideoVolumePlay(type);
      }
    }
  }

  //设置活跃，可查询是否可以播放，也许自己是活跃的，但是上级不活跃，则不能播放
  static void setViewActive(String type) {
    if (huoVideoMap.containsKey(type)) {
      HuoVideoViewExt ext = huoVideoMap[type];
      //本来就是活跃的，不再处理：可能用用户暂停，再次设置激活，会导致又开始播放
      if (ext.active) {
        return;
      }
  //    HuoLog.d("video setViewActive:${type}");
      //活跃是抢占行的，当前页面下的所有同级的类型设置不活跃，暂停播放
      _setEqualLevelPause(type);
      ext.active = true;
      if (_isCanPlay(ext)) {
        //查找出一个可以播放的节点
        HuoVideoViewExt childExt =
            findCanPlayChildByParentType(_getParentType(type));
        //此节点必须能播放
        if (childExt != null && _isCanPlay(childExt)) {
          childExt.listener
              .huoVideoPlay(childExt.type, textureId: childExt.textureId);
        }
      }
    } else {
      add(HuoVideoViewExt(type, active: true));
      HuoLog.i("video error:${type}页面还没添加就设置活跃！！！！");
    }
    _debug();
  }

  static void _debug() {
//    huoVideoMap.forEach((key, value) {
//      HuoLog.d(value.toString());
//    });
  }

  static HuoVideoViewExt findCanPlayChildByParentType(String parentType,
      {int callCount = 0}) {
    //偶现过一次死循环，后面复现不了，先暂时加个死循环出口
    if (callCount > 50) {
      return null;
    }
    List<String> types = [];
    //从子节点中找出活跃的节点
    huoVideoMap.forEach((key, value) {
      String tmpType = _getParentType(key);
      if (tmpType == parentType) {
        HuoVideoViewExt childExt = huoVideoMap[key];
        if (childExt.active) {
          types.add(key);
        }
      }
    });
    //没有活跃的节点，直接返回
    if (types == null || types.length == 0) {
      return null;
    }
    //有活跃的节点，判断是否是视频，是则返回，不是继续往下层找
    for (var value in types) {
      HuoVideoViewExt childExt = huoVideoMap[value];
      if (childExt.listener != null && childExt.textureId != null) {
        return childExt;
      } else {
        return findCanPlayChildByParentType(value, callCount: callCount + 1);
      }
    }
  }

  //设置同级的页面不活跃，并且暂停底下的视频
  static void _setEqualLevelPause(String type) {
    String parentType = _getParentType(type);
    huoVideoMap.forEach((otherType, value) {
      if (otherType != type && _getParentType(otherType) == parentType) {
        setViewPause(otherType);
      }
    });
  }

  static bool isActive(String type) {
    if (huoVideoMap.containsKey(type)) {
      return huoVideoMap[type].active;
    } else {
      return false;
    }
  }

  static HuoVideoViewExt getHuoVideoViewExt(String type) {
    return huoVideoMap[type];
  }

  //设置不活跃,暂停自己及自己下级的视频
  static void setViewPause(String type) {
 //   HuoLog.d("video setViewPause：${type}");
    if (huoVideoMap.containsKey(type)) {
      HuoVideoViewExt ext = huoVideoMap[type];
      ext.active = false;
   //   HuoLog.d("设置不活跃了：${ext.type}");

      if (ext.listener != null && ext.textureId != null) {
        ext.listener.huoVideoPause(ext.type, textureId: ext.textureId);
      }
      String preType = type + "#";
      //需要把当前页面下视频暂停
      huoVideoMap.forEach((otherType, value) {
        if (otherType.startsWith(preType)) {
          if (value.listener != null && value.textureId != null) {
            value.listener
                .huoVideoPause(value.type, textureId: value.textureId);
          }
        }
      });
    } else {
      HuoLog.i("video error:${type}页面还没添加就设置不活跃！！！！");
    }
  }

  //是否可以播放
  //条件是自己当前是可见活跃的，并且自己所在的上层都是活跃可见的
  static bool _isCanPlay(HuoVideoViewExt ext) {
    //自己不活跃，不能播放
    if (ext.active == false) {
      return false;
    }
    //自己所在的上层不活跃，不可播放
    String parentType = ext.type;
    while ((parentType = _getParentType(parentType)) != null) {
      if (huoVideoMap.containsKey(parentType)) {
        if (huoVideoMap[parentType].active == false) {
          return false;
        }
        parentType = huoVideoMap[parentType].type;
      } else {
        return false;
      }
    }
    return true;
  }

  //获取在当前页面中的下标
  static int getIndex(String type) {
    if (type.contains("#")) {
      String index = type.substring(type.lastIndexOf("#") + 1);
      return int.parse(index);
    } else {
      return int.parse(type);
    }
  }

  //获取此类型的等级
  static int _getLevel(String type) {
    return type.split("#").length;
  }

  //获取父节点type
  static String _getParentType(String type) {
    int index = getIndex(type);

    int level = _getLevel(type);
    //1级没有父节点了
    if (level == 1) {
      return null;
    }
    return type.substring(0, type.lastIndexOf("#"));
  }

  static String getVideoFirstFrame(String videoUrl) {
    return videoUrl + "?x-oss-process=video/snapshot,t_10000,m_fast";
  }
}
