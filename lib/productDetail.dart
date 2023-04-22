import 'package:stylish/staticResource.dart';
import 'package:json_annotation/json_annotation.dart';

part 'productDetail.g.dart';

@JsonSerializable()
class ProductDetail {
  final int id;
  final ProductType category;
  final String title;
  final int price;
  final String note;
  final String texture;
  final String description;
  final String wash;
  final String place;
  final String story;
  @JsonKey(name: 'main_image')
  final String mainImagePath;
  final List<String> images;

  ProductDetail(
      this.id,
      this.category,
      this.title,
      this.price,
      this.note,
      this.texture,
      this.description,
      this.wash,
      this.place,
      this.story,
      this.mainImagePath,
      this.images);

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);
}
