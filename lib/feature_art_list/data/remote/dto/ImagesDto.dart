// To parse this JSON data, do
//
//     final imageDto = imageDtoFromJson(jsonString);

import 'dart:convert';

ImagesDto imageDtoFromJson(String str) => ImagesDto.fromJson(json.decode(str));

String imageDtoToJson(ImagesDto data) => json.encode(data.toJson());

class ImagesDto {
  ImagesDto({
    required this.levels,
  });

  List<LevelDto> levels;

  factory ImagesDto.fromJson(Map<String, dynamic> json) => ImagesDto(
    levels: List<LevelDto>.from(json["levels"].map((x) => LevelDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "levels": List<dynamic>.from(levels.map((x) => x.toJson())),
  };
}

class LevelDto {
  LevelDto({
    required this.name,
    required this.width,
    required this.height,
    required this.tiles,
  });

  String name;
  int width;
  int height;
  List<TileDto> tiles;

  factory LevelDto.fromJson(Map<String, dynamic> json) => LevelDto(
    name: json["name"],
    width: json["width"],
    height: json["height"],
    tiles: List<TileDto>.from(json["tiles"].map((x) => TileDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "width": width,
    "height": height,
    "tiles": List<dynamic>.from(tiles.map((x) => x.toJson())),
  };
}

class TileDto {
  TileDto({
    required this.x,
    required this.y,
    required this.url,
  });

  int x;
  int y;
  String url;

  factory TileDto.fromJson(Map<String, dynamic> json) => TileDto(
    x: json["x"],
    y: json["y"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "x": x,
    "y": y,
    "url": url,
  };
}
