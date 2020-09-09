import 'package:flutter/material.dart';
import 'models/movie.dart';

class MovieDetail extends StatelessWidget {
  final String imagePath = 'https://image.tmdb.org/t/p/w500/';
  final Movie movie;
  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    String path;

    // use screen height to decide image size
    double height = MediaQuery.of(context).size.height;

    // assign image if available otherwise default
    if (movie.posterPath != null){
      path = imagePath + movie.posterPath;
      print(path);
    } else {
      path = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Movie image
              Container(
                padding: EdgeInsets.all(16),
                height: height / 1.5,
                // Image is found at path
                child: Image.network(path)),
              // Movie description
              Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(movie.overview),
            )],

          )
        )
      ),
    );
  }
}
