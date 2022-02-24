import 'package:rijksmuseum_app/feature_art_list/domain/model/ArtObject.dart';

import 'WebImageDto.dart';

class ArtObjectDetailDto {
  ArtObjectDetailDto({
    this.id,
    this.objectNumber,
    this.language,
    this.title,
    this.webImage,
    this.titles,
    this.description,
    this.plaqueDescriptionDutch,
    this.plaqueDescriptionEnglish,
    this.principalMaker,
    this.materials,
    this.techniques,
    this.productionPlaces,
    this.hasImage,
    this.principalOrFirstMaker,
    this.longTitle,
    this.subTitle,
    this.scLabelLine,
    this.location,
    this.label,
  });

  String? id;
  String? objectNumber;
  String? language;
  String? title;
  WebImageDto? webImage;
  List<String>? titles;
  String? description;
  String? plaqueDescriptionDutch;
  String? plaqueDescriptionEnglish;
  String? principalMaker;
  List<String>? materials;
  List<String>? techniques;
  List<String>? productionPlaces;
  bool? hasImage;
  String? principalOrFirstMaker;
  String? longTitle;
  String? subTitle;
  String? scLabelLine;
  String? location;
  LabelDto? label;

  factory ArtObjectDetailDto.fromJson(Map<String, dynamic> json) =>
      ArtObjectDetailDto(
        id: json["id"],
        objectNumber: json["objectNumber"],
        language: json["language"],
        title: json["title"],
        webImage: json["webImage"] != null ? WebImageDto.fromJson(json["webImage"]): null,
        titles: json["titles"] != null
            ? List<String>.from(json["titles"].map((x) => x))
            : [],
        description: json["description"],
        plaqueDescriptionDutch: json["plaqueDescriptionDutch"],
        plaqueDescriptionEnglish: json["plaqueDescriptionEnglish"],
        principalMaker: json["principalMaker"],
        materials: json["materials"] != null
            ? List<String>.from(json["materials"].map((x) => x))
            : [],
        techniques: json["techniques"] != null
            ? List<String>.from(json["techniques"].map((x) => x))
            : [],
        productionPlaces: json["productionPlaces"] != null
            ? List<String>.from(json["productionPlaces"].map((x) => x))
            : [],
        hasImage: json["hasImage"],
        principalOrFirstMaker: json["principalOrFirstMaker"],
        longTitle: json["longTitle"],
        subTitle: json["subTitle"],
        scLabelLine: json["scLabelLine"],
        location: json["location"],
        label: json["label"] != null ? LabelDto.fromJson(json["label"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "objectNumber": objectNumber,
        "language": language,
        "title": title,
        "webImage": webImage?.toJson(),
        "titles":
            titles != null ? List<dynamic>.from(titles!.map((x) => x)) : [],
        "description": description,
        "plaqueDescriptionDutch": plaqueDescriptionDutch,
        "plaqueDescriptionEnglish": plaqueDescriptionEnglish,
        "principalMaker": principalMaker,
        "materials": materials != null
            ? List<dynamic>.from(materials!.map((x) => x))
            : [],
        "techniques": techniques != null
            ? List<dynamic>.from(techniques!.map((x) => x))
            : [],
        "productionPlaces": productionPlaces != null
            ? List<dynamic>.from(productionPlaces!.map((x) => x))
            : [],
        "hasImage": hasImage,
        "principalOrFirstMaker": principalOrFirstMaker,
        "longTitle": longTitle,
        "subTitle": subTitle,
        "scLabelLine": scLabelLine,
        "location": location,
        "label": label?.toJson(),
      };

  ArtObject toArtObject() => ArtObject(
        objectNumber!,
        title ?? "",
        label?.description ?? "",
        principalOrFirstMaker ?? "",
        productionPlaces ?? [],
        largeImage: webImage?.url ?? "",
      );
}
class LabelDto {
  LabelDto({
    this.title,
    this.makerLine,
    this.description,
    this.notes,
    this.date,
  });

  String? title;
  String? makerLine;
  String? description;
  String? notes;
  DateTime? date;

  factory LabelDto.fromJson(Map<String, dynamic> json) => LabelDto(
    title: json["title"],
    makerLine: json["makerLine"],
    description: json["description"],
    notes: json["notes"],
    date: json["date"] != null ? DateTime.parse(json["date"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "makerLine": makerLine,
    "description": description,
    "notes": notes,
    "date": "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
  };
}
