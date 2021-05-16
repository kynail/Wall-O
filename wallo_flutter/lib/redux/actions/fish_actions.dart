import 'dart:io';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallo_flutter/models/Fish.dart';
import 'package:wallo_flutter/models/aquadex_fish.dart';
import 'package:wallo_flutter/redux/actions/messenger_actions.dart';
import 'package:wallo_flutter/redux/services/fish_service.dart';
import 'package:wallo_flutter/route_generator.dart';

ThunkAction analyzedPictureAction(String filePath) {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      try {
        analyseFishRequest(filePath).then((fishes) {
          if (fishes.isEmpty) {
            store.dispatch(new RequestFailedAction("Aucun poisson trouvé"));
          } else {
            store.dispatch(new SetAnalyzedFishAction(fishes));
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
  List<Fish> fishes;

  SetAnalyzedFishAction(this.fishes);
}

class SetAquadexFishAction {
  List<AquadexFish> fishes;

  SetAquadexFishAction(this.fishes);
}
