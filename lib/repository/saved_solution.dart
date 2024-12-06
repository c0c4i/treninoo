import 'dart:convert';

import 'package:treninoo/model/SavedSolutionsInfo.dart';
import 'package:treninoo/model/SolutionsInfo.dart';
import 'package:treninoo/utils/shared_preference.dart';

abstract class SavedSolutionInfoRepository {
  SharedPrefs sharedPrefs;

  SavedSolutionInfoRepository(SharedPrefs sharedPrefs)
      : sharedPrefs = sharedPrefs;

  List<SavedSolutionsInfo> getRecentsSolutionsInfo();
  void addRecentSolutionAndRemoveOldest(SolutionsInfo solutionsInfo);
}

class APISavedSolution extends SavedSolutionInfoRepository {
  APISavedSolution(super.sharedPrefs);

  @override
  List<SavedSolutionsInfo> getRecentsSolutionsInfo() {
    String? raw = sharedPrefs.recentsSolutions;
    if (raw == null) return [];
    List<dynamic> rawSolutions = jsonDecode(raw);
    List<SavedSolutionsInfo> solutionsInfo =
        rawSolutions.map((e) => SavedSolutionsInfo.fromJson(e)).toList();
    //Sort by lastSelected
    solutionsInfo
        .sort((a, b) => a.lastSelected.isAfter(b.lastSelected) ? -1 : 1);

    return solutionsInfo;
  }

  @override
  void addRecentSolutionAndRemoveOldest(SolutionsInfo solutionsInfo) {
    //Get recent solutions from shared preferences
    List<SavedSolutionsInfo> solutions = getRecentsSolutionsInfo();

    //Check if new solution is already in recents solutions
    int? index = solutions.indexWhere((element) =>
        element.arrivalStation == solutionsInfo.arrivalStation &&
        element.departureStation == solutionsInfo.departureStation);

    //If solution is in recents solutions we only have to update lastSelected
    if (index != -1) {
      solutions[index] =
          solutions[index].copyWith(lastSelected: DateTime.now());
    } else {
      //Solution is not in recents solution
      //If recents solution has more than 5 elements remove the oldest (is the last one in the list)
      if (solutions.length > 4) {
        solutions.removeLast();
      }

      //Add new recent solution to the list
      solutions.add(SavedSolutionsInfo(
          solutionsInfo.departureStation, solutionsInfo.arrivalStation));
    }

    //Save the updated solutions list
    sharedPrefs.recentsSolutions = jsonEncode(solutions);
  }
}
