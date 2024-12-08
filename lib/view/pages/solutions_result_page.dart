import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/recent_solutions/recent_solutions.dart';
import 'package:treninoo/bloc/solutions/solutions.dart';
import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/view/components/appbar.dart';
import 'package:treninoo/view/components/solutions/solutions_header.dart';
import 'package:treninoo/view/components/solutions/solutions_list.dart';
import 'package:treninoo/view/components/train_exist/train_handler.dart';
import 'package:treninoo/view/style/theme.dart';

class SolutionsResultPage extends StatefulWidget {
  final SolutionsInfo solutionsInfo;

  SolutionsResultPage({Key? key, required this.solutionsInfo})
      : super(key: key);

  @override
  _SolutionsResultPageState createState() => _SolutionsResultPageState();
}

class _SolutionsResultPageState extends State<SolutionsResultPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<SolutionsBloc>()
        .add(SolutionsRequest(solutionsInfo: widget.solutionsInfo));
    context
        .read<RecentSolutionsBloc>()
        .add(AddRecentSolution(solutionsInfo: widget.solutionsInfo));
  }

  @override
  Widget build(BuildContext context) {
    return HandleExistBloc(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              children: <Widget>[
                BeautifulAppBar(
                  title: "Soluzioni",
                ),
                SizedBox(height: kPadding),
                SolutionsDetails(
                  solutionsInfo: widget.solutionsInfo,
                ),
                SizedBox(height: 8),
                Expanded(
                  child: BlocBuilder<SolutionsBloc, SolutionsState>(
                    builder: (context, state) {
                      if (state is SolutionsSuccess)
                        return SolutionsList(
                          solutions: state.solutions,
                          delays: state.delays,
                        );
                      if (state is SolutionsLoading)
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
