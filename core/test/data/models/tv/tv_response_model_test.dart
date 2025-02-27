import 'dart:convert';

import 'package:core/data/models/tv/tv_model.dart';
import 'package:core/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['en'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: DateTime(2025, 2, 26),
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvResponseModel = TvResponse(results: [tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(
          'dummy_data/airing_today_tv.json',
        ),
      );
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": 'backdropPath',
            "genre_ids": [1,2,3],
            "id": 1,
            "origin_country": ['en'],
            "original_language": 'originalLanguage',
            "original_name": 'originalName',
            "overview": 'overview',
            "popularity": 1,
            "poster_path": 'posterPath',
            "first_air_date": "2025-02-26",
            "name": 'name',
            "vote_average": 1,
            "vote_count": 1,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
