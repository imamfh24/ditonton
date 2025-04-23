import 'package:core/presentation/bloc/movie/watchlist/movie_watchlist_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist/tv_watchlist_bloc.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/home_tv_page.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    _fetchingWatchlist();
  }

  void _fetchingWatchlist() {
    Future.microtask(() {
      if (!mounted) return;
      context.read<MovieWatchlistBloc>().add(MovieFetchWatchlist());
      context.read<TvWatchlistBloc>().add(TvFetchWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    _fetchingWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Movies',
                    style: kHeading6,
                  ),
                  BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
                    builder: (context, state) {
                      if (state is MovieWatchlistLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MovieWatchlistHasData) {
                        if (state.result.isEmpty) {
                          return Center(
                            child: Text('No Data'),
                          );
                        }
                        return MovieList(state.result);
                      } else if (state is MovieWatchlistError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'TV',
                    style: kHeading6,
                  ),
                  BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
                    builder: (context, state) {
                      if (state is TvWatchlistLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TvWatchlistHasData) {
                        if (state.result.isEmpty) {
                          return Center(
                            child: Text('No Data'),
                          );
                        }
                        return TvList(state.result);
                      } else if (state is TvWatchlistError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
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
