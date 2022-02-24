import '../../../domain/model/ArtObject.dart';
import 'WebImageDto.dart';

class ArtObjectDto {
  ArtObjectDto({
    this.id,
    this.objectNumber,
    this.title,
    this.hasImage,
    this.principalOrFirstMaker,
    this.showImage,
    this.permitDownload,
    this.webImage,
    this.headerImage,
    this.productionPlaces,
  });

  String? id;
  String? objectNumber;
  String? title;
  bool? hasImage;
  String? principalOrFirstMaker;
  String? longTitle;
  bool? showImage;
  bool? permitDownload;
  WebImageDto? webImage;
  WebImageDto? headerImage;
  List<String>? productionPlaces;

  factory ArtObjectDto.fromJson(Map<String, dynamic> json) => ArtObjectDto(
    id: json["id"] ?? "",
    objectNumber: json["objectNumber"] ?? "",
    title: json["title"] ?? "",
    hasImage: json["hasImage"] ?? false,
    principalOrFirstMaker: json["principalOrFirstMaker"] ?? "",
    showImage: json["showImage"] ?? false,
    permitDownload: json["permitDownload"] ?? false,
    webImage:json["webImage"] != null ? WebImageDto.fromJson(json["webImage"] ?? {}) : null,
    headerImage: json["headerImage"] != null ? WebImageDto.fromJson(json["headerImage"] ?? "") : null,
    productionPlaces: json["productionPlaces"] != null ? List<String>.from(json["productionPlaces"].map((x) => x) ?? []) : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "objectNumber": objectNumber,
    "title": title,
    "hasImage": hasImage,
    "principalOrFirstMaker": principalOrFirstMaker,
    "showImage": showImage,
    "permitDownload": permitDownload,
    "webImage": webImage?.toJson(),
    "headerImage": headerImage?.toJson(),
    "productionPlaces": productionPlaces != null ? List<dynamic>.from(productionPlaces!.map((x) => x)) : [],
  };

  ArtObject toArtObject() => ArtObject(objectNumber!, title ?? "", longTitle ?? "", principalOrFirstMaker ?? "" , productionPlaces ?? []);
}