import 'package:dio_package/blocs/product_bloc.dart';
import 'package:dio_package/data/repositories/product_repository.dart';
import 'package:dio_package/main.dart';
import 'package:dio_package/models/product.dart';
import 'package:dio_package/views/widgets/add_product_widget.dart';
import 'package:dio_package/views/widgets/product_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductErrorState) {
          return Center(child: Text(state.message));
        }
        List<Product> products = [];
        if (state is ProductLoadedState) {
          products = state.products;
        }

        return products.isEmpty
            ? const Center(
                child: Text('Products are not available'),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    ProductInfo(product: product)));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          product.images.isNotEmpty
                              ? Image.network(
                                  product.images[0],
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: double.infinity,
                                )
                              : const Icon(
                                  Icons.image_not_supported,
                                  size: 100,
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '\$${product.price.toStringAsFixed(2)}'),
                                    Text(product.category.name),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddProductWidget();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
