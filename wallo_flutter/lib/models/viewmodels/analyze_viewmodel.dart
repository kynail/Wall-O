import 'package:redux/redux.dart';
import 'package:wallo_flutter/models/aquadex_fish.dart';
import 'package:wallo_flutter/redux/actions/fish_actions.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';

class AnalyzeViewModel {
  final List<AquadexFish> analyzedFish;
  final Function(String filePath) analyzePicture;
  final bool isLoading;
  final Function() clearAnalyzedFish;

  AnalyzeViewModel({
    this.analyzedFish,
    this.analyzePicture,
    this.isLoading,
    this.clearAnalyzedFish,
  });

  static AnalyzeViewModel fromStore(Store<AppState> store) {
    return AnalyzeViewModel(
      isLoading: store.state.messengerState.isLoading,
      analyzedFish: store.state.fishState.analysedFish,
      analyzePicture: (picture) => store.dispatch(
        analyzedPictureAction(
          picture,
          store.state.fishState.aquadex,
        ),
      ),
      clearAnalyzedFish: () {
        store.dispatch(clearAnalyzedFishThunkAction());
      },
    );
  }
}
