import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/recent_solutions/recent_solutions.dart';
import 'package:treninoo/model/SavedSolutionsInfo.dart';
import 'package:treninoo/view/components/beautiful_card.dart';
import 'package:treninoo/view/components/recent_solutions/recent_solution_card.dart';

class RecentSolutionsList extends StatelessWidget {
  const RecentSolutionsList({
    super.key,
    required this.onSearch,
    required this.onPressed,
  });

  final Function(SavedSolutionsInfo) onSearch;
  final Function(SavedSolutionsInfo) onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentSolutionsBloc, RecentSolutionsState>(
      builder: (context, state) {
        if (state is RecentSolutionsSuccess &&
            state.savedSolutionsInfo.isNotEmpty) {
          List<SavedSolutionsInfo> recents = state.savedSolutionsInfo;

          return BeautifulCard(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: recents.length,
              physics: ClampingScrollPhysics(),
              separatorBuilder: (context, index) =>
                  Divider(thickness: 1, height: 1),
              itemBuilder: (context, index) {
                return RecentSolutionCard(
                  solutionsInfo: recents[index],
                  onSearch: () => onSearch(recents[index]),
                  onPressed: () => onPressed(recents[index]),
                );
              },
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}
