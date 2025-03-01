import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:treninoo/view/components/appbar.dart';
import 'package:treninoo/view/style/theme.dart';

class NewsPdfViewer extends StatelessWidget {
  const NewsPdfViewer({super.key, required this.pdfUrl});

  final String pdfUrl;

  static Route route(String pdfUrl) {
    return MaterialPageRoute<void>(
      builder: (_) => NewsPdfViewer(pdfUrl: pdfUrl),
    );
  }

  get pdfName {
    String pdfName = pdfUrl.split('/').last;
    return Uri.decodeFull(pdfName);
  }

  @override
  Widget build(BuildContext context) {
    print(pdfName);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            children: [
              BeautifulAppBar(title: pdfName),
              SizedBox(height: kPadding / 2),
              Expanded(
                child: SfPdfViewerTheme(
                  data: SfPdfViewerThemeData(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    progressBarColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(kPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRadius),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kRadius),
                      child: SfPdfViewer.network(
                        pdfUrl,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
