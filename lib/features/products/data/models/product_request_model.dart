import 'package:json_annotation/json_annotation.dart';

part 'product_request_model.g.dart';

@JsonSerializable()
class ProductRequestModel {
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  const ProductRequestModel({
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory ProductRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRequestModelToJson(this);
}