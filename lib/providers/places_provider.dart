import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
  }, version: 1);

  return db;
}

class PlacesProviderNotifier extends StateNotifier<List<Place>> {
  PlacesProviderNotifier() : super([]);

  Future<void> loadData() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');

    final places = data
        .map((row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
                address: row['address'] as String,
                latitude: row['lat'] as double,
                longitude: row['lng'] as double)))
        .toList();

    state = places;
  }

  void addToList(Place item) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(item.image.path);
    final copiedImage = await item.image.copy('${appDir.path}/$fileName');

    final newPlace =
        Place(title: item.title, image: copiedImage, location: item.location);

    final db = await _getDatabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });

    state = [newPlace, ...state];
  }
}

final placesProvider =
    StateNotifierProvider<PlacesProviderNotifier, List<Place>>((ref) {
  return PlacesProviderNotifier();
});
