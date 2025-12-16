import 'package:cubit_productlist/cubit/product_cubit.dart';
import 'package:cubit_productlist/state/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final ScrollController _controller = ScrollController();

  @override
void initState() {
  super.initState();

  _controller.addListener(() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 200) {
      context.read<ProductCubit>().fetchProducts();
    }
  });
}


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text("Product List"),
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        onChanged: (value) {
          context.read<ProductCubit>().searchProducts(value);
        },
        decoration: InputDecoration(
          hintText: "Search products...",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
  ),
),

       

      body:BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ProductLoaded) {
  return RefreshIndicator(
    onRefresh: ()async{
 context.read<ProductCubit>().refreshProduct();
    },
    child: ListView.separated(
      controller: _controller,
      padding: const EdgeInsets.all(16),
      itemCount: state.products.length+1,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
            if (index < state.products.length) {
    final data = state.products[index];
         return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.body,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 96, 163, 171),
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        );
    } else {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(child: CircularProgressIndicator()),
    );
    }
     
      },
    ),
  );
}


          if (state is Producterror) {
            return Text(state.message);
          }
          return Container();
        },
      ),
    );
  }
}