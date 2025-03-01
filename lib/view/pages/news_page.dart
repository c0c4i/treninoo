import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treninoo/bloc/news/news_bloc.dart';
import 'package:treninoo/repository/train.dart';
import 'package:treninoo/view/components/appbar.dart';
import 'package:treninoo/view/components/news_card.dart';
import 'package:treninoo/view/style/colors/primary.dart';
import 'package:treninoo/view/style/theme.dart';
import 'package:treninoo/view/style/typography.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => NewsBloc(
          context.read<TrainRepository>(),
        ),
        child: const NewsPage(),
      ),
    );
  }

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  _NewsPageState() : super();

  late TabController _tabController;

  @override
  void initState() {
    context.read<NewsBloc>().add(FetchNews());
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            children: <Widget>[
              BeautifulAppBar(
                title: "Notizie",
              ),
              SizedBox(height: kPadding * 2),
              TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadius),
                  color: Primary.lightest2,
                ),
                // indicatorPadding: EdgeInsets.all(16),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                labelColor: Primary.normal,
                unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                tabs: [
                  Tab(
                    child: Text(
                      "Notizie Infomobilità",
                      style: Typo.bodyHeavy,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Modifiche Programmate",
                      style: Typo.bodyHeavy,
                    ),
                  ),
                ],
              ),
              SizedBox(height: kPadding),
              Expanded(
                child: BlocBuilder<NewsBloc, NewsState>(
                  builder: (context, state) {
                    if (state is NewsLoaded) {
                      return TabBarView(
                        controller: _tabController,
                        children: [
                          RefreshIndicator(
                            onRefresh: () async {
                              context.read<NewsBloc>().add(FetchNews());
                            },
                            child: ListView.builder(
                              itemCount: state.news.newsInfomobilita.length,
                              itemBuilder: (context, index) {
                                return NewsCard(
                                  news: state.news.newsInfomobilita[index],
                                );
                              },
                            ),
                          ),
                          RefreshIndicator(
                            onRefresh: () async {
                              context.read<NewsBloc>().add(FetchNews());
                            },
                            child: ListView.builder(
                              itemCount:
                                  state.news.newsModificheProgrammate.length,
                              itemBuilder: (context, index) {
                                return NewsCard(
                                  news: state
                                      .news.newsModificheProgrammate[index],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    if (state is NewsLoading)
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    if (state is NewsError) {
                      return Center(
                        child: TextButton(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.refresh),
                              SizedBox(width: 8),
                              Text(
                                'Riprova',
                                style: Typo.bodyHeavy,
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Primary.lightest2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(kRadius),
                            ),
                          ),
                          onPressed: () {
                            context.read<NewsBloc>().add(FetchNews());
                          },
                        ),
                      );
                      // return Center(
                      //   child: Text('Error'),
                      // );
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
