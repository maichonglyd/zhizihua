import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_reward_list.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

class LotteryMachineView extends StatefulWidget {
  List<LotteryRewardBean> list;
  num chance;
  LotteryMachineController controller;
  Function() clickStart;
  Function() finishCallback;

  LotteryMachineView({
    Key key,
    @required this.list,
    @required this.controller,
    this.chance = 0,
    this.clickStart,
    this.finishCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LotteryMachineState();
  }
}

class LotteryMachineState extends State<LotteryMachineView> {
  bool startLottery = false;
  int selectIndex = 0;

  LotteryMachineState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (null != widget) {
      if (null != widget.controller) {
        if (null != widget.controller) {
          widget.controller.count = widget.list.length;
          widget.controller.addStartCallback(() {
            updateStartLottery(true);
          });
          widget.controller.addIntervalCallback((index) {
            updateSelectView(index);
          });
          widget.controller.addFinishCallback(() {
            if (null != widget.finishCallback()) widget.finishCallback();
            updateStartLottery(false);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 500,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/pic_lottery_machine_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 255,
            height: 240,
            margin: EdgeInsets.only(top: 79, bottom: 38),
            child: _buildWrapView(),
          ),
          GestureDetector(
            onTap: () {
              if (null != widget.clickStart) {
                widget.clickStart();
              }
            },
            child: Container(
              child: Image.asset(
                'images/pic_start_lottery.png',
                width: 206,
                height: 59,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 26),
            child: Text(
              '当前抽奖机会：${widget.chance}次',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (null != widget.controller) {
      widget.controller.cancel();
    }
    super.dispose();
  }

  Widget _buildWrapView() {
    return Wrap(
      spacing: 0,
      runSpacing: 0,
      children: widget.list.asMap().keys.map((index) => _buildItemView(widget.list[index], index == selectIndex)).toList(),
    );
  }

  Widget _buildItemView(LotteryRewardBean bean, bool isSelect) {
    double width = 85;
    double height = 80;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 49,
                  height: 49,
                  child: HuoNetImage(
                    imageUrl: bean.icon ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  bean.name ?? '',
                  maxLines: 1,
                  style: TextStyle(
                      color: AppTheme.colors.textSubColor, fontSize: 10),
                ),
              ],
            ),
          ),
          _buildSelectView(width, height, isSelect),
        ],
      ),
    );
  }

  Widget _buildSelectView(double width, double height, bool isSelect) {
    if (startLottery && isSelect) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Color(0x3FFFFFFF), borderRadius: BorderRadius.circular(10)),
      );
    } else if (startLottery && !isSelect) {
      return Container(
        width: width,
        height: height,
        color: Color(0x2F000000),
      );
    } else {
      return SizedBox();
    }
  }

  void updateSelectView(int index) {
    this.selectIndex = index;
    setState(() {});
  }

  void updateStartLottery(bool result) {
    startLottery = result;
    if (result) {
      widget.chance -= 1;
    }
    setState(() {});
  }
}

class LotteryMachineController {
  int count;
  int selectIndex;
  Timer timer;
  int interval;
  int timeCount = 0;
  Function() startCallback;
  Function(int index) intervalCallback;
  Function() finishCallback;

  LotteryMachineController({this.selectIndex = 0, this.interval = 200});

  void start() {
    timeCount = 0;
    if (null != startCallback) {
      startCallback();
    }
    timer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      timeCount += 1;
      if (null != intervalCallback) {
        intervalCallback(timeCount % count);
      }
      if (timeCount >= (count * 3 + selectIndex)) {
        if (null != finishCallback) {
          finishCallback();
          cancel();
        }
      }
    });
  }

  void cancel() {
    timer?.cancel();
  }

  void setSelectIndex(int index) {
    selectIndex = index;
  }

  void addStartCallback(Function() func) {
    startCallback = func;
  }

  void addIntervalCallback(Function(int index) func) {
    intervalCallback = func;
  }

  void addFinishCallback(Function() func) {
    finishCallback = func;
  }
}
