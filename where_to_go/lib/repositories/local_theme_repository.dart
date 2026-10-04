import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class LocalThemeRepository {
  static const _themeKey = "theme_mode"; // nazwa klucza w repo

  Future<ThemeMode?> getThemeMode() async {
    // odczytanie zapisanego motywu
    final prefs = await SharedPreferences.getInstance(); // pobieranie bazy danych klucz wartosc
    final themeString = prefs.getString(_themeKey); // sprawdzanie wartosci klucza _themeKey

    if (themeString == null) return null; // jesli nic nie wybrane to null (pierwsze uruchomienie)

    return ThemeMode.values.firstWhere(
      // wyszukiwanie jaki motyw jest zapisany i odczyt
      (e) => e.name == themeString, // przejscie po elementach i sprawdzenie ktory motyw jest wybrany
      orElse: () => ThemeMode.system, // jak cos poszlo nie tak, bledne dane to zwracamy default - system
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    // ustawienie motywu
    final prefs = await SharedPreferences.getInstance(); // polaczenie z baza danych klucz wartosc
    await prefs.setString(_themeKey, mode.name); // podpisane klucza odpowiednim motywem
  }
}
