import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/bloc/get_top_headlines_bloc.dart';
import 'package:news/elements/error_element.dart';
import 'package:news/elements/loader_element.dart';
import 'package:news/model/article.dart';
import 'package:news/model/article_response.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadLineSlider extends StatefulWidget {
  @override
  _HeadLineSliderState createState() => _HeadLineSliderState();
}

class _HeadLineSliderState extends State<HeadLineSlider> {
  @override
  void initState() {
    getTopHeadlinesBloc..getHeadlines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getTopHeadlinesBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return buildErrorWidget(snapshot.data.error);
          }
          return _buildHeadlinesSlider(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          buildLoadingWidget();
        }
        return buildLoadingWidget();
      },
    );
  }

  Widget _buildHeadlinesSlider(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: false,
          height: 200.0,
          viewportFraction: 0.9,
        ),
        items: getExpenseSlider(articles),
      ),
    );
  }

  getExpenseSlider(List<ArticleModel> articles) {
    return articles
        .map((article) => GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                  left: 5.0,
                  right: 5.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: article.img == null
                              ? AssetImage("assets/img/placeholder.jpg")
                              : NetworkImage(article.img),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.1, 0.9],
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.white.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        width: 250,
                        child: Column(
                          children: [
                            Text(
                              article.title,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      left: 10.0,
                      child: Text(
                        article.source.name,
                        style: TextStyle(fontSize: 9.0, color: Colors.white54),
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      right: 10.0,
                      child: Text(
                        article.date == null
                            ? "date null"
                            : timeAgo(
                                DateTime.parse(article.date),
                              ),
                        style: TextStyle(fontSize: 9.0, color: Colors.white54),
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList();
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
