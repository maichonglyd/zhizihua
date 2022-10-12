import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:oktoast/oktoast.dart';

class LotteryAddressDialog extends StatefulWidget {
  Function(String name, String address, String mobile) submitCallback;

  LotteryAddressDialog({this.submitCallback});

  @override
  State<StatefulWidget> createState() {
    return LotteryAddressState();
  }
}

class LotteryAddressState extends State<LotteryAddressDialog> {
  var nameController = new TextEditingController();
  var phoneController = new TextEditingController();
  var addressController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: Container(
          width: 300,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 11, bottom: 20),
                child: Text(
                  getText(name: 'textFillInTheReceivingAddress'),
                  style:
                  TextStyle(color: AppTheme.colors.textColor, fontSize: 15),
                ),
              ),
              _buildItem(getText(name: 'textInputBuyerName'), nameController),
              _buildItem(getText(name: 'textInputPhoneNumber'), phoneController),
              _buildItem(getText(name: 'textInputMailAddress'), addressController),
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
      String hintString, TextEditingController textEditingController) {
    return Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppTheme.colors.bgColor,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        margin: EdgeInsets.only(bottom: 10),
        child: TextField(
          obscureText: false,
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintString,
            hintStyle: TextStyle(
              color: AppTheme.colors.hintTextColor,
            ),
            contentPadding: EdgeInsets.only(left: 15, right: 10),
            counterText: "",
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
          ),
          style: TextStyle(
            color: AppTheme.colors.textColor,
            fontSize: 15,
          ),
        ));
  }

  Widget _buildBottomButton() {
    return Row(
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
            margin: EdgeInsets.only(top: 13, bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppTheme.colors.bgColor, width: 1),
            ),
            child: Text(
              getText(name: 'textCancel'),
              style:
                  TextStyle(color: AppTheme.colors.textSubColor, fontSize: 16),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            String name = nameController.text;
            String phone = phoneController.text;
            String address = addressController.text;
            if (name.isEmpty || phone.isEmpty || address.isEmpty) {
              showToast(getText(name: 'textPleaseInputCompleteInfo'));
              return;
            }

            Navigator.pop(context);
            if (null != widget.submitCallback) {
              widget.submitCallback(name, address, phone);
            }
          },
          child: Container(
            width: 120,
            height: 44,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 13, bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: AppTheme.colors.themeColor,
            ),
            child: Text(
              getText(name: 'textConfirm'),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
