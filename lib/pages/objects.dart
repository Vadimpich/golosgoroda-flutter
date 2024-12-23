import 'package:flutter/material.dart';
import 'package:golosgoroda_mobile/modules/api.dart'; // Импортируйте ваш API для получения данных

class ObjectsPage extends StatefulWidget {
  @override
  _ObjectsPageState createState() => _ObjectsPageState();
}

class _ObjectsPageState extends State<ObjectsPage> {
  List<Object> objects = [];
  String searchTerm = "";

  // Метод для получения объектов
  Future<void> fetchObjects() async {
    try {
      final data = await Api.getObjects(searchTerm); // Замените на ваш метод API
      setState(() {
        objects = data;
      });
    } catch (error) {
      print("Ошибка при получении данных: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchObjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Объекты для голосования'),
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Breadcrumbs (Путь)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text("Главная", style: TextStyle(fontSize: 16)),
                Icon(Icons.arrow_forward),
                Text("Объекты", style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          // Поле поиска
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  searchTerm = text;
                });
                fetchObjects(); // Обновление объектов по поисковому запросу
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: 'Поиск...',
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
            ),
          ),
          // Список объектов
          Expanded(
            child: objects.isEmpty
                ? Center(child: Text("Ничего не найдено"))
                : ListView.builder(
              itemCount: objects.length,
              itemBuilder: (context, index) {
                return ObjectCard(object: objects[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF4D00FF),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 1, // Индекс активного элемента
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/objects');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Домой',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Объекты',
          ),
        ],
      ),
    );
  }
}

// Карточка объекта
class ObjectCard extends StatelessWidget {
  final Object object;

  ObjectCard({required this.object});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/objects/${object.id}');
        },
        child: Row(
          children: [
            Image.network(object.image.replaceFirst('localhost', IP), width: 100, height: 100, fit: BoxFit.cover),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                object.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
