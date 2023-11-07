import 'package:flutter/material.dart';
import 'package:shoppingapp/component/myToast.dart';
import 'package:shoppingapp/entity/cartItem.dart';
import 'package:shoppingapp/instance/cartItemList.dart';

class ShoppingcartPage extends StatefulWidget {
  const ShoppingcartPage({super.key});

  @override
  State<ShoppingcartPage> createState() => _ShoppingcartPageState();
}

class _ShoppingcartPageState extends State<ShoppingcartPage> {
  // 删除商品（当商品的数量变为0）
  void removeItem(int productId) {
    setState(() {
      cartItemList.removeWhere((item) => item.product.id == productId);
    });
  }

  // 增加商品数量
  void increaseItem(CartItem cartItem) {
    setState(() {
      cartItem.num++;
    });
  }

  //减少商品数量
  void decreaseItem(CartItem cartItem) {
    setState(() {
      cartItem.num--;
      if (cartItem.num == 0) {
        removeItem(cartItem.product.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FQ商城-购物车页面')),
      body: Stack(
        children: [
          Positioned.fill(
            child: ShoppingcartGridView(
              cartItems: cartItemList,
              onIncreaseItem: increaseItem,
              onDecreaseItem: decreaseItem,
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('数量: ${calculateTotalQuantity()}'),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text('合计: ￥ '),
                  Text(
                    calculateTotalAmount().toStringAsFixed(2),
                    style: TextStyle(fontSize: 24.0, color: Colors.red[600]),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[200]),
                        onPressed: () {
                          setState(() {
                            cartItemList = [];
                            warningToast("已清空购物车！", false);
                          });
                        },
                        child: Text('清空'),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue[200]),
                        onPressed: () {
                          setState(() {
                            successToast(
                                "共支付￥${calculateTotalAmount().toStringAsFixed(2)}！谢谢惠顾！",
                                false);
                            cartItemList = [];
                          });
                        },
                        child: Text('结算'),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int calculateTotalQuantity() {
    int totalQuantity = 0;
    for (var item in cartItemList) {
      totalQuantity += item.num;
    }
    return totalQuantity;
  }

  double calculateTotalAmount() {
    double totalAmount = 0;
    for (var item in cartItemList) {
      totalAmount += item.product.price * item.num;
    }
    return totalAmount;
  }
}

class ShoppingcartGridView extends StatefulWidget {
  // 购物车列表
  final List<CartItem> cartItems;
  final Function(CartItem) onIncreaseItem;
  final Function(CartItem) onDecreaseItem;

  ShoppingcartGridView({
    required this.cartItems,
    required this.onIncreaseItem,
    required this.onDecreaseItem,
  });

  @override
  _ShoppingcartGridViewState createState() => _ShoppingcartGridViewState();
}

class _ShoppingcartGridViewState extends State<ShoppingcartGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // 每行显示的购物车项目数
        childAspectRatio: 4.8, // 调整宽高比例
      ),
      itemCount: widget.cartItems.length,
      itemBuilder: (context, index) {
        CartItem cartItem = widget.cartItems[index];
        return Container(
          margin: EdgeInsets.all(8.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20.0,
              ),
              SizedBox(
                height: 60.0,
                child: Image(image: NetworkImage(cartItem.product.imageUrl)),
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cartItem.product.name,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    '￥${cartItem.product.price}',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 40.0,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            setState(() {
                              widget.onDecreaseItem(cartItem);
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromARGB(223, 246, 177, 243)),
                        child: Text('-'),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text('${cartItem.num}'),
                    SizedBox(
                      width: 5.0,
                    ),
                    SizedBox(
                      width: 40.0,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.onIncreaseItem(cartItem);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromARGB(223, 246, 177, 243)),
                        child: Text('+'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
