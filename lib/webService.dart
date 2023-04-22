import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:stylish/productDetail.dart';
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

  Future<ProductDetail> requestProductDetail(int id) async {
    Response response;
    response = await dio.get(productDetailAPI, queryParameters: {'id': id});
    Map<String, dynamic> data = response.data['data'];
    print(data.toString());
    ProductDetail detail = ProductDetail.fromJson(data);
    return Future.value(detail);
  }
}
