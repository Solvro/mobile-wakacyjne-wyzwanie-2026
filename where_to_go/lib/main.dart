import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "gen/assets.gen.dart";

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: MyApp())));
}

class Place {
  final String title;
  final String description;
  final AssetGenImage photo;

  Place({required this.title, required this.description, required this.photo});
}

final places = [
  Place(
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Moje ulubione miejsca:3"),
        ),
        body: ListView(
            padding: const EdgeInsets.all(8),
            children: places
                .map((place) => Card(
                        child: ListTile(
                      title: Text(place.title),
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute<Widget>(
                            builder: (context) => DreamPlaceScreen(place.title, place.description, place.photo)))
                      },
                    )))
                .toList()));
  }
}

class DreamPlaceScreen extends HookWidget {
  final String title;
  final String description;
  final AssetGenImage photo;

  const DreamPlaceScreen(this.title, this.description, this.photo);

  @override
  Widget build(BuildContext context) {
    final isFavorited = useState(false);

    return Scaffold(
      body: Column(
        children: [
          photo.image(fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsetsGeometry.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600), title),
                const SizedBox(height: 8),
                Text(description)
              ],
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Icons.beach_access, Icons.satellite, Icons.wifi, Icons.ballot]
                  .map((icon) => Column(
                        children: [Icon(icon)],
                      ))
                  .toList())
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 162, 236, 200),
      appBar: AppBar(title: Text(title), actions: [
        IconButton(
            onPressed: () => {isFavorited.value = !isFavorited.value},
            icon: Icon(isFavorited.value ? Icons.favorite : Icons.favorite_border,
                color: isFavorited.value ? Colors.red : null))
      ]),
    );
  }
}
