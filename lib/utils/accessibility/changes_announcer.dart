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
              "Il treno ${newTrainInfo.trainCode} è stato rilevato alle ore ${newTrainInfo.lastTimeRegister!.format(context)}");
          SemanticsService.announce(
            "Il treno ${newTrainInfo.trainCode} è stato rilevato alle ore ${newTrainInfo.lastTimeRegister!.format(context)}",
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
                String announcement = "Il treno ${newTrainInfo.trainCode} ";
                switch (stopDifference) {
                  // Announce planned changes
                  case StopDifference.plannedDepartureTime:
                    announcement =
                        "ha cambiato l'orario di partenza provvisoria da ${newTrainInfo.stops![i].station.stationName} alle ore ${newTrainInfo.stops![i].plannedDepartureTime!.format(context)}";
                    break;
                  case StopDifference.plannedArrivalTime:
                    debugPrint(
                        "ha cambiato l'orario di arrivo provvisorio a ${newTrainInfo.stops![i].station.stationName} alle ore ${newTrainInfo.stops![i].plannedArrivalTime!.format(context)}");
                    break;
                  case StopDifference.plannedDepartureRail:
                    announcement =
                        "partirà da ${newTrainInfo.stops![i].station.stationName} al binario provvisorio ${newTrainInfo.stops![i].plannedDepartureRail}";
                    break;
                  case StopDifference.plannedArrivalRail:
                    announcement =
                        "arriverà a ${newTrainInfo.stops![i].station.stationName} al binario provvisorio ${newTrainInfo.stops![i].plannedArrivalRail}";
                    break;

                  // Announce actual changes
                  case StopDifference.actualDepartureTime:
                    announcement =
                        "è partito da ${newTrainInfo.stops![i].station.stationName} alle ore ${newTrainInfo.stops![i].actualDepartureTime!.format(context)}";
                    break;
                  case StopDifference.actualArrivalTime:
                    announcement =
                        "è arrivato a ${newTrainInfo.stops![i].station.stationName} alle ore ${newTrainInfo.stops![i].actualArrivalTime!.format(context)}";
                    break;
                  case StopDifference.actualDepartureRail:
                    announcement =
                        "partirà da ${newTrainInfo.stops![i].station.stationName} dal binario effettivo ${newTrainInfo.stops![i].actualDepartureRail}";
                    break;
                  case StopDifference.actualArrivalRail:
                    announcement =
                        "arriverà a ${newTrainInfo.stops![i].station.stationName} al binario effettivo ${newTrainInfo.stops![i].actualArrivalRail}";
                    break;
                }

                // Announce the change
                SemanticsService.announce(
                  announcement,
                  TextDirection.ltr,
                );
              }
            }
          }

          break;
      }
    }
  }
}
