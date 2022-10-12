import '../base_model.dart';
import 'deal_goods.dart';

class DealDetailsData extends BaseModel<DealGoods> {
  DealDetailsData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = DealGoods.fromJson(jsonRes);
  }
}
