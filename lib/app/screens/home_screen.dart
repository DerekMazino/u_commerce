import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_commerce/app/screens/screens.dart';
import 'package:u_commerce/app/widgets/widgets.dart';
import 'package:u_commerce/data/datasources/data_sources.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productServices = Provider.of<ProductService>(context);

    if(productServices.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productServices.products.length,
        itemBuilder: (_, int index) => GestureDetector(
          child: ProductCard(product: productServices.products[index],),
          onTap: () {
            productServices.selectedProduct = productServices.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
   );
  }
}