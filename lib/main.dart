import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_bloc.dart';
import 'ui/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      builder: (_) => AppBloc(),
      child: CupertinoApp(
        // showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
