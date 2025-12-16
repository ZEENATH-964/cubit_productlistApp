import 'package:cubit_productlist/model/product_model.dart';
import 'package:cubit_productlist/service/product_service.dart';
import 'package:cubit_productlist/state/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService service;
  int page=1;
  int limit=10;
  bool isFetching=false;
   
  bool hasMore=true;
  List<ProductModel>allProducts=[];
  ProductCubit(this.service) : super(ProductInitial());

  void fetchProducts()async{
    if(isFetching||!hasMore)return;
    isFetching=true;
    if (page==1) {
        emit(ProductLoading());
    }
  

    try {
      final products=await service.fetchData(page: page,limit: limit);
      if(products.length<limit){
        hasMore=false;
      }
      allProducts.addAll(products);
      emit(ProductLoaded(List.from(allProducts)));
      page++;
    } catch (e) {
      emit(Producterror("Failed to load products"));
    }finally{
        isFetching = false;
    }
  }

  searchProducts(String query){
if (query.isEmpty) {
  emit(ProductLoaded(allProducts));
  return;
}
final filterd=allProducts.where((product){
  return product.title.toLowerCase().startsWith(query.toLowerCase());
}).toList();
emit(ProductLoaded(filterd));
  }

  void refreshProduct(){
 page=1;
 hasMore=true;
 allProducts.clear();
 fetchProducts();
}
}

