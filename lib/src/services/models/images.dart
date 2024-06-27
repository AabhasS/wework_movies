import 'package:json_annotation/json_annotation.dart';

part 'images.g.dart';

@JsonSerializable()
class Images {
  @JsonKey(name: 'base_url')
  final String baseUrl;

  @JsonKey(name: 'secure_base_url')
  final String secureBaseUrl;

  @JsonKey(name: 'backdrop_sizes')
  final List<String> backdropSizes;

  @JsonKey(name: 'logo_sizes')
  final List<String> logoSizes;

  @JsonKey(name: 'poster_sizes')
  final List<String> posterSizes;

  @JsonKey(name: 'profile_sizes')
  final List<String> profileSizes;

  @JsonKey(name: 'still_sizes')
  final List<String> stillSizes;

  Images({
    required this.baseUrl,
    required this.secureBaseUrl,
    required this.backdropSizes,
    required this.logoSizes,
    required this.posterSizes,
    required this.profileSizes,
    required this.stillSizes,
  });

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
