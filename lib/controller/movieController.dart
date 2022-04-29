import 'package:get/state_manager.dart';
import '/constants.dart';
import '/model/detailedMovieModel.dart';
import '/model/trendingMovieModel.dart';
import '/services/apiService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:movieassignment/constants.dart';
import 'package:movieassignment/model/favMovieModel.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  List<TrendingMovie> trendingMovies = List<TrendingMovie>().obs;
  List<TrendingMovie> searchedMovies = List<TrendingMovie>().obs;
  List<FavourateMovie> favMovies = List<FavourateMovie>().obs;
  var movie = DetailedMovie(
          bgURL: null,
          category: null,
          id: null,
          overview: null,
          posterURL: null,
          rating: null,
          releaseYear: null,
          title: null,
          budget: null,
          cast: null,
          crew: null,
          revenue: null,
          runtime: null,
          isFav: null)
      .obs;
  var selectedMovie = TrendingMovie(
    bgURL: null,
    category: null,
    id: null,
    overview: null,
    posterURL: null,
    rating: null,
    releaseYear: null,
    title: null,
  ).obs;
  var favourateMovie = FavourateMovie(posterURL: null, id: null).obs;
  @override
  void onInit() {
    getTrendingMovies();
    super.onInit();
  }

  void selectedMovies(int index) {
    selectedMovie(trendingMovies[index]);
  }

  void getSearchedMovie(String movieName) async {
    isLoading(true);
    var _movies = await APIService.getSearchedMovie(movieName);
    if (_movies != null) {
      searchedMovies = _movies;
    }
    isLoading(false);
  }

  void getFavMovie(var id) async {
    isLoading(true);
    // for (var id in ids) {
    var _movie = await APIService.getMovieDetail(id);
    if (_movie != null) {
      FavourateMovie _favmovie =
          FavourateMovie(posterURL: _movie.posterURL, id: _movie.id);
      favMovies.add(_favmovie);
    }
    // }
    isLoading(false);
  }

  void removeFavMovie(var id) async {
    // for (var id in ids) {
    final movieIndex =
        this.favMovies.indexWhere((favMovies) => favMovies.id == id);
    this.favMovies.removeAt(movieIndex);
    favMoviesId.remove(id);
    // FavourateMovie _favmovie =
    //     FavourateMovie(posterURL: _movie.posterURL, id: _movie.id);
    // favMovies.remove(_favmovie);
    print(movieIndex);
    // }
    isLoading(false);
  }

  void getTrendingMovies() async {
    isLoading(true);
    var _movies = await APIService.getTrendingMovie();
    if (_movies != null) {
      trendingMovies = _movies;
      selectedMovies(0);
    }
    isLoading(false);
  }

  void getMovieDetail(String id) async {
    isLoading(true);
    var _movie = await APIService.getMovieDetail(id);
    if (_movie != null) {
      movie(_movie);
    }
    isLoading(false);
  }

  void launchURL(String query) async {
    final url = '$youtubeSearch$query+offical+trailer'.toLowerCase();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
