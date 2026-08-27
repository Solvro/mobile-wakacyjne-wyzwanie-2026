import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); //uruchomienie apki
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override //funkcja build jest jak narysuj co ma być teraz na ekranie
  Widget build(BuildContext context) {
    //MaterialApp to widget który jest jak kontener na całą aplikację
    return MaterialApp(
      title: 'Nowa Zelandia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 27, 122, 40)),
      ),
      home: const ListScreen(),  // wskazanie na to że dream ekran ma być wyświetlany jako pierwszy
    );
  }
}

class DreamPlaceScreen extends StatefulWidget {

  final String title;
  final String imagePath;
  final String description;
  
  const DreamPlaceScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
  });

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool _isFavorited = false;

  // Funkcja, która przełącza stan i odświeża ekran
  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited; // Zmienia fałsz na prawdę i odwrotnie
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 109, 25),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(255, 137, 22, 141),
        foregroundColor: const Color.fromARGB(255, 182, 228, 186),

        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
            )
          )
        ]
      ),
      body: Column(
        children: [
          Image.asset(
            widget.imagePath,
            fit: BoxFit.cover
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Kilka info przed wyjazdem',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 199, 149, 192),
                  ),
                ),

                const SizedBox(height: 8),

                 Text(
                  widget.description,
                  style: TextStyle(
                    color: Color.fromARGB(255, 233, 218, 231),
                    ),                
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Column(
                children: [
                  Icon(Icons.landscape, color: Color.fromARGB(226, 56, 238, 32), size: 30),
                  SizedBox(height: 4),
                  Text('Góry',
                    style: TextStyle(
                      color: Color.fromARGB(226, 56, 238, 32),
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Icon(Icons.hiking, color: Color.fromARGB(255, 255, 104, 4), size: 30),
                  SizedBox(height: 4),
                  Text('Szlaki',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 104, 4),
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Icon(Icons.beach_access, color: Color.fromARGB(255, 240, 226, 29), size: 30),
                  SizedBox(height: 4),
                  Text('Plaże',
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 226, 29),
                    ),
                  ),
                ],
              ),
            ],
          ),         //wyświetlen
        ],
      )
    );
  }
}

class ListScreen extends StatelessWidget{
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 186, 197, 206),
      appBar: AppBar(title: Text('Wymarzone kierunki'),
        backgroundColor: const Color.fromARGB(255, 119, 109, 202),
        foregroundColor: const Color.fromARGB(255, 207, 205, 216),),
      body: ListView(
        children: [
          ListTile(
            leading: Image.asset('assets/nowa_zelandia.jpg', width: 50, height: 50, fit: BoxFit.cover),
            title: const Text('Nowa Zelandia'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DreamPlaceScreen(
                    title: 'Nowa Zelandia',
                    imagePath: 'assets/nowa_zelandia.jpg',
                    description: 'Pogoda może zmieniać się tutaj błyskawicznie, dlatego ubiór "na cebulkę" i dobra kurtka przeciwdeszczowa to podstawa o każdej porze roku. Pamiętaj też, że obowiązuje tu ruch lewostronny, a na lotnisku spotkasz się z niezwykle surowymi kontrolami bioasekuracyjnymi, które surowo zabraniają wwożenia wielu produktów spożywczych czy chociażby brudnego sprzętu trekkingowego.',
                  ),
                ),
              );
            },
          ),

          ListTile(
            leading: Image.asset('assets/norwegia.jpg', width: 50, height: 50, fit: BoxFit.cover),
            title: const Text('Norwegia'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DreamPlaceScreen(
                    title: 'Norwegia',
                    imagePath: 'assets/norwegia.jpg',
                    description: 'To kraj niemal całkowicie bezgotówkowy, dlatego wszędzie bez problemu zapłacisz kartą lub telefonem, a lokalne banknoty są używane niezwykle rzadko. Ze względu na wysokie koszty życia, jeśli podróżujesz budżetowo, warto zaplanować przygotowywanie posiłków we własnym zakresie oraz rezerwację noclegów ze sporym wyprzedzeniem.',
                  ),
                ),
              );
            },
          ),

          ListTile(
            leading: Image.asset('assets/korea_poludniowa.jpg', width: 50, height: 50, fit: BoxFit.cover),
            title: const Text('Korea Południowa'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DreamPlaceScreen(
                    title: 'Korea Południowa',
                    imagePath: 'assets/korea_poludniowa.jpg',
                    description: 'Ze względów bezpieczeństwa narodowego Mapy Google działają tu w bardzo ograniczonym zakresie (nie wyznaczają tras pieszych), więc przed wyjazdem koniecznie zainstaluj lokalne aplikacje, takie jak Naver Map lub KakaoMap. Do wygodnego korzystania z transportu publicznego i robienia drobnych zakupów w sklepach spożywczych, najlepiej od razu po przylocie wyrobić i doładować popularną kartę Tmoney.',
                  ),
                ),
              );
            },
          ),

          ListTile(
            leading: Image.asset('assets/holandia.jpg', width: 50, height: 50, fit: BoxFit.cover),
            title: const Text('Holandia'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DreamPlaceScreen(
                    title: 'Holandia',
                    imagePath: 'assets/holandia.jpg',
                    description: 'Rowerzyści mają w tym kraju bezwzględne pierwszeństwo na ścieżkach rowerowych, dlatego jako pieszy musisz zachować szczególną ostrożność, by przypadkiem nie wejść im pod koła. Pogoda bywa tu bardzo wietrzna i deszczowa, więc zamiast tradycyjnego parasola (który łatwo połamać na wietrze) znacznie lepiej sprawdzi się solidny płaszcz przeciwdeszczowy.',
                  ),
                ),
              );
            },
          ),

          ListTile(
            leading: Image.asset('assets/andora.jpg', width: 50, height: 50, fit: BoxFit.cover),
            title: const Text('Andora'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DreamPlaceScreen(
                    title: 'Andora',
                    imagePath: 'assets/andora.jpg',
                    description: 'Ten mały górski kraj nie należy do Unii Europejskiej ani strefy Schengen (choć obowiązującą walutą jest euro), co oznacza, że standardowe pakiety internetowe nie działają, a opłaty za roaming komórkowy mogą być gigantyczne. Ponieważ Andora leży głęboko w Pirenejach i nie posiada własnego lotniska ani stacji kolejowej, dotarcie na miejsce wymaga wynajęcia auta lub transferu autobusowego z sąsiedniej Hiszpanii lub Francji.',
                  ),
                ),
              );
            },
          )
        ],
      )
    );
  }
}