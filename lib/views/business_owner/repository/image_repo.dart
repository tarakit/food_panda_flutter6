
import 'package:food_panda6/data/network/api_service.dart';
import 'package:food_panda6/res/app_url.dart';
import 'package:food_panda6/views/business_owner/models/response/image_response.dart';

class ImageRepository {
  final _apiService = ApiService();

  Future<List<ImageResponse>> uploadImage(image) async{
    var response = await _apiService.uploadImage(image, AppUrl.uploadImage);
    return imageResponseFromJson(response);
  }

}