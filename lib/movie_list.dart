import 'package:flutter/material.dart';
import 'http_helper.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String result;
  HttpHelper helper;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Movies');

  int moviesCount;
  List movies;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }


  Future search(text) async {
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  // Will pull data from The Movie Database API and rebuild
  Future initialize() async {
    movies = List();
    movies = await helper.getUpcoming();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  // value is the future returned by getUpcoming()
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
        appBar: AppBar(
          title: searchBar,
          actions: [
            IconButton(
              icon: visibleIcon,
              onPressed: () {
                setState(() {
                  // change icon appearance
                  if (this.visibleIcon.icon == Icons.search) {
                    this.visibleIcon = Icon(Icons.cancel);
                    this.searchBar = TextField(
                      textInputAction: TextInputAction.search,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                      onSubmitted: (String text) {
                        //search function, passing in data from TextField
                        search(text);
                      },
                    );
                  } else {
                    setState(() {
                      this.visibleIcon = Icon(Icons.search);
                      this.searchBar = Text('Movies');
                    });
                  }
                });
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
            itemBuilder: (BuildContext context, int position) {
              if (movies[position].posterPath != null) {
                image = NetworkImage(iconBase + movies[position].posterPath);
              } else {
                image = NetworkImage(defaultImage);
              }
              // Card is a widget used to display content
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: image,
                  ),
                  title: Text(movies[position].title),
                  subtitle: Text('Released: ' +
                      movies[position].releaseDate +
                      ' - Vote: ' +
                      movies[position].voteAverage.toString()),
                  // Navigate to details
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        // Pass the ith movie to the details screen
                        builder: (movie) => MovieDetail(movies[position]));
                    Navigator.push(context, route);
                  },
                ),
              );
            }));
  }
}
