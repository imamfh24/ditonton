import 'package:core/utils/exception.dart';

import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/watchlist_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(WatchlistTable tv);
  Future<String> removeWatchlist(WatchlistTable tv);
  Future<WatchlistTable?> getTvById(int id);
  Future<List<WatchlistTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;
  int watchlistType = 2;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistTable tv) async {
    try {
      await databaseHelper.insertWatchlist(tv, watchlistType);
      return 'Added to Tv Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable tv) async {
    try {
      await databaseHelper.removeWatchlist(tv, watchlistType);
      return 'Removed from Tv Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchlistTable?> getTvById(int id) async {
    final result = await databaseHelper.getWatchlistById(id, watchlistType);
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
