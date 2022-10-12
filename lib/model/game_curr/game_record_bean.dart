//data.list.order_id	STRING	订单id	fdasfdasfd
//data.list.real_amount	Number	实际支付金额	1
//data.list.order_amount	Number	订单金额	1
//data.list.gm_cnt	Number	游戏币数量	1
//data.list.type	Number	1 消费	1
//data.list.status	Number	支付状态，2为成功，1为待支付，3失败	2
//data.list.payway	STRING	支付方式名称	微信
//data.list.gamename	STRING	消费的游戏名	苍穹变
//data.list.create_time	Number	创建时间	2
class GameRechargeBean {
  String orderId;
  num realAmount;
  num orderAmount;
  num gmCnt;
  int type;
  int status;
  String payWay;
  String gameName;
  int createTime;

  GameRechargeBean(
      {this.orderId,
      this.realAmount,
      this.orderAmount,
      this.gameName,
      this.gmCnt,
      this.status,
      this.payWay,
      this.type,
      this.createTime});

  GameRechargeBean.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    realAmount = json['real_amount'];
    orderAmount = json['order_amount'];
    gmCnt = json['gm_cnt'];
    type = json['type'];
    status = json['status'];
    payWay = json['payway'];
    gameName = json['gamename'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_id'] = this.orderId;
    data['real_amount'] = this.realAmount;
    data['order_amount'] = this.orderAmount;
    return data;
  }
}
