import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homework2_shoppingapp/entity/category.dart';
import '../../entity/product.dart';
import '../../instance/category_list.dart';
import '../../instance/product_list.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText = '';
  int categoryId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FQ商城-首页'),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.0,
            ),
            Text(
              '欢迎来到FQ商城~',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: '搜索商品',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            // 单个可滚动视图
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (Category category in category_list)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          categoryId = category.id;
                        });
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50.0,
                            child: Image(image: AssetImage(category.img)),
                          ),
                          Text(category.name),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
                child: ProductGridView(
                    products: products,
                    searchText: searchText,
                    categoryId: categoryId
                )),
          ],
        ),
      ),
    );
  }
}

class ProductGridView extends StatelessWidget {
  // 商品列表
  List<Product> products = [];
  // 搜索框内容
  String searchText;
  // 分类
  int categoryId;
  // 构造器
  ProductGridView(
      {required this.products,
      required this.searchText,
      required this.categoryId});

  @override
  Widget build(BuildContext context) {
    print(categoryId);
    List<Product> filteredProducts = (categoryId == 0)
        ? products
        : products
            .where((product) => product.categoryId == categoryId)
            .toList();

    filteredProducts = searchText.isEmpty
        ? filteredProducts
        //where对列表中的每个元素进行判断
        : filteredProducts
            // 过滤商品名称（筛选屏蔽字母大小写）
            .where((filteredProduct) => filteredProduct.name
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
    if (filteredProducts.isEmpty) {
      Fluttertoast.showToast(
          msg: "没有商品~试试换一个搜索条件或分类~",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 每行显示的商品数量
        childAspectRatio: 0.8, // 调整宽高比例
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        Product product = filteredProducts[index];
        return Container(
          margin: EdgeInsets.all(8.0),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Image.network(
                    product.imageUrl,
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.fitWidth,
                  )),
              SizedBox(height: 5.0),
              Text(
                product.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              Text(
                '￥${product.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18.0, color: Colors.red),
              ),
              SizedBox(height: 5.0),
            ],
          ),
        );
      },
    );
  }
}
