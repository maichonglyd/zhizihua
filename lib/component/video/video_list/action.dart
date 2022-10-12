import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';

//TODO replace with your own action
enum VideoAction {
  action,
  getData,
  updateData,
  getComment,
  commentsLike,
  addComment,
  videoLike,
  showShare,
  shareNotify,
  updateVolume,
  switchVolume,
  changeSliding,
  sliderVal,
  onIndexChange,
  updateVideoVolume,
}

class VideoActionCreator {
  static Action onAction() {
    return const Action(VideoAction.action);
  }

  static Action getData() {
    return Action(VideoAction.getData);
  }

  static Action updateData(List<New> news) {
    return Action(VideoAction.updateData, payload: news);
  }

  static Action getComment(int commentId) {
    return Action(VideoAction.getComment, payload: commentId);
  }

  static Action commentsLike(int commentId, int type) {
    return Action(VideoAction.commentsLike,
        payload: {"commentId": commentId, "type": type});
  }

  static Action addComment(int id, String content) {
    return Action(VideoAction.addComment,
        payload: {"objectId": id, "content": content});
  }

  static Action videoLike(int newsId) {
    return Action(VideoAction.videoLike, payload: {"news_id": newsId});
  }

  static Action showShare(New news) {
    return Action(VideoAction.showShare, payload: news);
  }

  static Action shareNotify(int newId) {
    return Action(VideoAction.shareNotify, payload: newId);
  }

  static Action updateVolume(double volume) {
    return Action(VideoAction.updateVolume, payload: {"volume": volume});
  }

  static Action switchVolume() {
    return Action(VideoAction.switchVolume);
  }

  static Action changeSliding(bool isSliding) {
    return Action(VideoAction.changeSliding, payload: {"isSliding": isSliding});
  }

  static Action sliderVal(double sliderVal) {
    return Action(VideoAction.sliderVal, payload: {"sliderVal": sliderVal});
  }

  static Action onIndexChange(int index) {
    return Action(VideoAction.onIndexChange, payload: index);
  }

  static Action updateVideoVolume(bool open) {
    return Action(VideoAction.updateVideoVolume, payload: open);
  }
}
