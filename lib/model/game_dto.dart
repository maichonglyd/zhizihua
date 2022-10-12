import 'package:json_annotation/json_annotation.dart';

part 'game_dto.g.dart';

@JsonSerializable(nullable: false)
class GameDTO {
  String game_name;
  String game_icon;
}
