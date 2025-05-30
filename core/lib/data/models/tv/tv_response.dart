import 'package:core/data/models/tv/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable {
  final List<TvModel> results;

  const TvResponse({
    required this.results,
  });

  factory TvResponse.fromJson(Map<String, dynamic> json) =>
      TvResponse(
        results:
            List<TvModel>.from(json["results"].map((x) => TvModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [results];
}
