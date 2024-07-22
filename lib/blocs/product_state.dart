part of 'product_bloc.dart';

sealed class ProductState {}

final class ProductInitialState extends ProductState {}

final class ProductLoadingState extends ProductState {}

final class ProductLoadedState extends ProductState {
  List<Product> products;

  ProductLoadedState(this.products);
}

final class ProductErrorState extends ProductState {
  String message;

  ProductErrorState(this.message);
}
