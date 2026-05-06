import 'package:equatable/equatable.dart';

class AddProductParams extends Equatable {
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  const AddProductParams({
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  @override
  List<Object?> get props => [title, price, description, category, image];
}
