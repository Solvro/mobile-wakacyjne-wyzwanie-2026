import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const Color primaryDarkBlue = Color.fromARGB(255, 32, 25, 112);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wymarzone Miejsca',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryDarkBlue),
        useMaterial3: true,
      ),
      home: const PlacesListScreen(),
    );
  }
}

class Place {
  final String title;
  final String subtitle;
  final String imagePath;
  final String description;

  const Place({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.description,
  });
}

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  final List<Place> places = const [
    Place(
      title: 'Lofoty, Norwegia',
      subtitle: 'Arktyczne krajobrazy i fiordy',
      imagePath: 'assets/images/norway.jpg',
      description:
          'Kraina majestatycznych fiordów, malowniczych czerwonych domków rybackich i spektakularnych zorzy polarnych.',
    ),
    Place(
      title: 'Santorini, Grecja',
      subtitle: 'Białe miasteczka i błękitne kopuły',
      imagePath: 'assets/images/santorini.jpg',
      description:
          'Słynna wulkaniczna wyspa na Morzu Egejskim z zapierającymi dech w piersiach zachodami słońca.',
    ),
    Place(
      title: 'Kioto, Japonia',
      subtitle: 'Tradycja i kwitnące wiśnie',
      imagePath: 'assets/images/kyoto.jpg',
      description:
          'Dawna stolica Japonii pełna zabytkowych świątyń, bambusowych lasów i tradycyjnych ogrodów.',
    ),
    Place(
      title: 'Amalfi, Włochy',
      subtitle: 'Kolorowe klify i Morze Tyrreńskie',
      imagePath: 'assets/images/amalfi.jpg',
      description:
          'Malownicze wybrzeże z urokliwymi miasteczkami zawieszonymi na skalistych zboczach.',
    ),
    Place(
      title: 'Banff, Kanada',
      subtitle: 'Góry Skaliste i turkusowe jeziora',
      imagePath: 'assets/images/banff.jpg',
      description:
          'Najstarszy park narodowy Kanady z krystalicznie czystymi jeziorami Moraine i Louise.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text('Wymarzone Miejsca'),
        backgroundColor: primaryDarkBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                elevation: 1.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: Image.asset(
                        place.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    place.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  subtitle: Text(
                    place.subtitle,
                    style: const TextStyle(color: Color(0xFF64748B)),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: primaryDarkBlue,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DreamPlaceScreen(place: place),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class DreamPlaceScreen extends StatefulWidget {
  final Place place;

  const DreamPlaceScreen({super.key, required this.place});

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
    final place = widget.place;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: Text(place.title),
        backgroundColor: primaryDarkBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
              color: _isFavorited ? Colors.redAccent : Colors.white,
            ),
            tooltip: _isFavorited ? 'Usuń z ulubionych' : 'Dodaj do ulubionych',
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    place.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.subtitle,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        place.description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF475569),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(indent: 20, endIndent: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _FeatureItem(icon: Icons.landscape, label: 'Widoki'),
                      _FeatureItem(icon: Icons.camera_alt, label: 'Zdjęcia'),
                      _FeatureItem(icon: Icons.restaurant, label: 'Jedzenie'),
                      _FeatureItem(icon: Icons.explore, label: 'Przygoda'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: primaryDarkBlue, size: 28),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
          ),
        ),
      ],
    );
  }
}