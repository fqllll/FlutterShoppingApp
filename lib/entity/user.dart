class User {
  // 用户名
  String username;
  // 密码
  String password;
  // 头像
  String avatar;
  User({
    required this.username, 
    required this.password,
    this.avatar = 'https://img2.baidu.com/it/u=937749821,1106210473&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500'});
}