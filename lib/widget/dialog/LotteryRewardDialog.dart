import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

class LotteryRewardDialog extends StatefulWidget {
  LotteryMyRewardBean reward;
  Function(LotteryMyRewardBean reward) submitCallback;

  LotteryRewardDialog({Key key, this.reward, this.submitCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LotteryRewardState();
  }
}

class LotteryRewardState extends State<LotteryRewardDialog> {
  LotteryRewardState();

  @override
  Widget build(BuildContext context) {
    int type = getLotteryRewardType(widget.reward);
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 360,
            height: 405,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/pic_lottery_obtain_reward.png'),
              fit: BoxFit.fill,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 67,
                  height: 67,
                  child: HuoNetImage(
                    imageUrl: widget.reward.rewardIcon ?? '',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24, bottom: 17),
                  child: Text(
                    '获得${widget.reward.rewardName ?? ''}',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              if (null != widget.submitCallback) {
                widget.submitCallback(widget.reward);
              }
            },
            child: Container(
              width: 157,
              height: 44,
              margin: EdgeInsets.only(top: 15),
              child: Image.asset(
                type == LotteryMyRewardType.kind ? 'images/pic_obtain_now.png' : 'images/pic_check_now.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 27,
              height: 27,
              margin: EdgeInsets.only(top: 17),
              child: Image.asset(
                'images/ic_off.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
