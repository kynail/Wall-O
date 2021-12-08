import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/aquadex_fish.dart';

@immutable
class FishState {
  final List<AquadexFish> analysedFish;
  final List<AquadexFish> aquadex;

  FishState({
    @required this.analysedFish,
    @required this.aquadex,
  });

  factory FishState.initial() => new FishState(
        analysedFish: null,
        aquadex: null,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FishState &&
        listEquals(other.analysedFish, analysedFish) &&
        listEquals(other.aquadex, aquadex);
  }

  FishState copyWith({
    List<AquadexFish> analysedFish,
    List<AquadexFish> aquadex,
  }) {
    return FishState(
      analysedFish: analysedFish ?? this.analysedFish,
      aquadex: aquadex ?? this.aquadex,
    );
  }

  @override
  String toString() =>
      'FishState(analysedFish: $analysedFish, aquadex: $aquadex)';

  @override
  int get hashCode => analysedFish.hashCode ^ aquadex.hashCode;
}
