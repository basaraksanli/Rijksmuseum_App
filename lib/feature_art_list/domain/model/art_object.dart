class ArtObject {
  String id;
  String title;
  String description;
  String? thumbnail;
  String? largeImage;
  String principalOrFirstMaker;
  List<String> productionPlaces;

  ArtObject(this.id, this.title, this.description, this.principalOrFirstMaker,this.productionPlaces,
  {this.thumbnail, this.largeImage});
}
