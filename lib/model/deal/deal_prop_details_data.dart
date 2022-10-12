import '../base_model.dart';
import 'deal_prop_goods_list.dart';

class DealPropDetailsData extends BaseModel<Goods> {
  DealPropDetailsData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Goods.fromJson(jsonRes);
  }
}
