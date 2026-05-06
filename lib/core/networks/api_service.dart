import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/products/data/models/product_response_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/products')
  Future<List<ProductResponseModel>> getProducts();

  @POST('/products')
  Future<ProductResponseModel> addProduct(@Body() Map<String, dynamic> product);

  @DELETE('/products/{id}')
  Future<dynamic> deleteProduct(@Path('id') int id);
}