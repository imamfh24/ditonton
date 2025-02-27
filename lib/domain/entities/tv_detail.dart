import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/genre.dart';

class TvDetail extends Equatable {
  int id;
  bool? adult;
  String? backdropPath;
  List<Genre>? genres;
  String? name;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;
  TvDetail({
    required this.id,
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        id,
        adult,
        backdropPath,
        genres,
        name,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
