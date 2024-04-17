import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: OnlineStore(),
  ));
}

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product(this.name, this.price, this.imageUrl);
}

void showDiscountDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

class OnlineStore extends StatelessWidget {
  final List<Product> _products = [
    Product(
      'iPhone',
      999,
      'https://cdn.mos.cms.futurecdn.net/C26XWTEaJmZPEep4yadera-1024-80.jpeg',
    ),
    Product(
      'Laptop',
      1299,
      'https://i5.walmartimages.com/asr/cd6502a8-ece1-4f52-8648-5d7a5e9b564c_1.f43d905640766dc174d4e3d3501edd88.jpeg',
    ),
    Product(
      'Smart Watch',
      280,
      'https://sincoole.com/Uploads/20190219/18496013975c6b83aee7443.jpg',
    ),
    Product(
      'Headphones',
      110,
      'https://www.2008php.com/2020_Website_appreciate/2020-03-24/20200324225738LHPXaN2fJyzw.jpg',
    ),
  ];

  OnlineStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Store'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];

          return ListTile(
            leading: Image.network(
              product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: ElevatedButton(
              onPressed: () {
                if (product.price >= 300) {
                  showDiscountDialog(
                      context, 'Бесплатные подарки при покупке более 300 долларов');
                } else if (product.price >= 200) {
                  showDiscountDialog(
                      context, 'скидка 10% при покупке от 200 долларов');
                } else if (product.price >= 100) {
                  showDiscountDialog(
                      context, 'минус 20 долларов при покупке от 100 долларов');
                } else {
                  showDiscountDialog(context, 'Подходящего предложения нет');
                }
              },
              child: const Text('BUY'),
            ),
          );
        },
      ),
    );
  }
}
