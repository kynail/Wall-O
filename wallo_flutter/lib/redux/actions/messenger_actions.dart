class RequestFailedAction {
  final String errorMessage;

  RequestFailedAction(this.errorMessage);
}

class RequestSucceedActionWithMessage {
  final String successMessage;

  RequestSucceedActionWithMessage(this.successMessage);
}

class RequestSucceedAction {
  RequestSucceedAction();
}

class StartLoadingAction {
  StartLoadingAction();
}

class StopLoadingAction {
  StopLoadingAction();
}

class PlayConfettiAction {
  PlayConfettiAction();
}

class StopConfettiAction {
  StopConfettiAction();
}

class MarkSnackbarHasHandledAction {
  MarkSnackbarHasHandledAction();
}
