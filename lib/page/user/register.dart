import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homework2_shoppingapp/component/myAlertDialog.dart';
import '../../component/background1.dart';
import '../../entity/user.dart';
import '../../instance/user_list.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void register(BuildContext context) {
// 获取注册信息
    String username = _usernameController.text;
    String password = _passwordController.text;
    //非空校验
    if (username != '' && password != '') {
      // 只做了非空校验，没有做重复校验
      // 将注册信息添加到用户列表（userlist）
      userList.add(User(username: username, password: password));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlertDialog(
            context: context,
            title: '注册成功',
            text: '恭喜您，注册成功！',
          );
        },
      );
    } else {
      Fluttertoast.showToast(
          msg: "账号或密码不能为空！",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 237, 140, 134),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('注册页面'),
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
                  child:FloatingActionButton.extended(
                      label: Text("注册"),
                      icon:Icon(Icons.app_registration),
                      backgroundColor: Colors.pinkAccent,
                      onPressed: () {
                        register(context);
                      },
                  )
                ),
                ],
              ),
            )));
  }
}
