import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/presentation/bloc/tv/airing_today/tv_airing_today_bloc.dart';
import 'package:core/presentation/bloc/tv/popular/tv_popular_bloc.dart';
import 'package:core/presentation/bloc/tv/top_rated/tv_top_rated_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({super.key});
  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context
          .read<TvAiringTodayBloc>()
          .add(TvAiringTodayFetch());
      context.read<TvPopularBloc>().add(TvPopularFetch());
      context.read<TvTopRatedBloc>().add(TvTopRatedFetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              selected: true,
              selectedColor: kMikadoYellow,
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, watchlistRoute);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton - TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, tvSearchRoute);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Airing Today',
                onTap: () => Navigator.pushNamed(context, tvAiringTodayRoute),
              ),
              BlocBuilder<TvAiringTodayBloc, TvAiringTodayState>(
                builder: (context, state) {
                  if (state is TvAiringTodayLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvAiringTodayHasData) {
                    final result = state.results;
                    return TvList(result);
                  } else if (state is TvAiringTodayError) {
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
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, tvPopularRoute),
              ),
              BlocBuilder<TvPopularBloc, TvPopularState>(
                builder: (context, state) {
                  if (state is TvPopularLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvPopularHasData) {
                    final result = state.results;
                    return TvList(result);
                  } else if (state is TvPopularError) {
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
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, tvTopRatedRoute),
              ),
              BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
                builder: (context, state) {
                  if (state is TvTopRatedLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvTopRatedHasData) {
                    final result = state.results;
                    return TvList(result);
                  } else if (state is TvTopRatedError) {
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

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvData;

  const TvList(this.tvData, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvData[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tvDetailRoute,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvData.length,
      ),
    );
  }
}
