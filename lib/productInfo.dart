import 'package:stylish/staticResource.dart';
import 'package:json_annotation/json_annotation.dart';

part 'productInfo.g.dart';

@JsonSerializable()
class ProductInfo {
  final int id;
  final ProductType category;
  final String title;
  final int price;
  @JsonKey(name: 'main_image')
  final String mainImagePath;

  ProductInfo(
      this.id, this.category, this.title, this.price, this.mainImagePath);

  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInfoToJson(this);
}

@JsonSerializable()
class ProductListResponse {
  @JsonKey(name: 'data')
  List<ProductInfo> list = [];
  @JsonKey(name: 'next_paging')
  int? paging;

  ProductListResponse(this.list, this.paging);

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListResponseToJson(this);
}
