import '../../domain/entities/product.dart';
import '../../domain/params/add_product_params.dart';
import '../models/product_response_model.dart';
import '../models/product_request_model.dart';

class ProductMapper {
  static Product toEntity(ProductResponseModel model) => Product(
    id: model.id,
    title: model.title,
    price: model.price,
    description: model.description,
    category: model.category,
    image: model.image,
    ratingRate: model.rating?.rate ?? 0.0,
    ratingCount: model.rating?.count ?? 0,
  );

  static ProductRequestModel fromParams(AddProductParams params) => ProductRequestModel(
    title: params.title,
    price: params.price,
    description: params.description,
    category: params.category,
    image: params.image,
  );
}