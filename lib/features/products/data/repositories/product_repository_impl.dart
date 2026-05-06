import '../../domain/params/add_product_params.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../mappers/product_mapper.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource _datasource;

  ProductRepositoryImpl(this._datasource);

  @override
  Future<List<Product>> getProducts() async {
    final models = await _datasource.getProducts();
    return models.map(ProductMapper.toEntity).toList();
  }

  @override
  Future<Product> addProduct(AddProductParams params) async {
    final request = ProductMapper.fromParams(params);
    final response = await _datasource.addProduct(request);
    return ProductMapper.toEntity(response);
  }

  @override
  Future<void> deleteProduct(int id) => _datasource.deleteProduct(id);
}