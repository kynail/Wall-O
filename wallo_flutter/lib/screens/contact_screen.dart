// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:wallo_flutter/models/viewmodels/contact_viewmodel.dart';
// import 'package:wallo_flutter/redux/state/app_state.dart';

// import 'contact.dart';

// class ContactScreen extends StatefulWidget {
//   final Function() onCloseArrowTap;
//   ContactScreen({
//     Key key,
//     @required this.onCloseArrowTap,
//   }) : super(key: key);

//   @override
//   _ContactScreenState createState() => _ContactScreenState();
// }

// class _ContactScreenState extends State<ContactScreen> {
//   Widget buildContent(ContactViewModel viewModel) {
//     return Contact(
//       isLoading: viewModel.isLoading,
//       onSendMailTap: (object, body) => viewModel.sendContactEmail(object, body),
//       onCloseArrowTap: widget.onCloseArrowTap,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double statusBarHeight = MediaQuery.of(context).padding.top;

//     return Scaffold(
//         body: Padding(
//       padding: EdgeInsets.only(top: statusBarHeight),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: new StoreConnector<AppState, ContactViewModel>(
//           distinct: true,
//           converter: (store) => ContactViewModel.fromStore(store),
//           builder: (_, viewModel) => buildContent(viewModel),
//           // onInitialBuild: (viewModel) =>
//           //     viewModel.analyzePicture(widget.imagePath),
//         ),
//       ),
//     ));
//   }
// }
