import '../../../../core/networks/api_service.dart';
import '../models/product_response_model.dart';
import '../models/product_request_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductResponseModel>> getProducts();
  Future<ProductResponseModel> addProduct(ProductRequestModel request);
  Future<void> deleteProduct(int id);
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final ApiService _apiService;

  ProductRemoteDatasourceImpl(this._apiService);

  @override
  Future<List<ProductResponseModel>> getProducts() =>
      _apiService.getProducts();

  @override
  Future<ProductResponseModel> addProduct(ProductRequestModel request) =>
      _apiService.addProduct(request.toJson());

  @override
  Future<void> deleteProduct(int id) => _apiService.deleteProduct(id);
}