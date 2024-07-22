import 'package:bloc/bloc.dart';
import 'package:dio_package/blocs/product_bloc.dart';
import 'package:dio_package/data/repositories/product_repository.dart';
import 'package:dio_package/services/dio_http_services.dart';
import 'package:dio_package/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

final dioHttpServices = DioHttpServices();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ProductRepository>(create: (ctx) {
            return ProductRepository(dioHttpServices: dioHttpServices);
          })
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<ProductBloc>(create: (ctx) {
                return ProductBloc(
                    productRepository:
                        RepositoryProvider.of<ProductRepository>(ctx));
              })
            ],
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            )));
  }
}
