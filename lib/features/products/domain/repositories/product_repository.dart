import '../entities/product.dart';
import '../params/add_product_params.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> addProduct(AddProductParams params);
  Future<void> deleteProduct(int id);
}