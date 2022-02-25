// To parse this JSON data, do
//
//     final collectionDto = collectionDtoFromJson(jsonString);

import 'dart:convert';

import 'art_object_dto.dart';

CollectionDto collectionDtoFromJson(String str) => CollectionDto.fromJson(json.decode(str));

String collectionDtoToJson(CollectionDto data) => json.encode(data.toJson());

class CollectionDto {
  CollectionDto({
    this.elapsedMilliseconds,
    this.count,
    this.countFacets,
    this.artObjects,
    this.facets,
  });

  int? elapsedMilliseconds;
  int? count;
  CountFacetsDto? countFacets;
  List<ArtObjectDto>? artObjects;
  List<CollectionDtoFacetDto>? facets;

  factory CollectionDto.fromJson(Map<String, dynamic> json) => CollectionDto(
    elapsedMilliseconds: json["elapsedMilliseconds"],
    count: json["count"],
    countFacets: json["countFacets"] != null ? CountFacetsDto.fromJson(json["countFacets"]) : null,
    artObjects: json["artObjects"] != null ? List<ArtObjectDto>.from(json["artObjects"].map((x) => ArtObjectDto.fromJson(x))) : [],
    facets: json["facets"] != null ? List<CollectionDtoFacetDto>.from(json["facets"].map((x) => CollectionDtoFacetDto.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "elapsedMilliseconds": elapsedMilliseconds,
    "count": count,
    "countFacets": countFacets?.toJson(),
    "artObjects": artObjects != null ? List<dynamic>.from(artObjects!.map((x) => x.toJson())) : [],
    "facets": facets != null ? List<dynamic>.from(facets!.map((x) => x.toJson())) : [],
  };
}

class CountFacetsDto {
  CountFacetsDto({
    required this.hasimage,
    required this.ondisplay,
  });

  int? hasimage;
  int? ondisplay;

  factory CountFacetsDto.fromJson(Map<String, dynamic> json) => CountFacetsDto(
    hasimage: json["hasimage"],
    ondisplay: json["ondisplay"],
  );

  Map<String, dynamic> toJson() => {
    "hasimage": hasimage,
    "ondisplay": ondisplay,
  };
}

class CollectionDtoFacetDto {
  CollectionDtoFacetDto({
    required this.facets,
    required this.name,
    required this.otherTerms,
    required this.prettyName,
  });

  List<FacetDto> facets;
  String name;
  int otherTerms;
  int prettyName;

  factory CollectionDtoFacetDto.fromJson(Map<String, dynamic> json) => CollectionDtoFacetDto(
    facets: List<FacetDto>.from(json["facets"].map((x) => FacetDto.fromJson(x))),
    name: json["name"],
    otherTerms: json["otherTerms"],
    prettyName: json["prettyName"],
  );

  Map<String, dynamic> toJson() => {
    "facets": List<dynamic>.from(facets.map((x) => x.toJson())),
    "name": name,
    "otherTerms": otherTerms,
    "prettyName": prettyName,
  };
}

class FacetDto {
  FacetDto({
    required this.key,
    required this.value,
  });

  String key;
  int value;

  factory FacetDto.fromJson(Map<String, dynamic> json) => FacetDto(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
