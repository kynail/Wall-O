class RequestFailedAction {
  final String errorMessage;

  RequestFailedAction(this.errorMessage);
}

class RequestSucceedAction {
  final String successMessage;

  RequestSucceedAction(this.successMessage);
}

class StartLoadingAction {
  StartLoadingAction();
}

class MarkSnackbarHasHandledAction {
  MarkSnackbarHasHandledAction();
}
