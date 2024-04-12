import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: OnlineStore(),
  ));
}

//class product
class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product(this.name, this.price, this.imageUrl);
}

//abstract handler class
abstract class Handler {
  Handler? _nextHandler;

  set nextHandler(Handler handler) {
    _nextHandler = handler;
  }

  void processRequest(Product product, BuildContext context); //Abstract method,Process request

  void handleRequest(Product product, BuildContext context) {
    processRequest(product, context);

    if (_nextHandler != null) {
      _nextHandler!.handleRequest(product, context);
    }
  }
}

// DiscountHandler
class DiscountHandler extends Handler {
  @override
  void processRequest(Product product, BuildContext context) {
    if (product.price >= 100) {
      _showDialog(context, '满100减20优惠已应用');
    } else {
      // 若条件不满足，则交由下一个处理器处理
      _nextHandler?.handleRequest(product, context);
    }
  }
}

// 打折处理器
class PromotionHandler extends Handler {
  @override
  void processRequest(Product product, BuildContext context) {
    if (product.price > 200) {
      _showDialog(context, '满200打9折优惠已应用');
    } else {
      // 若条件不满足，则交由下一个处理器处理
      _nextHandler?.handleRequest(product, context);
    }
  }
}

// 赠品处理器
class GiftHandler extends Handler {
  @override
  void processRequest(Product product, BuildContext context) {
    if (product.price > 300) {
      _showDialog(context, '购物满300送精美礼品');
    } else {
      // 若条件不满足，则交由下一个处理器处理
      _nextHandler?.handleRequest(product, context);
    }
  }
}

void _showDialog(BuildContext context, String message) {
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
      199,
      'https://sincoole.com/Uploads/20190219/18496013975c6b83aee7443.jpg',
    ),
    Product(
      'Headphones',
      79,
      'https://www.2008php.com/2020_Website_appreciate/2020-03-24/20200324225738LHPXaN2fJyzw.jpg',
    ),
  ];

  final Handler _discountHandler = DiscountHandler();
  final Handler _promotionHandler = PromotionHandler();
  final Handler _giftHandler = GiftHandler();

  OnlineStore({super.key});

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
          if (product.imageUrl.isEmpty) {
            return const SizedBox.shrink(); // 没有有效图片链接则返回空白部件
          }

          // 初始化责任链
          _discountHandler.nextHandler = _promotionHandler;
          _promotionHandler.nextHandler = _giftHandler;

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
                // 购买商品，触发责任链处理
                _discountHandler.handleRequest(product, context);
              },
              child: const Text('购买'),
            ),
          );
        },
      ),
    );
  }
}
