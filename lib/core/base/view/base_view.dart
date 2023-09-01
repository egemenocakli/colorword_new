import 'package:auto_route/auto_route.dart';
import 'package:colorword_new/core/base/viewmodel/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final T Function(BuildContext)? viewModelBuilder;
  final Widget Function(BuildContext, T)? builder;
  final bool showAppBar;
  final bool showDefaultProgressIndicator;

  const BaseView({
    Key? key,
    required this.viewModelBuilder,
    required this.builder,
    this.showAppBar = false,
    this.showDefaultProgressIndicator = true,
  })  : assert(viewModelBuilder != null, builder != null),
        super(key: key);

  @override
  State<BaseView> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: widget.viewModelBuilder!(context),
      child: Consumer<T>(
        builder: _buildScreenContent,
      ),
    );
  }

  Widget _buildScreenContent(BuildContext context, T viewModel, Widget? child) {
    final router = context.router;

    return WillPopScope(
      onWillPop: () {
        if (router.canNavigateBack) {
          router.back();
        }
        return SynchronousFuture(false /*router.canNavigateBack*/);
      },
      child: Stack(
        children: [
          buildBody(context: context, viewModel: viewModel, showAppBar: widget.showAppBar),
          buildLoadingView(viewModel: viewModel)
        ],
      ),
    );
  }

  FutureBuilder<dynamic> buildLoadingView({
    required T viewModel,
  }) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 0)),
      builder: (context, snapshot) => Visibility(
        visible: widget.showDefaultProgressIndicator == false
            ? false
            : (viewModel.refreshIndicatorRunning
                ? false
                : (viewModel.viewState ==
                    ViewState.loading /* ||
                snapshot.connectionState == ConnectionState.waiting*/
                )),
        child: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }

  Widget buildBody({
    required BuildContext context,
    required T viewModel,
    required bool showAppBar,
  }) {
    return widget.builder!(context, viewModel);
  }
}
