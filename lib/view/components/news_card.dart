import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:treninoo/bloc/exist/exist_bloc.dart';
import 'package:treninoo/bloc/exist/exist_event.dart';
import 'package:treninoo/model/News.dart';
import 'package:treninoo/model/SavedTrain.dart';
import 'package:treninoo/utils/utils.dart';
import 'package:treninoo/view/pages/news_pdf_viewer.dart';
import 'package:treninoo/view/style/colors/grey.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kPadding / 2,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadius),
          border: Border.all(
            color: Grey.light,
            width: 1,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: ExpansionTile(
          title: Text(news.title),
          tilePadding: EdgeInsets.all(kPadding),
          minTileHeight: 0,
          backgroundColor: Theme.of(context).colorScheme.surface,
          collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HtmlWidget(
                news.content ?? '',
                onTapUrl: (url) async {
                  // If it's a a PDF url, render on a pdf viewer
                  if (url.endsWith('.pdf')) {
                    Navigator.push(context, NewsPdfViewer.route(url));
                    return true;
                  }

                  // If url contains parms treno, origine and datapartenza, open the train page
                  if (Utils.isTrainUrl(url)) {
                    SavedTrain savedTrain = SavedTrain.fromNewsUrl(url);
                    context.read<ExistBloc>().add(
                          ExistRequest(savedTrain: savedTrain),
                        );
                    return true;
                  }

                  if (url.contains('cercaTreno')) {
                    Navigator.pop(context, true);
                    return true;
                  }

                  try {
                    Uri uri = Uri.parse(url);
                    await launchUrl(uri);
                  } on Exception catch (e, s) {
                    FirebaseCrashlytics.instance.recordError(e, s);
                    return false;
                  }
                  return true;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
