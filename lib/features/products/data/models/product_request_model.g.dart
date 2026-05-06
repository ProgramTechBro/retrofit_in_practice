// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRequestModel _$ProductRequestModelFromJson(Map<String, dynamic> json) =>
    ProductRequestModel(
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$ProductRequestModelToJson(
  ProductRequestModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'price': instance.price,
  'description': instance.description,
  'category': instance.category,
  'image': instance.image,
};
