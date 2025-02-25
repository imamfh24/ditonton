import 'package:core/core.dart';

import '../db/database_helper.dart';
import '../../models/watchlist_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(WatchlistTable movie);
  Future<String> removeWatchlist(WatchlistTable movie);
  Future<WatchlistTable?> getTvById(int id);
  Future<List<WatchlistTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistTable tv) async {
    try {
      await databaseHelper.insertWatchlist(tv, 2);
      return 'Added to Tv Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable tv) async {
    try {
      await databaseHelper.removeWatchlist(tv, 2);
      return 'Removed from Tv Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchlistTable?> getTvById(int id) async {
    final result = await databaseHelper.getWatchlistById(id, 2);
    if (result != null) {
      return WatchlistTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => WatchlistTable.fromMap(data)).toList();
  }
}
