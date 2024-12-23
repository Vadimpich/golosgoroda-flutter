import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  final String title;
  final Widget child;

  const AppPage({Key? key, required this.title, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Text('Домой', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/objects');
            },
            child: Text('Объекты', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: child,
    );
  }
}
