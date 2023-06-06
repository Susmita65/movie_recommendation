import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sstfix/Screens/MoreMoviesPage.dart/Widgets/MovieCard.dart';
import 'package:shimmer/shimmer.dart';

class MoreMovies extends StatefulWidget {
  final url;
  MoreMovies({Key? key, @required this.url}) : super(key: key);
  @override
  _MoreMoviesState createState() => _MoreMoviesState();
}

class _MoreMoviesState extends State<MoreMovies> {
  List popularlist = [];
  Map<String, int> genres_ids = {
    'Adventure': 12,
    'Fantasy': 14,
    'Animation': 16,
    'Drama': 18,
    'Horror': 27,
    'Action': 28,
    'Comedy': 35,
    'History': 36,
    'Western': 37,
    'Thriller': 53,
    'Crime': 80,
    'Documentary': 99,
    'Science Fiction': 878,
    'Mystery': 9648,
    'Romance': 10749,
    'Family': 10751,
    'War': 10752,
    'TV Movie': 10770,
  };
  List genres = [];
  void getpopularresponse() async {
    var response = await Dio().get(widget.url);
    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          popularlist = data["results"];
        });
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    this.getpopularresponse();
  }
  @override
  Widget build(BuildContext context) {
    return getallpopularmoviecard();
  }
  Widget getallpopularmoviecard() {
    if (popularlist.isEmpty)
      return Container(
        margin: EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: 18,
          itemBuilder: (BuildContext context, int index) {
            return Shimmer.fromColors(
              period: Duration(milliseconds: 2000),
              baseColor: HexColor("#8970A4"),
              direction: ShimmerDirection.ltr,
              highlightColor: HexColor("#463567"),
              child: Container(
                height: 170,
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                    color: (Colors.purple[200])!,
                    borderRadius: BorderRadius.circular(4.0)),
              ),
            );
          },
        ),
      );
    else
      return Container(
          margin: EdgeInsets.all(8.0),
          child: ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: 18,
              itemBuilder: (BuildContext context, int index) {
                genres = popularlist[index]["genre_ids"];
                return MovieCard(
                  title:
                      popularlist[index]["original_title"].toString() == "null"
                          ? "NULL"
                          : popularlist[index]["original_title"].toString(),
                  rating:
                      popularlist[index]["vote_average"].toString() == "null"
                          ? "NULL"
                          : popularlist[index]["vote_average"].toString(),

                  released_year:
                      popularlist[index]["release_date"].toString() == "null"
                          ? "NULL"
                          : popularlist[index]["release_date"].toString(),
                  url: popularlist[index]["poster_path"].toString() == "null"
                      ? "NULL"
                      : "https://image.tmdb.org/t/p/w780" +
                          popularlist[index]["poster_path"].toString(),
                  type: check(),
                );
              }));
  }
  List check() {
    bool stop = false;
    String val = "";
    List pass_genres = [];
    int i = 0;
    int n = genres.length;
    while (i < n) {
      for (var key in genres_ids.keys) {
        if (genres_ids[key] == genres[i]) {
          val = key;
          stop = true;
          break;
        }
      }
      if (stop == true) {
        pass_genres.add(val);
        stop = false;
      }
      i++;
    }
    return pass_genres;
  }
}
