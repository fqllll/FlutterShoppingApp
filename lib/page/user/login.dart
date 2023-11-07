import 'package:flutter/material.dart';
import 'package:shoppingapp/component/myToast.dart';
import '../../bottom_navigation_widget.dart';
import '../../instance/login_state_instance.dart';
import 'register.dart';
import '../../entity/user.dart';
import '../../instance/userList.dart';
import '../../component/background1.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _login() {
    // 得到用户输入的用户名和密码
    String username = _usernameController.text;
    String password = _passwordController.text;
    User one = User(username: username, password: password);
    bool isLoggedIn = false;
    // 匹配用户名和密码
    for (User user in userList) {
      if (user.username == username && user.password == password) {
        isLoggedIn = true;
        break;
      }
    }
    // 校验登录是否成功
    if (isLoggedIn) {
      loginState.user = one;
      loginState.state = 1;
      successToast("登录成功！", true);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationWidget()),
        (route) => false,
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('登录失败'),
            content: Text('用户名或密码不正确。'),
            actions: <Widget>[
              TextButton(
                child: Text('关闭'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // 返回到首页
        onWillPop: () async {
          // 将BottomNavigationWidget推入导航栈中，并清空导航栈
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigationWidget()),
            (route) => false,
          );
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('登录页面'),
          ),
          body: Container(
            decoration: background1,
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: '用户名',
                      hintText: "请输入用户名 ~",
                      icon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 18.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '密码',
                      hintText: "请输入密码 ~",
                      icon: Icon(Icons.security),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                      width: double.infinity,
                      child: FloatingActionButton.extended(
                        label: Text("登录"),
                        icon: Icon(Icons.login),
                        backgroundColor: Colors.green,
                        onPressed: _login,
                      )),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      // 处理跳转到注册界面的逻辑
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return RegisterPage();
                      }));
                    },
                    child: Text(
                      '前往注册',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
