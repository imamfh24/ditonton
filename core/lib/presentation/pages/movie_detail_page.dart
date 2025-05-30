import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/detail/recommendation/movie_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/movie/detail/watchlist/movie_detail_watchlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<MovieDetailWatchlistCubit>().loadStatus(widget.id);
      context.read<MovieDetailBloc>().add(MovieDetailFetch(widget.id));
      context
          .read<MovieDetailRecommendationBloc>()
          .add(FetchMovieDetailRecommendationEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            final movie = state.result;
            return SafeArea(
              child: DetailContent(movie),
            );
          } else if (state is MovieDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;

  const DetailContent(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.title, style: kHeading5),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kMikadoYellow,
                              foregroundColor: kRichBlack,
                              iconColor: kRichBlack,
                            ),
                            onPressed: () {
                              final isAddedWatchlist = context
                                  .read<MovieDetailWatchlistCubit>()
                                  .state
                                  .isAddedToWatchlist;
                              if (isAddedWatchlist) {
                                context
                                    .read<MovieDetailWatchlistCubit>()
                                    .removeWatchlist(movie);
                              } else {
                                context
                                    .read<MovieDetailWatchlistCubit>()
                                    .addWatchlist(movie);
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isAddedWatchlist
                                        ? 'Removed from watchlist'
                                        : 'Added to watchlist',
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  context
                                          .watch<MovieDetailWatchlistCubit>()
                                          .state
                                          .isAddedToWatchlist
                                      ? Icons.check
                                      : Icons.add,
                                ),
                                Text('Watchlist'),
                              ],
                            ),
                          ),
                          Text(_showGenres(movie.genres)),
                          Text(_showDuration(movie.runtime)),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: movie.voteAverage / 2,
                                itemCount: 5,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: kMikadoYellow,
                                ),
                                itemSize: 24,
                              ),
                              Text('${movie.voteAverage / 2}')
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('Overview', style: kHeading6),
                          Text(movie.overview),
                          SizedBox(height: 16),
                          Text('Recommendations', style: kHeading6),
                          BlocBuilder<MovieDetailRecommendationBloc,
                              MovieDetailRecommendationState>(
                            builder: (context, state) {
                              if (state is MovieDetailRecommendationLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state
                                  is MovieDetailRecommendationError) {
                                return Text(state.message);
                              } else if (state
                                  is MovieDetailRecommendationHasData) {
                                final recommendations = state.recommendations;

                                if (recommendations.isEmpty) {
                                  return Text("No recommendations available.");
                                }

                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: recommendations.length,
                                    itemBuilder: (context, index) {
                                      final movie = recommendations[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              movieDetailRoute,
                                              arguments: movie.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}

String _showGenres(List<Genre> genres) {
  String result = '';
  for (var genre in genres) {
    result += '${genre.name}, ';
  }

  if (result.isEmpty) {
    return result;
  }

  return result.substring(0, result.length - 2);
}

String _showDuration(int runtime) {
  final int hours = runtime ~/ 60;
  final int minutes = runtime % 60;

  if (hours > 0) {
    return '${hours}h ${minutes}m';
  } else {
    return '${minutes}m';
  }
}
