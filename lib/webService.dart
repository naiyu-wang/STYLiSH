import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:stylish/productInfo.dart';
import 'package:stylish/staticResource.dart';

class WebService {
  final dio = Dio();

  Future<List<ProductInfo>> requestProductList(ProductType type) async {
    Response response;
    response = await dio.get(type.getAPIValue());
    List<ProductInfo> list = ProductListResponse.fromJson(response.data).list;
    return Future.value(list);
  }
}
