import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

class LotteryBuyChanceDialog extends StatefulWidget {
  int num;
  String text;
  Function(int num) submitCallback;

  LotteryBuyChanceDialog({Key key, this.num = 0, this.text = '', this.submitCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LotteryBuyChanceState();
  }
}

class LotteryBuyChanceState extends State<LotteryBuyChanceDialog> {
  LotteryBuyChanceState();

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        child: Container(
          width: 290,
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 25, bottom: 25),
                alignment: Alignment.center,
                child: Text(
                  getText(name: 'textTip'),
                  style: TextStyle(
                      color: AppTheme.colors.textSubColor, fontSize: 15),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  widget.text ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.colors.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 120,
                      height: 44,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 23, bottom: 22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                            color: AppTheme.colors.lineColor, width: 1),
                      ),
                      child: Text(
                        getText(name: 'textCancel'),
                        style: TextStyle(
                            color: AppTheme.colors.textSubColor,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      if (null != widget.submitCallback) {
                        widget.submitCallback(widget.num);
                      }
                    },
                    child: Container(
                      width: 120,
                      height: 44,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 23, bottom: 22),
                      decoration: BoxDecoration(
                        color: AppTheme.colors.themeColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text(
                        widget.num > 0 ? getText(name: 'textBuy') : getText(name: 'textGotoRecharge'),
                        style: TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
