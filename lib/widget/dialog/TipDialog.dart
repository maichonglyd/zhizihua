import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

class TipDialog extends Dialog {
  String title;
  String confirm = getText(name: 'textConfirm');
  String cancel = getText(name: 'textCancel');
  String hint;
  bool hasCancel = false;
  VoidCallback cancelCallback;
  VoidCallback confirmCallback;

  // TODO(johnsonmh): Update default dialog border radius to 4.0 to match material spec.
  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)));
  static const double _defaultElevation = 24.0;

  TipDialog(this.title,
      {
        this.confirm = 'Confirm',
        this.cancel = 'Cancel',
      this.hasCancel,
      this.hint,
      this.cancelCallback,
      this.confirmCallback});

  @override
  Widget build(BuildContext context) {
    if (this.cancelCallback == null) {
      this.cancelCallback = () {
        Navigator.pop(context);
      };
    }
    if (this.confirmCallback == null) {
      this.confirmCallback = () {
        Navigator.pop(context);
      };
    }

    final DialogTheme dialogTheme = DialogTheme.of(context);
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Material(
            color: backgroundColor ??
                dialogTheme.backgroundColor ??
                Theme.of(context).dialogBackgroundColor,
            elevation: elevation ?? dialogTheme.elevation ?? _defaultElevation,
            shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
            type: MaterialType.card,
            child: new Container(
              width: 271.0,
              height: hint == null ? 160 : 183,
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: new Text(
                      title,
                      style: new TextStyle(
                          fontSize: 17,
                          color: AppTheme.colors.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (hint != null)
                    Text(
                      hint,
                      style: TextStyle(
                          fontSize: 13, color: AppTheme.colors.textSubColor),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: MaterialButton(
                          onPressed: cancelCallback,
                          child: Text(
                            getText(name: 'textCancel'),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFFD8D8D8), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(21))),
                        width: 111,
                        height: 41,
                      ),
                      Container(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                            confirmCallback();
                          },
                          child: Text(
                            getText(name: 'textConfirm'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        width: 111,
                        height: 41,
                        decoration: BoxDecoration(
                            color: AppTheme.colors.themeColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(21))),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
