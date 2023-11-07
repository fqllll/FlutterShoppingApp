import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  String text;
  String title;
  MyAlertDialog({required context,required this.title,required this.text});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: <Widget>[
        ElevatedButton(
          child: Text('确定'),
          onPressed: () {
            Navigator.pop(context); // 关闭弹窗
            Navigator.pop(context); // 返回上一页面
          },
        ),
      ],
    );
  }
}
