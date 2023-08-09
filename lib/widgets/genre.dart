import 'package:flutter/material.dart';
import 'package:moviesapp/screens/movie.dart';

class Genre extends StatelessWidget {

  final String title;
  final List movies;

  const Genre({Key? key, required this.title, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                  final item = movies[index];
                  var image = Container(
                  width: 100.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: NetworkImage(item['cover']),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
                  return Padding(
                  padding: const EdgeInsets.only(right: 10),
                   child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetails(
                              title: item['title'],
                              coverUrl: item['cover'],
                              rating: item['rating'],
                              year: item['year'],
                              duration: item['duration'],
                              director: item['director'],
                              summary: item['summary'],
                              video: item['video']),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 150,
                      child: image,
                    ),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
