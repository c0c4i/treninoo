import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/solutions/solutions.dart';
import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/view/components/appbar.dart';
import 'package:treninoo/view/components/solutions/solutions_header.dart';
import 'package:treninoo/view/components/solutions/solutions_list.dart';

class SolutionsResultPage extends StatefulWidget {
  final SolutionsInfo solutionsInfo;

  SolutionsResultPage({Key key, this.solutionsInfo}) : super(key: key);

  @override
  _SolutionsResultPageState createState() => _SolutionsResultPageState();
}

class _SolutionsResultPageState extends State<SolutionsResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                BeautifulAppBar(
                  title: "Soluzioni",
                ),
                SizedBox(height: 16),
                BlocBuilder<SolutionsBloc, SolutionsState>(
                  builder: (context, state) {
                    if (state is SolutionsInitial)
                      context.read<SolutionsBloc>().add(SolutionsRequest(
                          solutionsInfo: widget.solutionsInfo));
                    if (state is SolutionsSuccess)
                      return Column(
                        children: [
                          SolutionsDetails(
                            solutionsInfo: widget.solutionsInfo,
                          ),
                          SolutionsList(
                            solutions: state.solutions,
                          )
                        ],
                      );
                    if (state is SolutionsLoading)
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
