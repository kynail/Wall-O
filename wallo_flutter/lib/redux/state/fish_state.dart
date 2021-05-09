import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/Fish.dart';

@immutable
class FishState {
  final List<Fish> analysedFish;
  // final List<Fish> aquadex;

  FishState({
    @required this.analysedFish,
  });

  factory FishState.initial() => new FishState(analysedFish: null);

  FishState copyWith({List<Fish> analysedFish}) {
    return FishState(analysedFish: analysedFish ?? this.analysedFish);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FishState && analysedFish == other.analysedFish;

  @override
  String toString() {
    return 'FishState: {Analyzed fish = $analysedFish}';
  }

  @override
  int get hashCode => analysedFish.hashCode;
}
