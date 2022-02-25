class WebImageDto {
  WebImageDto({
    required this.guid,
    this.offsetPercentageX,
    this.offsetPercentageY,
    this.width,
    this.height,
    this.url,
  });

  String guid;
  int? offsetPercentageX;
  int? offsetPercentageY;
  int? width;
  int? height;
  String? url;

  factory WebImageDto.fromJson(Map<String, dynamic> json) => WebImageDto(
    guid: json["guid"] ?? "",
    offsetPercentageX: json["offsetPercentageX"] ?? 0,
    offsetPercentageY: json["offsetPercentageY"] ?? 0,
    width: json["width"] ?? 0,
    height: json["height"] ?? 0,
    url: json["url"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "guid": guid,
    "offsetPercentageX": offsetPercentageX,
    "offsetPercentageY": offsetPercentageY,
    "width": width,
    "height": height,
    "url": url,
  };
}