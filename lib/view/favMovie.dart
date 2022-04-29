import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import '/constants.dart';
import '/controller/movieController.dart';
import '/view/movie_search.dart';
import 'movie_desc.dart';

class favMoviesScreen extends StatefulWidget {
  @override
  State<favMoviesScreen> createState() => _favMoviesScreenState();
}

class _favMoviesScreenState extends State<favMoviesScreen> {
  final MovieController movieController = Get.put(MovieController());

  @override
  void initState() {
    // TODO: implement initState
    // movieController.getFavMovie(favMoviesId);
    print(movieController.favMovies);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: movieController.favMovies.isBlank
            ? Center(
                child: Text(
                  "No data to show",
                  style: TextStyle(fontSize: 40),
                ),
              )
            : Container(
                child: GridView.builder(
                // options: CarouselOptions(
                //   autoPlay: true,
                //   viewportFraction: 0.5,
                //   height: size.height * 0.6,
                //   enlargeCenterPage: true,
                //   onPageChanged: (i, _) {
                //     // movieController.selectedMovies(i);
                //     // movieController.getMovieDetail(favMoviesId[i]);
                //   },
                // ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0.9,
                  mainAxisSpacing: 0.6,
                  crossAxisCount: 3,
                ),
                itemCount: movieController.favMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      movieController.getMovieDetail(favMoviesId[index]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MovieDescription()));
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "$posterURL${movieController.favMovies[index].posterURL}"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )));
  }
}
