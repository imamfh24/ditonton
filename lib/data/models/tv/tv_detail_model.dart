import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailModel extends Equatable {
  int id;
  bool? adult;
  String? backdropPath;
  List<GenreModel>? genres;
  String? name;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  TvDetailModel({
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

  factory TvDetailModel.fromRawJson(String str) =>
      TvDetailModel.fromJson(json.decode(str));

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
        id: json["id"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        name: json["name"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  

  TvDetail toEntity() {
    return TvDetail(
      id: id,
      adult: adult,
      backdropPath: backdropPath,
      genres: genres?.map((genre) => genre.toEntity()).toList(),
      name: name,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

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
