import 'package:dio_package/models/product.dart';
import 'package:dio_package/services/dio_http_services.dart';

class ProductRepository {
  final DioHttpServices _dioHttpServices;

  ProductRepository({required DioHttpServices dioHttpServices})
      : _dioHttpServices = dioHttpServices;

  Future<List<Product>> getProducts() {
    return _dioHttpServices.getProducts();
  }

   Future<void> deleteProduct(String id) {
    return _dioHttpServices.deleteProduct(id);
  }

  Future<void> addProduct(Product product) async {
    return _dioHttpServices.addProduct(product);
  }
}
