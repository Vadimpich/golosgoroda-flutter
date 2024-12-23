import 'package:flutter/material.dart';
import 'pages/index.dart';
import 'pages/objects.dart';
import 'pages/object_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Голос Города',
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => PromoPage());
        }

        if (settings.name == '/objects') {
          return MaterialPageRoute(builder: (_) => ObjectsPage());
        }

        // Обработка маршрутов с параметром (например, /objects/1)
        if (settings.name != null && settings.name!.startsWith('/objects/')) {
          final id = settings.name!.split('/').last; // Извлечение id
          return MaterialPageRoute(builder: (_) => ObjectDetailPage(objectId: id));
        }

        // Маршрут по умолчанию
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('404: Страница не найдена')),
          ),
        );
      },
      initialRoute: '/',
    );
  }
}
