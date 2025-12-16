import 'package:cubit_productlist/cubit/product_cubit.dart';
import 'package:cubit_productlist/home/home.dart';
import 'package:cubit_productlist/service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(BlocProvider(
    create: (context) => ProductCubit(ProductService())..fetchProducts(),
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}