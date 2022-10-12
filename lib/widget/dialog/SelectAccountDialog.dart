import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_account_list_data.dart';

class SelectAccountDialog extends StatefulWidget {
  List<Account> accounts;

  Function(Account account) select;

  SelectAccountDialog(this.accounts, this.select);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SelectAccountState(accounts, select);
  }
}

class SelectAccountState extends State<SelectAccountDialog> {
  List<Account> accounts;

  Function(Account account) select;

  int index = -1;

  SelectAccountState(this.accounts, this.select);

  @override
  Widget build(BuildContext context) {
    List<Widget> views = List();
    views.add(Text(
      getText(name: 'textSelectYourAccount'),
      style: TextStyle(
          fontSize: 15,
          color: AppTheme.colors.textColor,
          fontWeight: FontWeight.bold),
    ));

    for (int i = 0; i < accounts.length; i++) {
      views.add(Container(
          height: 48,
          child: GestureDetector(
            onTap: () {
              setState(() {
                index = i;
              });
              select(accounts[i]);
            },
            child: Row(
              children: <Widget>[
                Text(getText(name: 'textLitterAccount') + (i + 1).toString() + "："),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Text(accounts[i].nickname),
                )),
                //正常状态下的小号才给点击
                accounts[i].status == 2
                    ? Checkbox(
                        value: index == i,
                        activeColor: AppTheme.colors.themeColor,
                        onChanged: (value) {
                          setState(() {
                            index = i;
                          });
                          select(accounts[i]);
                        })
                    : Container()
              ],
            ),
          )));
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: RefreshHelper().getEasyRefresh(
          ListView(
            children: views,
          ),
          controller: RefreshHelperController()),
    );
  }
}
