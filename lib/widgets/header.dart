import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/movie.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String title = ' ';
  String coverUrl = '';
  double rating = 0.0;

  int year = 0;

  String duration = '';
  String director = '';
  String summary = '';
  String video = '';

  Future getForYourMoves() async {
    Random random = Random();
    int randomNumber = random.nextInt(9);
    final response = await http
        .get(Uri.parse('https://salardev.com/devs/moviesProject/movies.json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        title = data['foryou'][randomNumber]['title'];
        coverUrl = data['foryou'][randomNumber]['cover'];
        rating = data['foryou'][randomNumber]['rating'];
        year = data['foryou'][randomNumber]['year'];
        duration = data['foryou'][randomNumber]['duration'];
        summary = data['foryou'][randomNumber]['summary'];
        director = data['foryou'][randomNumber]['director'];
        video = data['foryou'][randomNumber]['video'];
      });
    } else {
      if (kDebugMode) {
        print('A network error occurred');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getForYourMoves();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(
              title: title,
              coverUrl: coverUrl,
              rating: rating,
              year: year,
              duration: duration,
              director: director,
              summary: summary,
              video: video,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: coverUrl == ''
                ? Container()
                : Image.network(
                    coverUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: 500,
                height: 250,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
