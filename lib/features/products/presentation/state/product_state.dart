import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> filteredProducts;
  final String searchQuery;

  const ProductLoaded({
    required this.products,
    required this.filteredProducts,
    this.searchQuery = '',
  });

  ProductLoaded copyWith({
    List<Product>? products,
    List<Product>? filteredProducts,
    String? searchQuery,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [products, filteredProducts, searchQuery];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductActionSuccess extends ProductState {
  final String message;
  final List<Product> products;
  final List<Product> filteredProducts;

  const ProductActionSuccess({
    required this.message,
    required this.products,
    required this.filteredProducts,
  });

  @override
  List<Object?> get props => [message, products, filteredProducts];
}