import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treninoo/model/Solutions.dart';
import 'package:treninoo/model/TrainInfo.dart';
import 'package:treninoo/model/TrainSolution.dart';
import 'package:treninoo/view/components/solutions/solution_card.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class SolutionsList extends StatelessWidget {
  SolutionsList({
    Key? key,
    required this.solutions,
    required this.trainInfos,
    required this.onLoadPreviousSolutions,
    required this.onLoadNextSolutions,
  }) : super(key: key);

  final Solutions solutions;
  final Map<TrainSolution, TrainInfo> trainInfos;
  final Future<void> Function() onLoadPreviousSolutions;
  final Future<void> Function() onLoadNextSolutions;

  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: RawScrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 4,
        interactive: true,
        thumbColor: Grey.dark,
        radius: Radius.circular(kRadius * 2),
        padding: EdgeInsets.only(right: kPadding / 3),
        child: EasyRefresh(
          controller: _refreshController,
          header: ClassicHeader(
            safeArea: true,
            infiniteOffset: null,
            showMessage: false,
            textBuilder: (context, state, text) {
              return Text(
                "Soluzioni precedenti",
                style: Typo.bodyLight.copyWith(
                  color: state.mode == IndicatorMode.armed
                      ? Primary.normal
                      : Grey.darker,
                ),
              );
            },
            triggerWhenReach: false,
            maxOverOffset: 64,
            triggerOffset: 64,
            hapticFeedback: true,
            spacing: kPadding,
            pullIconBuilder: pullIconBuilder,
          ),
          footer: ClassicFooter(
            safeArea: true,
            infiniteOffset: null,
            showMessage: false,
            textBuilder: (context, state, text) {
              return Text(
                "Soluzioni successive",
                style: Typo.bodyLight.copyWith(
                  color: state.mode == IndicatorMode.armed
                      ? Primary.normal
                      : Grey.darker,
                ),
              );
            },
            triggerWhenReach: false,
            maxOverOffset: 64,
            triggerOffset: 64,
            hapticFeedback: true,
            spacing: kPadding,
            pullIconBuilder: pullIconBuilder,
          ),
          onLoad: () async {
            await onLoadNextSolutions();
            _refreshController.finishLoad();
          },
          onRefresh: () async {
            await onLoadPreviousSolutions();
            _refreshController.finishRefresh();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: ListView.builder(
              itemCount: solutions.solutions.length,
              itemBuilder: (context, index) {
                return SolutionCard(
                  solution: solutions.solutions[index],
                  trainInfos: trainInfos,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget pullIconBuilder(context, state, animation) {
    if (state.mode == IndicatorMode.drag) {
      return Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Grey.darker,
      );
    }

    if (state.mode == IndicatorMode.armed) {
      return Icon(
        Icons.keyboard_arrow_up_rounded,
        color: Primary.normal,
      );
    }

    if (state.mode == IndicatorMode.processing) {
      return CupertinoActivityIndicator(color: Grey.darker);
    }

    return Icon(
      Icons.check_rounded,
      color: Grey.darker,
    );
  }
}
