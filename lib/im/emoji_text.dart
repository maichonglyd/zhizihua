import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';

///emoji/image text
class EmojiText extends SpecialText {
  static const String flag = "[";
  final int start;
  double emojiSize = 0;

  EmojiText(TextStyle textStyle, {this.start, this.emojiSize = 0})
      : super(EmojiText.flag, "]", textStyle);

  @override
  InlineSpan finishText() {
    var key = toString();
    if (EmojiUitl.instance.emojiMap.containsKey(key)) {
      //fontsize id define image height
      //size = 30.0/26.0 * fontSize
      double size = 20.0;
      if (emojiSize > 0) {
        size = emojiSize;
      }

      ///fontSize 26 and text height =30.0
      //final double fontSize = 26.0;
      return ImageSpan(AssetImage(EmojiUitl.instance.emojiMap[key]),
          actualText: key,
          imageWidth: size,
          imageHeight: size,
          start: start,
          fit: BoxFit.fill,
          margin: EdgeInsets.only(left: 2.0, right: 2.0));
    }

    return TextSpan(text: toString(), style: textStyle);
  }
}

class EmojiUitl {
  final Map<String, String> _emojiMap = new Map<String, String>();

  Map<String, String> get emojiMap => _emojiMap;

  final String _emojiFilePath = "images/emoji";

  static EmojiUitl _instance;

  static EmojiUitl get instance {
    if (_instance == null) _instance = new EmojiUitl._();
    return _instance;
  }

  EmojiUitl._() {
    for (int i = 1; i < 100; i++) {
      _emojiMap["[$i]"] = "$_emojiFilePath/sg$i.png";
    }
  }
  ///修正用户移动鼠标时，光标移动到表情占位符内部的问题，返回最后停留光标的结束位置
  int fixEmojiCursor(String text, int beforeCursor, int currentCurosr) {
    if (beforeCursor>= currentCurosr) {
      var endEmojiFlag = text
          .substring(currentCurosr, beforeCursor);
      //表情标记点，需要往前查找结束位置
      if (endEmojiFlag == "]") {
        var startEmojiFlag = text
            .lastIndexOf("[", currentCurosr);
        if (startEmojiFlag >= 0) {
          var emojiNum = text.substring(startEmojiFlag + 1, beforeCursor - 1);
          if (RegExp(r"^[0-9]+$").firstMatch(emojiNum) != null) {
            return startEmojiFlag;
          }
        }
      }
    } else {
      var startEmojiFlag = text
          .substring(beforeCursor, currentCurosr);
      //表情标记点，需要往前查找结束位置
      if (startEmojiFlag == "[") {
        var endEmojiIndex = text
            .indexOf("]", currentCurosr);
        if (endEmojiIndex >= 0) {
          var emojiNum = text.substring(beforeCursor + 1, endEmojiIndex);
          if (RegExp(r"^[0-9]+$").firstMatch(emojiNum) != null) {
            return endEmojiIndex+1;
          }
        }
      }
    }
    return null;
  }
}
