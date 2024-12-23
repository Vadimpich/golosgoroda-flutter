import 'package:flutter/material.dart';
import 'package:golosgoroda_mobile/modules/api.dart';

class ObjectDetailPage extends StatefulWidget {
  final String objectId;
  const ObjectDetailPage({Key? key, required this.objectId}) : super(key: key);

  @override
  _ObjectDetailPageState createState() => _ObjectDetailPageState();
}

class _ObjectDetailPageState extends State<ObjectDetailPage> {
  bool loading = true;
  String? error;
  Object? object;

  @override
  void initState() {
    super.initState();
    fetchObjectDetail();
  }

  Future<void> fetchObjectDetail() async {
    try {
      object = await Api.getObject(widget.objectId);
      if (object != null) {
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          error = 'Объект не найден';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(title: Text('Загрузка...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: Text('Ошибка')),
        body: Center(child: Text('Ошибка: $error')),
      );
    }

    if (object == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Не найдено')),
        body: Center(child: Text('Объект не найден')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(object!.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs (Путь)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text("Главная", style: TextStyle(fontSize: 16)),
                    Icon(Icons.arrow_forward),
                    Text("Объекты", style: TextStyle(fontSize: 16)),
                    Icon(Icons.arrow_forward),
                    Text(object!.name, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Image.network(
                object!.image.replaceFirst('localhost', IP),
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                object!.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                object!.description, // Здесь можно вставить описание объекта
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
