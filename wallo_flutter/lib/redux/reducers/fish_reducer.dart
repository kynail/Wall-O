import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/fish_actions.dart';
import 'package:wallo_flutter/redux/state/fish_state.dart';

final fishReducer = combineReducers<FishState>([
  TypedReducer<FishState, SetAnalyzedFishAction>(_setAnalyzedFish),
  TypedReducer<FishState, SetAquadexFishAction>(_setAquadexFish),
  TypedReducer<FishState, ClearAnalyzedFishAction>(_clearAnalyzedFish),
]);

FishState _setAnalyzedFish(FishState state, SetAnalyzedFishAction action) {
  return state.copyWith(
    analysedFish: action.fishes,
  );
}

FishState _setAquadexFish(FishState state, SetAquadexFishAction action) {
  return state.copyWith(
    aquadex: action.fishes,
  );
}

FishState _clearAnalyzedFish(FishState state, ClearAnalyzedFishAction action) {
  return state.copyWith(analysedFish: []);
}
