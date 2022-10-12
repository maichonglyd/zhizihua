// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameDTO _$GameDTOFromJson(Map<String, dynamic> json) {
  return GameDTO()
    ..game_name = json['game_name'] as String
    ..game_icon = json['game_icon'] as String;
}

Map<String, dynamic> _$GameDTOToJson(GameDTO instance) => <String, dynamic>{
      'game_name': instance.game_name,
      'game_icon': instance.game_icon
    };
