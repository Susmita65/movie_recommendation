
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sstfix/Screens/DetailsPage/Components/DetailsPageBody.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import '../../../../Util/GreenSnackbar.dart';
import '../../../../api/api.dart';
import '../../../../main.dart';
import 'ScoreService.dart';

class Recommendations extends StatefulWidget {
  final uid;
  final movie_name;
  Recommendations({
    Key? key,
    @required this.uid,
    this.movie_name,
  }) : super(key: key);

  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {

  final uid = FirebaseAuth.instance.currentUser!.uid;

  Map<String,dynamic> scores = {};
  List recommend = [];
  double cosineSimilarity = 0.0;
  double euclideanDistance = 0.0;
  double manhattanDistance = 0.0;

  Future<void> _showMyDialog(movieid, moviename, posterpath) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user le button tap garna parxa hai
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Container(
              height: 140,
              width: 140,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  AntIcons.plusSquareOutlined,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                const Text(
                                  "ADD TO WATCHLIST",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                      color: Colors.white),
                                ),
                              ],
                            ))),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: const Divider(
                        color: Colors.grey,
                        thickness: 0.8,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: const Text(
                          "CLOSE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void hybridbasedrecommendations() async {
    try {
      var response = await Dio().get(
          "${Api.baseUrl}send/" + widget.movie_name.toString() + "/" +
              "$uid".toString());
      // print("${Api.baseUrl}score/" + widget.movie_name.toString() + "/" +
      //     recommend[index]["title"]);
      var data = response.data;
      if (mounted) {
        setState(() {
          if (mounted) {
            recommend = data;
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }



  // void apibased() async {
  //   try {
  //     var response = await Dio().get("https://api.themoviedb.org/3/movie/" +
  //         widget.uid.toString() +
  //         "/recommendations?api_key=2c5341f7625493017933e27e81b1425e&language=en-US&page=1");
  //
  //     var data = response.data;
  //     if (mounted) {
  //       setState(() {
  //         recommend = data['results'];
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    hybridbasedrecommendations();

  }

  List<String> movieimages = [];
  List<String> movietitles = [];

  void storedata(String name, String url, String id) async {
    movieimages.add(url.toString());
    recommemdedmovieimages =
        preferences.getStringList('recommemdedmovieimages') ?? [];
    for (int i = 0; i < recommemdedmovieimages.length; i++) {
      if (recommemdedmovieimages[i] == url) {
        return;
      }
    }
    recommemdedmovieimages.add(url.toString());
    recommemdedmovieimages.toSet().toList();
    preferences.setStringList("recommemdedmovieimages", recommemdedmovieimages);

    movietitles.add(name.toString());
    recommemdedmovienames =
        preferences.getStringList('recommemdedmovietitles') ?? [];
    for (int i = 0; i < recommemdedmovienames.length; i++) {
      if (recommemdedmovienames[i] == name) {
        return;
      }
    }
    recommemdedmovienames.add(name.toString());
    recommemdedmovienames.toSet().toList();
    preferences.setStringList("recommemdedmovietitles", recommemdedmovienames);
  }

  @override
  Widget build(BuildContext context) {
    print("recommendationUrl: ${Api.baseUrl}send/" + widget.movie_name.toString() + "/" +
        "$uid".toString());
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 2.h,
                left: 2.w,
                right: 2.w,
              ),
              child: Text("Recommendations Based on ML Model",
                  style: TextStyle(
                      color: HexColor("#7220C9"),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none)),
            ),
            recommend.isNotEmpty
                ? InkWell(
              onTap: () {
                var _type = FeedbackType.success;
                Vibrate.feedback(_type);
                storedata(
                    recommend[0]["original_title"].toString(),
                    "https://image.tmdb.org/t/p/w780" +
                        recommend[0]["poster_path"].toString(),
                    recommend[0]["id"].toString());
                storedata(
                    recommend[1]["original_title"].toString(),
                    "https://image.tmdb.org/t/p/w780" +
                        recommend[1]["poster_path"].toString(),
                    recommend[1]["id"].toString());

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 5,
                  content: GreenSnackbar(
                    title: "Recommendations are sent to your watchlist",
                    message: ':)',
                  ),
                ));
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                width: 80.w,
                height: 4.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.blueGrey),
                child: Row(
                  children: [
                    Container(
                        padding:
                        const EdgeInsets.only(bottom: 4, left: 10),
                        child: const Icon(AntIcons.likeOutlined,
                            size: 22, color: Colors.white)),
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 4, left: 5, top: 2),
                      child: const Text(
                        "Like these for watchlist?",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : SizedBox(),
            recommend.isNotEmpty ? getallpopularmoviecards() : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget getlottie() {
    return Center(
      child: Container(
        height: 30.h,
        width: 80.w,
        child: Lottie.asset("assets/images/analysing.json"),
      ),
    );
  }



//   Widget getallpopularmoviecards() {
//     if (recommend.isEmpty) {
//       return getlottie();
//     } else {
//
//       return Container(
//         color: Colors.black,
//         margin: const EdgeInsets.only(top: 0),
//         child: ListView.builder(
//
//           shrinkWrap: true,
//           itemCount: recommend.isNotEmpty ? 5 : 0,
//           controller: ScrollController(keepScrollOffset: false),
//           itemBuilder: (BuildContext context, int index) {
//             similarityscores(movie2: recommend[index]["title"]);
//             return ListTile(
//               leading: FadeInImage.assetNetwork(
//                 image: "https://image.tmdb.org/t/p/w780" +
//                     recommend[index]["poster_path"],
//                 placeholder: "assets/images/loading.png",
//                 fit: BoxFit.cover,
//               ),
//               title: Text(recommend[index]["title"],style: TextStyle(color: Colors.white),),
//               subtitle: Column(
//                 children: [
//                   Text('Rating: ${recommend[index]["vote_average"]}',style: TextStyle(color: Colors.white),),
//
//                 ],
//               ),
//             );
//           },
//         ),
//       );
//     }
//   }

  Widget getallpopularmoviecards() {
    if (recommend.isEmpty) {
      return getlottie();
    } else {
      return Container(
        color: Colors.black,
        margin: const EdgeInsets.only(top: 0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: recommend.isNotEmpty ? 5 : 0,
          controller: ScrollController(keepScrollOffset: false),
          itemBuilder: (BuildContext context, int index) {


            print("${Api.baseUrl}score/" + widget.movie_name.toString() + "/" +
                recommend[index]["title"]);



              final scoreService = ScoreService();

              scoreService.getMovieScore('${widget.movie_name}', '${recommend[index]["title"]}')
                  .then((response) {

                    setState(() {
                       cosineSimilarity = response['cosineSimilarity'];
                       euclideanDistance = response['euclideanDistance'];
                       manhattanDistance = response['manhattanDistance'];
                    });
                // Handle the response here


                // Do something with the data
                print('Cosine Similarity for ${recommend[index]["title"]}: $cosineSimilarity');
                print('Euclidean Distance: $euclideanDistance');
                print('Manhattan Distance: $manhattanDistance');
              })
                  .catchError((error) {
                // Handle errors here
                print('Error fetching movie score: $error');
              });



            return ListTile(
              leading: FadeInImage.assetNetwork(
                image: "https://image.tmdb.org/t/p/w780" +
                    recommend[index]["poster_path"],
                placeholder: "assets/images/loading.png",
                fit: BoxFit.cover,
              ),
              title: Text(
                recommend[index]["title"],
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rating: ${recommend[index]["vote_average"]}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'cosineSimilarity: ${cosineSimilarity.toPrecision(3)}',
                    style: TextStyle(color: Colors.white),
                  ),Text(
                    'euclideanDistance: ${euclideanDistance.toPrecision(3)}',
                    style: TextStyle(color: Colors.white),
                  ),Text(
                    'manhattanDistance: ${manhattanDistance.toPrecision(3)}',
                    style: TextStyle(color: Colors.white),
                  ),

                ],
              ),
            );
          },
        ),
      );
    }
  }
 }






