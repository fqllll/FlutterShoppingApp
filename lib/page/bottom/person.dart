import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homework2_shoppingapp/component/background1.dart';
import '../../instance/login_state_instance.dart';
import '../user/login.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    // 根据登录状态 判断显示的页面
    return loginState.state == 0?LogoutPerson():LoginPerson();
  }
}

// 未登录状态显示的页面
class LogoutPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FQ商城-个人主页')),
      body: Center(
        child: Center(
          child: Text('您还未登录,请点击右下方按钮进行登录！'),
        ),
      )
    );
  }
}

// 已登录状态显示的页面
class LoginPerson extends StatelessWidget {
  void _logout(BuildContext context) {
    // 设置未未登录状态
    loginState.user?.username = '游客';
    loginState.state = 0;
    Fluttertoast.showToast(
        msg: "退出登录！",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 215, 214, 214),
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('FQ商城-个人主页')),
        body: Stack(
          children: [
            Container(
              decoration: background2,
            ),
            Center(
              child: Column(children: [
                SizedBox(height: 50.0,),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('${loginState.user?.avatar}'),
                ),
                SizedBox(height: 20.0,),
                Text('${loginState.user?.username}'),
                SizedBox(height: 50.0,),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 150)),
                    ),
                    onPressed: () {
                      _logout(context);
                    },
                    child: Text(
                      '退出登录',
                      style: TextStyle(fontSize: 20.0),
                    ))
              ]),
            )
          ],
        ));
  }
}
