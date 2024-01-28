import 'dart:convert';

List<ImageResponse> imageResponseFromJson(String str) => List<ImageResponse>.from(json.decode(str).map((x) => ImageResponse.fromJson(x)));

String imageResponseToJson(List<ImageResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageResponse {
  int? id;
  String? name;
  double? size;
  String? url;

  ImageResponse({
    this.id,
    this.name,
    this.size,
    this.url,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
    id: json["id"],
    name: json["name"],
    size: json["size"]?.toDouble(),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "size": size,
    "url": url,
  };
}
