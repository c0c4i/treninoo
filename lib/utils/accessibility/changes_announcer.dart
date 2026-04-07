import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:treninoo/model/Stop.dart';
import 'package:treninoo/model/TrainInfo.dart';

class AccessibilityChangesAnnouncer {
  static void announceChanges(
      BuildContext context, TrainInfo oldTrainInfo, TrainInfo newTrainInfo) {
    List<TrainInfoDifference> differences =
        oldTrainInfo.compareWith(newTrainInfo);

    List<String> announcements = [];

    // Announce information
    for (TrainInfoDifference difference in differences) {
      switch (difference) {
        case TrainInfoDifference.status:
          String announcement =
              "Il treno ${newTrainInfo.trainCode} è stato rilevato alle ore ${newTrainInfo.lastTimeRegister?.format(context)}";

          if (newTrainInfo.lastPositionRegister != null) {
            announcement += " a ${newTrainInfo.lastPositionRegister}";
          }

          String delay;
          if (newTrainInfo.delay! != 0) {
            bool isDelayNegative = newTrainInfo.delay!.isNegative;
            String delayType = isDelayNegative ? "anticipo" : "ritardo";
            delay = " con un $delayType di ${newTrainInfo.delay!} minuti";
          } else {
            delay = " in orario";
          }

          announcements.add(announcement + delay);
          break;
        case TrainInfoDifference.stops:
          if (oldTrainInfo.stops == null) return;

          if (oldTrainInfo.stops?.length != newTrainInfo.stops?.length) {
            FirebaseCrashlytics.instance.recordError(
              "The number of stops has changed",
              StackTrace.current,
              information: [
                "Train code: ${newTrainInfo.trainCode}",
                "Departure station: ${newTrainInfo.departureStation.stationCode}",
                "Old stops: ${oldTrainInfo.stops?.map((e) => e.station.stationName).join(", ")}",
                "New stops: ${newTrainInfo.stops?.map((e) => e.station.stationName).join(", ")}",
              ],
            );
            return;
          }

          // Retrieve which stop has changed
          for (var i = 0; i < newTrainInfo.stops!.length; i++) {
            List<StopDifference> stopDifferences =
                oldTrainInfo.stops![i].compareWith(newTrainInfo.stops![i]);
            if (stopDifferences.isNotEmpty) {
              for (StopDifference stopDifference in stopDifferences) {
                switch (stopDifference) {
                  // Announce planned changes
                  case StopDifference.plannedDepartureRail:
                    announcements.add(
                      "Il binario provvisorio di partenza da ${newTrainInfo.stops?[i].station.stationName} è ${newTrainInfo.stops?[i].plannedDepartureRail}",
                    );
                    break;
                  case StopDifference.plannedArrivalRail:
                    announcements.add(
                      "Il binario provvisorio di arrivo a ${newTrainInfo.stops?[i].station.stationName} è ${newTrainInfo.stops?[i].plannedArrivalRail}",
                    );
                    break;

                  // Announce actual changes
                  case StopDifference.actualDepartureTime:
                    announcements.add(
                      "Il treno ${newTrainInfo.trainCode} è partito da ${newTrainInfo.stops?[i].station.stationName} alle ore ${newTrainInfo.stops?[i].actualDepartureTime?.format(context)}",
                    );
                    break;
                  case StopDifference.actualArrivalTime:
                    announcements.add(
                      "Il treno ${newTrainInfo.trainCode} è arrivato a ${newTrainInfo.stops?[i].station.stationName} alle ore ${newTrainInfo.stops?[i].actualArrivalTime?.format(context)}",
                    );
                    break;
                  case StopDifference.actualDepartureRail:
                    announcements.add(
                      "Il treno ${newTrainInfo.trainCode} partirà da ${newTrainInfo.stops?[i].station.stationName} dal binario effettivo ${newTrainInfo.stops?[i].actualDepartureRail}",
                    );
                    break;
                  case StopDifference.actualArrivalRail:
                    announcements.add(
                      "Il treno ${newTrainInfo.trainCode} arriverà a ${newTrainInfo.stops?[i].station.stationName} al binario effettivo ${newTrainInfo.stops?[i].actualArrivalRail}",
                    );
                    break;
                }
              }
            }
          }

          break;
      }
    }

    if (announcements.isEmpty) return;

    // Compose the announcement and announce it
    String announcement = announcements.join(".\n");
    debugPrint(announcement);
    SemanticsService.sendAnnouncement(
      View.of(context),
      announcement,
      TextDirection.ltr,
    );
  }
}
