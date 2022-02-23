import 'dart:convert';


import 'ArtObjectDetailDto.dart';

ArtObjectDetailResultDto artObjectDetailResultDtoFromJson(String str) => ArtObjectDetailResultDto.fromJson(json.decode(str));

String artObjectDetailResultDtoToJson(ArtObjectDetailResultDto data) => json.encode(data.toJson());

class ArtObjectDetailResultDto {
  ArtObjectDetailResultDto({
    this.elapsedMilliseconds,
    this.artObject,
    this.artObjectPage,
  });

  int? elapsedMilliseconds;
  ArtObjectDetailDto? artObject;
  dynamic artObjectPage;

  factory ArtObjectDetailResultDto.fromJson(Map<String, dynamic> json) => ArtObjectDetailResultDto(
    elapsedMilliseconds: json["elapsedMilliseconds"],
    artObject: ArtObjectDetailDto.fromJson(json["artObject"]),
    artObjectPage: json["artObjectPage"],
  );

  Map<String, dynamic> toJson() => {
    "elapsedMilliseconds": elapsedMilliseconds,
    "artObject": artObject?.toJson(),
    "artObjectPage": artObjectPage?.toJson(),
  };
}



