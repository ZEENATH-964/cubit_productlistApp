import 'package:cubit_productlist/model/product_model.dart';
import 'package:dio/dio.dart';

class ProductService {
  Dio dio=Dio();
  Future<List<ProductModel>>fetchData(
     {
      required int page,
      int limit=10
     }

  )async{
 final response=await dio.get("https://jsonplaceholder.typicode.com/posts",
 queryParameters: {
  "_page":page,
  "_limit":limit
 }
 );
 final List data=response.data;
 return data.map((e)=>ProductModel.fromJson(e)).toList();
  }
}