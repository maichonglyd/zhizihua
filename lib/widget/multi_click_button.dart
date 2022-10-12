import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:oktoast/oktoast.dart';

///防止多次点击,多次提交接口的widget  @author ailibin
typedef ClickCallback<T> = void Function(T t);
typedef ClickCallbackNull = void Function();

class ClickButton extends StatefulWidget {
  Widget child;
  String toastMsg;
  ClickCallbackNull onClick;

  ClickButton(
      {@required this.child, @required this.onClick, Key key, this.toastMsg});

  @override
  _ClickButtonState createState() => _ClickButtonState();
}

class _ClickButtonState extends State<ClickButton> {
  DateTime lastClickTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (lastClickTime == null ||
              DateTime.now().difference(lastClickTime) > Duration(seconds: 2)) {
            lastClickTime = DateTime.now();
            //to do something
            widget.onClick();
          } else {
            lastClickTime = DateTime.now();
            showToast(widget.toastMsg ?? getText(name: 'toastClickRepeat'));
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          child: widget.child,
        ));
  }
}
