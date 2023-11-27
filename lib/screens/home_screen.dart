import 'package:flutter/material.dart';
import 'package:flutter_app_cap12/screens/screens.dart';
import 'package:flutter_app_cap12/models/models.dart';
import 'package:flutter_app_cap12/services/products_service.dart';
import 'package:flutter_app_cap12/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    if (productsService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 15),
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            productsService.selectedProduct =
                productsService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(product: productsService.products[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct =
              Product(available: true, name: 'test product', price: 25);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
