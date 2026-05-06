import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/params/add_product_params.dart';
import '../../../../core/errors/error_handler.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;
  final AddProduct addProduct;
  final DeleteProduct deleteProduct;

  ProductCubit({
    required this.getProducts,
    required this.addProduct,
    required this.deleteProduct,
  }) : super(const ProductInitial());

  Future<void> fetchProducts() async {
    emit(const ProductLoading());
    try {
      final products = await getProducts();
      emit(ProductLoaded(
        products: products,
        filteredProducts: products,
      ));
    } catch (e) {
      emit(ProductError(ErrorHandler.handle(e)));
    }
  }

  void searchProducts(String query) {
    final current = state;
    List<Product> allProducts = [];

    if (current is ProductLoaded) {
      allProducts = current.products;
    } else if (current is ProductActionSuccess) {
      allProducts = current.products;
    } else {
      return;
    }

    final filtered = query.isEmpty
        ? allProducts
        : allProducts
        .where(
          (p) =>
      p.title.toLowerCase().contains(query.toLowerCase()) ||
          p.category.toLowerCase().contains(query.toLowerCase()),
    )
        .toList();

    emit(ProductLoaded(
      products: allProducts,
      filteredProducts: filtered,
      searchQuery: query,
    ));
  }

  Future<void> addNewProduct(AddProductParams params) async {
    final currentProducts = _getCurrentProducts();
    try {
      final newProduct = await addProduct(params);
      final updated = [newProduct, ...currentProducts];
      emit(ProductActionSuccess(
        message: 'Product added successfully!',
        products: updated,
        filteredProducts: updated,
      ));
    } catch (e) {
      emit(ProductError(ErrorHandler.handle(e)));
    }
  }

  Future<void> removeProduct(int id) async {
    final currentProducts = _getCurrentProducts();
    try {
      await deleteProduct(id);
      final updated = currentProducts.where((p) => p.id != id).toList();
      emit(ProductActionSuccess(
        message: 'Product deleted successfully!',
        products: updated,
        filteredProducts: updated,
      ));
    } catch (e) {
      emit(ProductError(ErrorHandler.handle(e)));
    }
  }

  List<Product> _getCurrentProducts() {
    if (state is ProductLoaded) return (state as ProductLoaded).products;
    if (state is ProductActionSuccess) {
      return (state as ProductActionSuccess).products;
    }
    return [];
  }
}