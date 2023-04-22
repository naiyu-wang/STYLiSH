// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) =>
    ProductDetail(
      json['id'] as int,
      $enumDecode(_$ProductTypeEnumMap, json['category']),
      json['title'] as String,
      json['price'] as int,
      json['note'] as String,
      json['texture'] as String,
      json['description'] as String,
      json['wash'] as String,
      json['place'] as String,
      json['story'] as String,
      json['main_image'] as String,
      (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': _$ProductTypeEnumMap[instance.category]!,
      'title': instance.title,
      'price': instance.price,
      'note': instance.note,
      'texture': instance.texture,
      'description': instance.description,
      'wash': instance.wash,
      'place': instance.place,
      'story': instance.story,
      'main_image': instance.mainImagePath,
      'images': instance.images,
    };

const _$ProductTypeEnumMap = {
  ProductType.all: 'all',
  ProductType.men: 'men',
  ProductType.women: 'women',
  ProductType.accessories: 'accessories',
};
