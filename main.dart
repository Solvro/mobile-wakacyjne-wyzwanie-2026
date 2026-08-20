import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            //home: DreamPlaceScreen(),
            home: HomeScreen(),
        );
    }
}

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  final List<Map<String,String>> places = const [
    {
      'title': 'Etretat, Francja',
      'subTitle': 'Wybrzeże Normandii',
      'description': 'Klify nad Kanałem La Manche',
      'imagePath': 'assets/images/etretat.jpg',
    },
    {
      'title': 'Gdynia, Polska',
      'subTitle': 'Wybrzeże Zatoki Puckiej',
      'description': 'Klif orłowski w Gdyni',
      'imagePath': 'assets/images/gdynia.jpg',
    },
    {
      'title': 'Dover, Anglia',
      'subTitle': 'Wybrzeże w Dover',
      'description': 'Wybrzeże angielskie nad Cieśniną Kaletańską',
      'imagePath': 'assets/images/dover.jpg',
    },
    {
      'title': 'Clare, Irlandia',
      'subTitle': 'Wybrzeże Irlandii',
      'description': 'Klify Moheru na zachodzie Irlandii w hrabstwie Clare',
      'imagePath': 'assets/images/moher.jpg',
    },
    {
      'title': 'Hornelen, Norwegia',
      'subTitle': 'Wybrzeże Norwegii',
      'description': 'Najwyższy klif w Europie, 860 m n.p.m.',
      'imagePath': 'assets/images/hornelen.jpg',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Klify Europy'),
      ),
      // ZMIANA: Użycie ListView.builder do stworzenia przewijanej listy 5 kafelków
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return ListTile(
            leading: Image.asset(
              place['imagePath']!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(place['title']!),
            subtitle: Text(place['subTitle']!),
            trailing: const Icon(Icons.arrow_forward_ios),
            // ZMIANA: Przekierowanie do ekranu szczegółowego po kliknięciu kafelka
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DreamPlaceScreen(
                    title: place['title']!,
                    subTitle: place['subTitle']!,
                    description: place['description']!,
                    imagePath: place['imagePath']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DreamPlaceScreen extends StatefulWidget {
  final String title;
  final String subTitle;
  final String description;
  final String imagePath;

  const DreamPlaceScreen({
    super.key,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.imagePath,
  });

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children:[
            Text(widget.title),
            IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
              color: _isFavorited ? Colors.red : null,
            ),
          ),
          ],
      ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.subTitle,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.description),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.wb_sunny, color: Colors.yellow),
                    SizedBox(height: 4),
                    Text('Pogoda'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.beach_access, color: Colors.orange),
                    SizedBox(height: 4),
                    Text('Atrakcje'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.restaurant, color: Colors.red),
                    SizedBox(height: 4),
                    Text('Jedzenie'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}