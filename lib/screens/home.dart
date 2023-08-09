import 'package:flutter/material.dart';
import 'package:moviesapp/provider/movie_provider.dart';
import 'package:moviesapp/widgets/header.dart';
import 'package:provider/provider.dart';

import '../widgets/genre.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<MovieProvider>(context).fetchMovies();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),
            Genre(title: 'Action', movies: Provider.of<MovieProvider>(context).actionMovies,),
            Genre(title: 'Drama', movies: Provider.of<MovieProvider>(context).dramaMovies,),
            Genre(title: 'Comedy', movies: Provider.of<MovieProvider>(context).comedyMovies,),
            Genre(title: 'Adventure', movies: Provider.of<MovieProvider>(context).adventureMovies,),
            Genre(title: 'Animation', movies: Provider.of<MovieProvider>(context).animationMovies,),
          ],
        ),
      ),
    );
  }
}
