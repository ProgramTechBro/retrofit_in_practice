import '../entities/product.dart';
import '../params/add_product_params.dart';
import '../repositories/product_repository.dart';

class AddProduct {
  final ProductRepository repository;

  AddProduct(this.repository);

  Future<Product> call(AddProductParams params) => repository.addProduct(params);
}