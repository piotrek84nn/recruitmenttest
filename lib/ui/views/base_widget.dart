import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recrutmenttest/core/vm/base_model.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final T viewModel;
  final Widget? child;
  final Function(T)? onViewModelReady;

  const BaseWidget({
    Key? key,
    required this.builder,
    required this.viewModel,
    this.child,
    this.onViewModelReady,
  }) : super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> {
  late T viewModel;

  @override
  void initState() {
    viewModel = widget.viewModel;

    if (widget.onViewModelReady != null) {
      widget.onViewModelReady!(viewModel);
    }

    developer.log(
      'INFOⓘ| ------ VM: ${viewModel.runtimeType} ------ ',
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => viewModel,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
