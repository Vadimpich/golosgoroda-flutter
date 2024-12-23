import 'package:flutter/material.dart';

class PromoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Получаем ширину экрана для адаптивного дизайна
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Голос Города'),
        titleTextStyle: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        backgroundColor: Colors.white
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 10), // Отступ сверху
                  child: Text(
                    'Ваш голос — имя для города',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4D00FF),
                    ),
                  ),
                ),
              ],
            ),
            // Первая карточка
            _buildPromoCard(
              context,
              title: 'Голосуйте за названия улиц, парков, станций метро и других объектов!',
              image: 'assets/metro.jpg',
              screenWidth: screenWidth,
            ),
            // Вторая карточка
            _buildPromoCard(
              context,
              title: 'Каждое решение приближает нас к лучшему городу!',
              image: 'assets/moscow.jpg',
              screenWidth: screenWidth,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF4D00FF),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 0, // Индекс активного элемента
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/'); // Перейти на страницу "/"
          } else if (index == 1) {
            Navigator.pushNamed(context, '/objects'); // Перейти на страницу "/objects"
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

  Widget _buildPromoCard(BuildContext context, {
    required String title,
    required String image,
    required double screenWidth,
  }) {
    final isMobile = screenWidth < 600; // Определяем мобильное устройство
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF4D00FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          if (isMobile) ...[
            // Изображение сверху на мобильных
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ] else ...[
            // Изображение сбоку на больших экранах
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: Image.asset(
                      image,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
