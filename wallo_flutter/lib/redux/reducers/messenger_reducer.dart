import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/messenger_actions.dart';
import 'package:wallo_flutter/redux/state/messenger_state.dart';

final messengerReducer = combineReducers<MessengerState>([
  TypedReducer<MessengerState, RequestSucceedActionWithMessage>(
      _requestSucceedWithMessage),
  TypedReducer<MessengerState, RequestSucceedAction>(_requestSucceed),
  TypedReducer<MessengerState, RequestFailedAction>(_requestFailed),
  TypedReducer<MessengerState, StartLoadingAction>(_startLoading),
  TypedReducer<MessengerState, PlayConfettiAction>(_playConfetti),
  TypedReducer<MessengerState, StopConfettiAction>(_stopConfetti),
  TypedReducer<MessengerState, MarkSnackbarHasHandledAction>(
      _markSnackbarHasHandled),
]);

MessengerState _requestSucceedWithMessage(
    MessengerState state, RequestSucceedActionWithMessage action) {
  return state.copyWith(
      showSnackbar: true,
      isLoading: false,
      isError: false,
      errorMessage: null,
      successMessage: action.successMessage);
}

MessengerState _requestSucceed(
    MessengerState state, RequestSucceedAction action) {
  return state.copyWith(
      showSnackbar: false,
      isLoading: false,
      isError: false,
      errorMessage: null,
      successMessage: null);
}

MessengerState _requestFailed(
    MessengerState state, RequestFailedAction action) {
  return state.copyWith(
      showSnackbar: true,
      isLoading: false,
      isError: true,
      errorMessage: action.errorMessage,
      successMessage: null);
}

MessengerState _startLoading(MessengerState state, StartLoadingAction action) {
  return state.copyWith(
      showSnackbar: false,
      isLoading: true,
      isError: false,
      errorMessage: null,
      successMessage: null);
}

MessengerState _playConfetti(MessengerState state, PlayConfettiAction action) {
  return state.copyWith(showConfetti: true);
}

MessengerState _stopConfetti(MessengerState state, StopConfettiAction action) {
  return state.copyWith(showConfetti: false);
}

MessengerState _markSnackbarHasHandled(
    MessengerState state, MarkSnackbarHasHandledAction action) {
  return state.copyWith(
      showSnackbar: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      successMessage: null);
}
