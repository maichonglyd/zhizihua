import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/component/deal/account_deal/index_deal_fragment/component.dart';
import 'package:flutter_huoshu_app/component/deal/deal_fragment/component.dart';
import 'package:flutter_huoshu_app/component/deal/prop_deal/prop_deal_fragment/component.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(DealState state, Dispatch dispatch, ViewService viewService) {
  return Container(
   child: viewService.buildComponent(DealFragment.componentName),
  );
}
