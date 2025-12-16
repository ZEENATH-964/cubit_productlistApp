import 'package:cubit_productlist/model/product_model.dart';

abstract class ProductState{}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState{}
class ProductLoaded extends ProductState{
  final List<ProductModel>products;
  ProductLoaded(this.products);

}

class Producterror extends ProductState {
  final String message;
  Producterror(this.message);
}