// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) => ProductInfo(
      json['id'] as int,
      $enumDecode(_$ProductTypeEnumMap, json['category']),
      json['title'] as String,
      json['price'] as int,
      json['main_image'] as String,
    );

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': _$ProductTypeEnumMap[instance.category]!,
      'title': instance.title,
      'price': instance.price,
      'main_image': instance.mainImagePath,
    };

const _$ProductTypeEnumMap = {
  ProductType.all: 'all',
  ProductType.men: 'men',
  ProductType.women: 'women',
  ProductType.accessories: 'accessories',
};

ProductListResponse _$ProductListResponseFromJson(Map<String, dynamic> json) =>
    ProductListResponse(
      (json['data'] as List<dynamic>)
          .map((e) => ProductInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_paging'] as int?,
    );

Map<String, dynamic> _$ProductListResponseToJson(
        ProductListResponse instance) =>
    <String, dynamic>{
      'data': instance.list,
      'next_paging': instance.paging,
    };
