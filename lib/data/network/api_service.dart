import 'dart:convert';
import 'dart:io';

import 'package:food_panda6/data/app_exception.dart';
import 'package:http/http.dart' as http;
class ApiService {

  Future<dynamic> deleteRestaurant(url) async {
    var request = http.Request('DELETE', Uri.parse(url));

    var response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future<dynamic> postRestaurant(url, data, bool isUpdate) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request(isUpdate ? 'PUT' : 'POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
      print(await response.stream.bytesToString());
    }
    else {
      return false;
    }
  }

  Future<dynamic> uploadImage(image, url) async {
    http.StreamedResponse? response;
    try{
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('files', image));
      response = await request.send();
      return returnResponse(response);
    }on Exception{
      throw FetchDataException(response!.reasonPhrase);
    }
  }

  Future<dynamic> getApi(url) async {
    http.StreamedResponse? response;
    try{
      var request = http.Request('GET', Uri.parse(url));
      response = await request.send();
      return returnResponse(response);
    }on SocketException{
      throw FetchDataException(response!.reasonPhrase.toString());
    }
  }

  returnResponse(http.StreamedResponse response) async {
    // print('response ${response.reasonPhrase}');
    // print('response ${response.stream.bytesToString()}');
     switch(response.statusCode){
       case 200:
         return await response.stream.bytesToString();
       case 500:
       case 404:
     }
  }
}