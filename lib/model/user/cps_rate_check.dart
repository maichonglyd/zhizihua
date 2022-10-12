import '../base_model.dart';

class CpsRateCheck extends BaseModel<Data> {
  CpsRateCheck.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  num rate;

  Data.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
  }
}

