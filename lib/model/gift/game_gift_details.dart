import '../base_model.dart';
import 'game_gifts_bean.dart';

class GameGiftDetails extends BaseModel<Gift> {
  GameGiftDetails.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Gift.fromJson(jsonRes);
  }
}
