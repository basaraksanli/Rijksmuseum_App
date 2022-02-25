import 'dart:convert';


import 'art_object_detail_dto.dart';

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
    artObject: json["artObject"] != null ?ArtObjectDetailDto.fromJson(json["artObject"]): null,
    artObjectPage: json["artObjectPage"],
  );

  Map<String, dynamic> toJson() => {
    "elapsedMilliseconds": elapsedMilliseconds,
    "artObject": artObject?.toJson(),
    "artObjectPage": artObjectPage?.toJson(),
  };
}



