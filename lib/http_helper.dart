import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'models/movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=eef0615704f65c3910322342b4311f7a';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';

  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=eef0615704f65c3910322342b4311f7a&query=';

  // Searches for a title by the title parameter
  Future<List> findMovies(String title) async {
    final String query = urlSearchBase + title;
    http.Response result = await http.get(query);
    // Have a result, then parse the data
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      // https://developers.themoviedb.org/3/movies/get-upcoming
      final moviesMap = jsonResponse['results'];
      // put each json object into a movie instance and add it to the movies list
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }


  Future<List> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;

    // returns a future that contains a response
    http.Response result = await http.get(upcoming);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      // for each item in the movies map, create a movie object
      // and add it to the list of movies
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
