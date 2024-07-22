import 'package:dio_package/models/product.dart';
import 'package:dio_package/network/dio/dio_client.dart';

class DioHttpServices {
  final _dioClient = DioClient();

  Future<List<Product>> getProducts() async {
    return _dioClient.getProducts();
  }

  Future<void> deleteProduct(String id) {
    return _dioClient.deleteProduct(id);
  }

  Future<void> addProduct(Product product) async {
    return _dioClient.addProduct(product);
  }
}
