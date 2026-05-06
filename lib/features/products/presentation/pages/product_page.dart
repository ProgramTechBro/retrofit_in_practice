import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../state/product_cubit.dart';
import '../state/product_state.dart';
import 'local_widgets/product_app_bar.dart';
import 'local_widgets/product_search_bar.dart';
import 'local_widgets/product_grid.dart';
import 'local_widgets/product_shimmer_grid.dart';
import 'local_widgets/product_error_view.dart';
import 'local_widgets/add_product_sheet.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductCubit>()..fetchProducts(),
      child: const _ProductPageView(),
    );
  }
}

class _ProductPageView extends StatefulWidget {
  const _ProductPageView();

  @override
  State<_ProductPageView> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends State<_ProductPageView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddProductSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ProductCubit>(),
        child: const AddProductSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4F0),
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFF2D6A4F),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
          }
          if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFD62828),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              ProductAppBar(
                onAddTap: () => _showAddProductSheet(context),
              ),
              SliverToBoxAdapter(
                child: ProductSearchBar(
                  controller: _searchController,
                  onChanged: (query) =>
                      context.read<ProductCubit>().searchProducts(query),
                ),
              ),
              if (state is ProductLoading)
                const ProductShimmerGrid()
              else if (state is ProductError)
                SliverFillRemaining(
                  child: ProductErrorView(
                    message: state.message,
                    onRetry: () => context.read<ProductCubit>().fetchProducts(),
                  ),
                )
              else if (state is ProductLoaded)
                  ProductGrid(products: state.filteredProducts)
                else if (state is ProductActionSuccess)
                    ProductGrid(products: state.filteredProducts)
                  else
                    const SliverFillRemaining(child: SizedBox()),
            ],
          );
        },
      ),
    );
  }
}