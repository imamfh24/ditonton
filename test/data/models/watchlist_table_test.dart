import 'package:flutter_test/flutter_test.dart';
import 'package:core/data/models/watchlist_table.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  

  test('should convert WatchlistTable to JSON map', () {
    final result = WatchlistTable.fromMovieEntity(testMovieDetail).toJson();
    
    expect(result, testWatchlistTable.toJson());
  });

  test('should create WatchlistTable from JSON map', () {

    final result = WatchlistTable.fromMap(testWatchlistMap);
    expect(result, testWatchlistTable);
  });

  test('should convert WatchlistTable to Movie entity', () {
    final result = testWatchlistTable.toEntity();
    expect(result.id, testWatchlistTable.id);
    expect(result.title, testWatchlistTable.title);
    expect(result.posterPath, testWatchlistTable.posterPath);
    expect(result.overview, testWatchlistTable.overview);
  });

  test('should convert WatchlistTable to Tv entity', () {
    final result = testWatchlistTvTable.toTvEntity();
    expect(result.id, testWatchlistTvTable.id);
    expect(result.name, testWatchlistTvTable.title);
    expect(result.posterPath, testWatchlistTvTable.posterPath);
    expect(result.overview, testWatchlistTvTable.overview);
  });
}