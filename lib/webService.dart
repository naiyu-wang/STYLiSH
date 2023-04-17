import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:stylish/productInfo.dart';
import 'package:stylish/staticResource.dart';

class WebService {
  final dio = Dio();

  void request(String api, Function(Response) callback) async {
    Response response;
    response = await dio.get(api);
    print(response.data.toString());
    callback(response);
  }

  void getProductList(
      ProductType type, Function(List<ProductInfo>) callback) async {
    request(type.getAPIValue(), (response) {
      List<ProductInfo> list = ProductListResponse.fromJson(response.data).list;
      return list;
    });
  }
}
