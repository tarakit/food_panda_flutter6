
import 'package:flutter/material.dart';
import 'package:food_panda6/data/response/api_response.dart';
import 'package:food_panda6/views/home/repository/restaurant_repo.dart';

class RestaurantViewmodel extends ChangeNotifier{
  final _restaurantRepo = RestaurantRepository();
  var response = ApiResponse();

  setRestaurantData(response){
    this.response = response;
    notifyListeners();
  }

  Future<dynamic> postRestaurant(data, {isUpdate, id}) async{
    setRestaurantData(ApiResponse.loading());
    await _restaurantRepo.postRestaurant(data, isUpdate: isUpdate, id: id)
        .then((isPosted) => setRestaurantData(ApiResponse.completed(isPosted)))
        .onError((error, stackTrace) => setRestaurantData(ApiResponse.error(stackTrace.toString())));
  }
}
