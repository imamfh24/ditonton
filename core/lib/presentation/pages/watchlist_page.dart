import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/home_tv_page.dart';
import 'package:core/presentation/provider/watchlist_notifier.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchlistNotifier>()
        ..fetchWatchlistMovies()
        ..fetchWatchlistTv(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistNotifier>()
      ..fetchWatchlistMovies()
      ..fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Movies',
                style: kHeading6,
              ),
              Consumer<WatchlistNotifier>(
                builder: (context, data, child) {
                  if (data.watchlistState == RequestState.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.watchlistState == RequestState.loaded) {
                    if (data.watchlistMovies.isEmpty) {
                      return Center(
                        child: Text('No Data'),
                      );
                    }
                    return MovieList(data.watchlistMovies);
                  } else {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              ),
              Text(
                'TV',
                style: kHeading6,
              ),
              Consumer<WatchlistNotifier>(
                builder: (context, data, child) {
                  if (data.watchlistTvState == RequestState.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.watchlistTvState == RequestState.loaded) {
                    if (data.watchlistTv.isEmpty) {
                      return Center(
                        child: Text('No Data'),
                      );
                    }
                    return TvList(data.watchlistTv);
                  } else {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
