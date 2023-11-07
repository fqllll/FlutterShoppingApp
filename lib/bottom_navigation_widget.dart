import 'package:flutter/material.dart';
import 'instance/login_state_instance.dart';
import 'page/bottom/home.dart';
import 'page/bottom/person.dart';
import 'page/bottom/shoppingcart.dart';
import 'page/bottom/message.dart';
import 'page/user/login.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {

  List<Widget>  pagelist = [];
  bool _shouldRender = false;
  int _currentIndex = 0;

  @override
  void initState() {
    pagelist
      ..add(HomePage())
      ..add(MessagePage())
      ..add(ShoppingcartPage())
      ..add(PersonPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 控制是否在底部显示登录按钮
    bool showFloatingActionButton = (loginState.state == 0);

    return Scaffold(
      body:pagelist[_currentIndex],
      floatingActionButton: showFloatingActionButton?Transform.scale(
          scale: 1.2,
          child:FloatingActionButton(
          onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
              return LoginPage();
            }))
          },
          child: Row(
            children: [
              Icon(
                Icons.login,
                color: Colors.white,
              ),
              Text('登录'),
            ],
          ),
        )
      ,):null, 
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Color.fromARGB(255, 252, 171, 198),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:'主页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label:'消息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label:'购物车',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label:'我的',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}