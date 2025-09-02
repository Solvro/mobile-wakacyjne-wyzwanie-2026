import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../gen/assets.gen.dart";
import "place.dart";

part "place_provider.g.dart";

final _places = [
  Place(
      id: 1,
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      id: 2,
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      id: 3,
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      id: 4,
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      id: 5,
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      id: 6,
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      id: 7,
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  Place(
      id: 8,
      title: "Kętrzyn",
      photo: Assets.images.image,
      description:
          "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() {
    return _places;
  }

  void toggleFavorite(int id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }
}
