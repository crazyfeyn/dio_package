import 'package:bloc/bloc.dart';
import 'package:dio_package/data/repositories/product_repository.dart';
import 'package:dio_package/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductInitialState()) {
    on<GetProductEvent>(_getProducts);
  }
  

  void _getProducts(GetProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      final response = await _productRepository.getProducts();
      emit(ProductLoadedState(response));
    } catch (e) {
      emit(ProductErrorState(e.toString()));
    }
  }
}
