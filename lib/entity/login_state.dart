import 'user.dart';

class LoginState{
  User? user;
  int? state; // 0未登录，1已登录
  LoginState({this.user,this.state});
}
