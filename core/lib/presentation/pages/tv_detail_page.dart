import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/presentation/bloc/tv/detail/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv/detail/watchlist/tv_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/tv/detail/recommendation/tv_detail_recommendation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvDetailPage extends StatefulWidget {
  final int id;
  const TvDetailPage({super.key, required this.id});

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<TvDetailWatchlistCubit>().loadStatus(widget.id);
      context.read<TvDetailBloc>().add(TvDetailFetch(widget.id));
      context
          .read<TvDetailRecommendationBloc>()
          .add(FetchTvDetailRecommendationEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final tv = state.result;
            return SafeArea(
              child: DetailContent(tv),
            );
          } else if (state is TvDetailError) {
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
  final TvDetail tv;

  const DetailContent(this.tv, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                          Text(tv.name, style: kHeading5),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kMikadoYellow,
                              foregroundColor: kRichBlack,
                              iconColor: kRichBlack,
                            ),
                            onPressed: () {
                              final isAddedWatchlist = context
                                  .read<TvDetailWatchlistCubit>()
                                  .state
                                  .isAddedToWatchlist;
                              if (isAddedWatchlist) {
                                context
                                    .read<TvDetailWatchlistCubit>()
                                    .removeWatchlist(tv);
                              } else {
                                context
                                    .read<TvDetailWatchlistCubit>()
                                    .addWatchlist(tv);
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
                                          .watch<TvDetailWatchlistCubit>()
                                          .state
                                          .isAddedToWatchlist
                                      ? Icons.check
                                      : Icons.add,
                                ),
                                Text('Watchlist'),
                              ],
                            ),
                          ),
                          Text(_showGenres(tv.genres)),
                          // Text(_showDuration(tv.)),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: tv.voteAverage / 2,
                                itemCount: 5,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: kMikadoYellow,
                                ),
                                itemSize: 24,
                              ),
                              Text('${tv.voteAverage / 2}')
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('Overview', style: kHeading6),
                          Text(tv.overview),
                          SizedBox(height: 16),
                          Text('Recommendations', style: kHeading6),
                          BlocBuilder<TvDetailRecommendationBloc,
                              TvDetailRecommendationState>(
                            builder: (context, state) {
                              if (state is TvDetailRecommendationLoading) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (state
                                  is TvDetailRecommendationError) {
                                return Text(state.message);
                              } else if (state
                                  is TvDetailRecommendationHasData) {
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
                                      final tv = recommendations[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              tvDetailRoute,
                                              arguments: tv.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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