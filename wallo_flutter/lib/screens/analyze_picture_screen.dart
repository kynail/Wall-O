import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/analyze_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/views/home/analyze_picture.dart';

class AnalyzeScreen extends StatefulWidget {
  final String imagePath;

  const AnalyzeScreen({Key key, this.imagePath}) : super(key: key);

  @override
  _AnalyzeScreenState createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  Widget buildContent(AnalyzeViewModel viewModel) {
    return AnalyzePicture(
      imagePath: widget.imagePath,
      isLoading: viewModel.isLoading,
      fishes: viewModel.analyzedFish,
      onDispose: () => viewModel.clearAnalyzedFish(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Analyser la photo')),
      body: new StoreConnector<AppState, AnalyzeViewModel>(
        distinct: true,
        converter: (store) => AnalyzeViewModel.fromStore(store),
        builder: (_, viewModel) => buildContent(viewModel),
        onInitialBuild: (viewModel) =>
            viewModel.analyzePicture(widget.imagePath),
      ),
    );
  }
}
