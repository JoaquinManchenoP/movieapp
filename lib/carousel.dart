import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'userMovie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

Future<UserMovie> getMovie(String title) async {
  final String url = 'http://www.omdbapi.com/?t=$title&apikey=cccbf603';
  final response = await http.post(url, body: {
    title: 'Title',
  });

  final String responseString = response.body;

  print(responseString);

  return userMovieFromJson(responseString);
}

class _CarouselState extends State<Carousel> {
  UserMovie _movie;
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF35477d),
        title: Text('Mi-Jin Movies'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _movie == null
                ? Container()
                : SingleChildScrollView(
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        color: Color(0xFF35477d),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(5.0, 5.0),
                              ),
                            ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network('${_movie.poster}'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            Container(
              height: 45,
              width: 414,
              color: Color(0xFF35477d),
              child: Center(
                child: Container(
                  width: 350,
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                    hintText: 'Movie Title',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 25, top: 10),
                              child: FloatingActionButton(
                                backgroundColor: Colors.transparent,
                                onPressed: () async {
                                  final String title = titleController.text;

                                  final UserMovie movie = await getMovie(title);

                                  setState(() {
                                    _movie = movie;
                                  });
                                },
                                child: Icon(Icons.search),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Color(0xFF35477d),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _movie == null
                        ? Container()
                        : Center(
                            child: Container(
                              child: CarouselSlider(
                                options: CarouselOptions(height: 140.0),
                                items: [
                                  _movie.title,
                                  _movie.actors,
                                  _movie.imdbRating,
                                  _movie.year,
                                ].map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF086972)
                                                  .withOpacity(0.5),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40.0),
                                                topRight: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(40.0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                              )),
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                    height: 150,
                                                    width: 280,
                                                    child: Center(
                                                      child: Text(
                                                        '$i',
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
