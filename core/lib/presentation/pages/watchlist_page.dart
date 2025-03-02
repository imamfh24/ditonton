import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/home_tv_page.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:core/utils/watch_type.dart';
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
    Future.microtask(() {
      if (!mounted) return;
      context.read<WatchlistBloc>()
        ..add(FetchWatchlist(WatchType.movie))
        ..add(FetchWatchlist(WatchType.tv));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistBloc>()
      ..add(FetchWatchlist(WatchType.movie))
      ..add(FetchWatchlist(WatchType.tv));
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
              BlocBuilder<WatchlistBloc, WatchlistState>(
                builder: (context, state) {
                  if (state is WatchlistLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WatchlistHasData<Movie>) {
                    if (state.result.isEmpty) {
                      return Center(
                        child: Text('No Data'),
                      );
                    }
                    return MovieList(state.result);
                  } else if (state is WatchlistError) {
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
              Text(
                'TV',
                style: kHeading6,
              ),
              BlocBuilder<WatchlistBloc, WatchlistState>(
                builder: (context, state) {
                  if (state is WatchlistLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WatchlistHasData<Tv>) {
                    if (state.result.isEmpty) {
                      return Center(
                        child: Text('No Data'),
                      );
                    }
                    return TvList(state.result);
                  } else if (state is WatchlistError) {
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
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
