import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_commerce/app/provider/product_form_provider.dart';
import 'package:u_commerce/app/ui/input_decorations.dart';
import 'package:u_commerce/app/widgets/widgets.dart';
import 'package:u_commerce/data/datasources/data_sources.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
    //return
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                  url: productService.selectedProduct.image,
                ),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new,
                          size: 40, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    )),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt_outlined,
                          size: 40, color: Colors.white),
                      onPressed: () {
                        //TODO: galeria
                      },
                    )),
              ],
            ),
            _ProductForm(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          //TODO: Guardar productos
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del producto', labelText: 'Nombre: '),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: '${product.price}',
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '\$15k', labelText: 'Precio: '),
              ),
              SizedBox(
                height: 30,
              ),
              SwitchListTile.adaptive(
                  title: Text('Disponible'),
                  activeColor: Colors.indigo,
                  value: product.available,
                  onChanged: (value) {}),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
            color: Colors.black12.withOpacity(0.5),
            offset: Offset(0, 5),
            blurRadius: 5),
      ],
    );
  }
}
