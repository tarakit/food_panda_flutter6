import 'dart:convert';

RestaurantRequest restaurantRequestFromJson(String str) => RestaurantRequest.fromJson(json.decode(str));

String restaurantRequestToJson(RestaurantRequest data) => json.encode(data.toJson());

class RestaurantRequest {
  DataRequest? data;

  RestaurantRequest({
    this.data,
  });

  factory RestaurantRequest.fromJson(Map<String, dynamic> json) => RestaurantRequest(
    data: json["data"] == null ? null : DataRequest.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class DataRequest {
  String? name;
  String? category;
  int? discount;
  double? deliveryFee;
  int? deliveryTime;
  String? picture;

  DataRequest({
    this.name,
    this.category,
    this.discount,
    this.deliveryFee,
    this.deliveryTime,
    this.picture,
  });

  factory DataRequest.fromJson(Map<String, dynamic> json) => DataRequest(
    name: json["name"],
    category: json["category"],
    discount: json["discount"],
    deliveryFee: json["deliveryFee"]?.toDouble(),
    deliveryTime: json["deliveryTime"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "category": category,
    "discount": discount,
    "deliveryFee": deliveryFee,
    "deliveryTime": deliveryTime,
    "picture": picture,
  };
}
