import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/recent_solutions/recent_solutions.dart';
import 'package:treninoo/model/SavedSolutionsInfo.dart';
import 'package:treninoo/view/components/beautiful_card.dart';
import 'package:treninoo/view/components/recent_solutions/recent_solution_card.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';

class RecentSolutionsList extends StatelessWidget {
  const RecentSolutionsList(
      {super.key, required this.onSearch, required this.onPressed});

  final Function(SavedSolutionsInfo) onSearch;
  final Function(SavedSolutionsInfo) onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentSolutionsBloc, RecentSolutionsState>(
        builder: ((context, state) {
      if (state is RecentSolutionsSuccess &&
          state.savedSolutionsInfo.isNotEmpty) {
        List<SavedSolutionsInfo> recents = state.savedSolutionsInfo;

        return Padding(
          padding: EdgeInsets.only(
              right: kPadding * 2, left: kPadding * 2, bottom: kPadding),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Ricerche recenti",
                      style: TextStyle(color: Grey.dark))),
              SizedBox(
                height: 8,
              ),
              Flexible(
                child: BeautifulCard(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: ClampingScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        Divider(thickness: 1, height: 1),
                    itemCount: recents.length,
                    itemBuilder: (context, index) {
                      return RecentSolutionCard(
                        solutionsInfo: recents[index],
                        onSearch: () => onSearch(recents[index]),
                        onPressed: () => onPressed(recents[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return SizedBox.shrink();
    }));
  }
}
