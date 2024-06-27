import 'package:json_annotation/json_annotation.dart';

import 'images.dart';

part 'configuration.g.dart';

@JsonSerializable()
class Configuration {
  @JsonKey(name: 'images')
  final Images images;

  @JsonKey(name: 'change_keys')
  final List<String> changeKeys;

  Configuration({required this.images, required this.changeKeys});

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);
}
