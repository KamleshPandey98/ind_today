import 'dart:convert';

List<Place> placeFromJson(data) => List<Place>.from(data.map((x) => Place.fromJson(x)));

String placeToJson(List<Place> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Place {
  Place({
    required this.placeName,
    required this.placeId,
  });

  String placeName;
  String placeId;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    placeName: json["placeName"],
    placeId: json["placeId"],
  );

  Map<String, dynamic> toJson() => {
    "placeName": placeName,
    "placeId": placeId,
  };
}
