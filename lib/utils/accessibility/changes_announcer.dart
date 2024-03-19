import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/model/TrainInfo.dart';

class AccessibilityChangesAnnouncer {
  static void announceChanges(
      BuildContext context, TrainInfo oldTrainInfo, TrainInfo newTrainInfo) {
    List<TrainInfoDifference> differences =
        oldTrainInfo.compareWith(newTrainInfo);

    // Announce information
    for (TrainInfoDifference difference in differences) {
      switch (difference) {
        case TrainInfoDifference.lastTimeRegister:
          debugPrint(
              "Il treno ${newTrainInfo.trainCode} è stato rilevato alle ${newTrainInfo.lastTimeRegister!.format(context)}");
          SemanticsService.announce(
            "Il treno ${newTrainInfo.trainCode} è stato rilevato alle ${newTrainInfo.lastTimeRegister!.format(context)}",
            TextDirection.ltr,
          );
          break;
        case TrainInfoDifference.lastPositionRegister:
          debugPrint(
              "Il treno ${newTrainInfo.trainCode} è in stazione ${newTrainInfo.lastPositionRegister}");
          SemanticsService.announce(
            "Il treno ${newTrainInfo.trainCode} è in stazione ${newTrainInfo.lastPositionRegister}",
            TextDirection.ltr,
          );
          break;
        case TrainInfoDifference.delay:
          String announcement = "";
          if (newTrainInfo.delay! > 0)
            announcement =
                "Il treno ${newTrainInfo.trainCode} ha un ritardo di ${newTrainInfo.delay} minuti";
          else
            announcement = "Il treno ${newTrainInfo.trainCode} è in orario";

          debugPrint(announcement);
          SemanticsService.announce(announcement, TextDirection.ltr);
          break;
        case TrainInfoDifference.stops:
          // Retrieve which stop has changed
          for (var i = 0; i < newTrainInfo.stops!.length; i++) {
            List<StopDifference> stopDifferences =
                oldTrainInfo.stops![i].compareWith(newTrainInfo.stops![i]);
            if (stopDifferences.isNotEmpty) {
              for (StopDifference stopDifference in stopDifferences) {
                switch (stopDifference) {
                  case StopDifference.plannedDepartureTime:
                    debugPrint(
                        "Il treno ${newTrainInfo.trainCode} ha cambiato l'orario di partenza da ${newTrainInfo.stops![i].station.stationName} alle ${newTrainInfo.stops![i].plannedDepartureTime!.format(context)}");
                    SemanticsService.announce(
                      "Il treno ${newTrainInfo.trainCode} ha cambiato l'orario di partenza da ${newTrainInfo.stops![i].station.stationName} alle ${newTrainInfo.stops![i].plannedDepartureTime!.format(context)}",
                      TextDirection.ltr,
                    );
                    break;
                  case StopDifference.actualDepartureTime:
                    debugPrint(
                        "Il treno ${newTrainInfo.trainCode} ha cambiato l'orario di partenza da ${newTrainInfo.stops![i].station.stationName} alle ${newTrainInfo.stops![i].actualDepartureTime!.format(context)}");
                    SemanticsService.announce(
                      "Il treno ${newTrainInfo.trainCode} ha cambiato l'orario di partenza da ${newTrainInfo.stops![i].station.stationName} alle ${newTrainInfo.stops![i].actualDepartureTime!.format(context)}",
                      TextDirection.ltr,
                    );
                    break;
                  case StopDifference.plannedArrivalTime:
                    debugPrint(
                        "Il treno ${newTrainInfo.trainCode} ha cambiato l'orario di arrivo a ${newTrainInfo.stops![i].station.stationName} alle ${newTrainInfo.stops![i].plannedArrivalTime!.format(context)}");
                    SemanticsService.announce(
                      "Il treno ${newTrainInfo.trainCode} ha cambiato l'orario di arrivo a ${newTrainInfo.stops![i].station.stationName} alle ${newTrainInfo.stops![i].plannedArrivalTime!.format(context)}",
                      TextDirection.ltr,
                    );
                    break;
                  case StopDifference.actualArrivalTime:
                    debugPrint(
                        "Il treno ${newTrainInfo.trainCode} ha cambiato l'orario di arrivo a ${newTrainInfo.stops![i].station.stationName} alle ${newTrainInfo.stops![i].actualArrivalTime!.format(context)}");
                    SemanticsService.announce(
                      "Il treno ${newTrainInfo.trainCode} ha cambiato l'orario di arrivo a ${newTrainInfo.stops![i].station.stationName} alle ${newTrainInfo.stops![i].actualArrivalTime!.format(context)}",
                      TextDirection.ltr,
                    );
                    break;
                  case StopDifference.plannedDepartureRail:
                    debugPrint(
                        "Il treno ${newTrainInfo.trainCode} ha cambiato il binario di partenza da ${newTrainInfo.stops![i].station.stationName} al binario ${newTrainInfo.stops![i].plannedDepartureRail}");
                    SemanticsService.announce(
                      "Il treno ${newTrainInfo.trainCode} ha cambiato il binario di partenza da ${newTrainInfo.stops![i].station.stationName} al binario ${newTrainInfo.stops![i].plannedDepartureRail}",
                      TextDirection.ltr,
                    );
                    break;
                  case StopDifference.actualDepartureRail:
                    SemanticsService.announce(
                      "Il treno ${newTrainInfo.trainCode} ha cambiato il binario di partenza da ${newTrainInfo.stops![i].station.stationName} al binario ${newTrainInfo.stops![i].actualDepartureRail}",
                      TextDirection.ltr,
                    );
                    break;
                  case StopDifference.plannedArrivalRail:
                    SemanticsService.announce(
                      "Il treno ${newTrainInfo.trainCode} ha cambiato il binario di arrivo a ${newTrainInfo.stops![i].station.stationName} al binario ${newTrainInfo.stops![i].plannedArrivalRail}",
                      TextDirection.ltr,
                    );
                    break;
                  case StopDifference.actualArrivalRail:
                    SemanticsService.announce(
                      "Il treno ${newTrainInfo.trainCode} ha cambiato il binario di arrivo a ${newTrainInfo.stops![i].station.stationName} al binario ${newTrainInfo.stops![i].actualArrivalRail}",
                      TextDirection.ltr,
                    );
                    break;
                }
              }
            }
          }

          break;
      }
    }
  }
}
