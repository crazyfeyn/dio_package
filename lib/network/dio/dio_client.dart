import 'package:dio/dio.dart';
import 'package:dio_package/models/product.dart';

class DioClient {
  final Dio _dio = Dio();
  final _baseUrl = 'https://api.escuelajs.co/api/v1';

  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    try {
      Response productData = await _dio.get('$_baseUrl/products');
      for (var product in productData.data) {
        products.add(Product.fromMap(product));
      }
      return products;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    await _dio.delete('$_baseUrl/products/$id');
  }

  Future<void> addProduct(Product product) async {
    await _dio.post('$_baseUrl/products', data: {
      'id': product.id,
      'title': product.title,
      'description': product.description,
      'category': product.category,
      'images': product.images,
    });
  }
}
