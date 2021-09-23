import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallo_flutter/models/aquadex_fish.dart';
import 'package:wallo_flutter/redux/actions/achievement_actions.dart';
import 'package:wallo_flutter/redux/actions/messenger_actions.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/services/fish_service.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';

ThunkAction analyzedPictureAction(String filePath, List<AquadexFish> aquadex) {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      try {
        analyseFishRequest(filePath, aquadex).then((fishes) {
          if (fishes.isEmpty) {
            store.dispatch(new RequestFailedAction("Aucun poisson trouvé"));
          } else {
            store.dispatch(new SetAnalyzedFishAction(fishes));
            fishes.forEach(
              (fish) => store.dispatch(
                unlockFishAction(fish.id),
              ),
            );
            store.dispatch(new RequestSucceedAction());
          }
        }, onError: (errorMessage) {
          store.dispatch(new RequestFailedAction(errorMessage));
        });
      } on Exception {
        store.dispatch(new RequestFailedAction("Une erreur s'est produite"));
      }
    });
  };
}

ThunkAction<AppState> unlockFishAction(String fishId) {
  return (Store<AppState> store) async {
    new Future(() async {
      try {
        final userId = store.state.userState.user.id;
        getUnlockedFishRequest(fishId, userId).then((aquadexData) {
          store.dispatch(new SetUserAquadexAction(aquadexData.aquadex));
          if (aquadexData.newAchievement != null) {
            store.dispatch(
                new SetNewAchievementAction(aquadexData.newAchievement));
            store.dispatch(SetUserLevelAction(aquadexData.newAchievement.game));
            store.dispatch(
              RequestSucceedActionWithMessage(
                aquadexData.newAchievement.message,
              ),
            );
          }
        }, onError: (errorMessage) {
          store.dispatch(new RequestFailedAction(errorMessage));
        });
      } on Exception {
        store.dispatch(
          new RequestFailedAction(
              "Une erreur s'est produite lors de l'obtention du poisson dans l'aquarium"),
        );
      }
    });
  };
}

ThunkAction clearAnalyzedFishThunkAction() {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new ClearAnalyzedFishAction());
    });
  };
}

ThunkAction getAquadexAction() {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      try {
        getAquadexRequest().then((fishes) {
          if (fishes.isEmpty) {
            store.dispatch(new RequestFailedAction("Aucun poisson"));
          } else {
            store.dispatch(new SetAquadexFishAction(fishes));
            store.dispatch(new RequestSucceedAction());
          }
        }, onError: (errorMessage) {
          store.dispatch(new RequestFailedAction(errorMessage));
        });
      } on Exception {
        store.dispatch(new RequestFailedAction("Une erreur s'est produite"));
      }
    });
  };
}

class ClearAnalyzedFishAction {
  ClearAnalyzedFishAction();
}

class SetAnalyzedFishAction {
  List<AquadexFish> fishes;

  SetAnalyzedFishAction(this.fishes);
}

class SetAquadexFishAction {
  List<AquadexFish> fishes;

  SetAquadexFishAction(this.fishes);
}
