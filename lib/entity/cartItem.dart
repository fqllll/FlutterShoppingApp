import 'package:shoppingapp/entity/product.dart';

// 购物车产品类
class CartItem {
  Product product;
  int num;
  CartItem({required this.product, required this.num});
}
