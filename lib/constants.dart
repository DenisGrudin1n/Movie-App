import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_model.dart';

const Color yellowColor = Color.fromARGB(255, 254, 194, 0);
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color greyColor = Colors.grey;

const FontWeight boldFontWeight = FontWeight.bold;
const FontWeight mediumFontWeight = FontWeight.w500;

final List<Movie> topMovies = [
  Movie(
      id: 1,
      title: "Hitman's Wife's Bodyguard",
      genre: "Action, Comedy, Crime",
      overview:
          "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth...",
      posterPath: "assets/movie/movie_horizontal_cover.jpg",
      voteAverage: 3.5),
  Movie(
      id: 2,
      title: "Hitman's Wife's Bodyguard",
      genre: "Action, Comedy, Crime",
      overview:
          "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth...",
      posterPath: "assets/movie/movie_horizontal_cover.jpg",
      voteAverage: 4.0),
  Movie(
      id: 3,
      title: "Hitman's Wife's Bodyguard",
      genre: "Action, Comedy, Crime",
      overview:
          "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth...",
      posterPath: "assets/movie/movie_horizontal_cover.jpg",
      voteAverage: 3.5),
  Movie(
      id: 4,
      title: "Hitman's Wife's Bodyguard",
      genre: "Action, Comedy, Crime",
      overview:
          "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth...",
      posterPath: "assets/movie/movie_horizontal_cover.jpg",
      voteAverage: 4.5),
  Movie(
      id: 5,
      title: "Hitman's Wife's Bodyguard",
      genre: "Action, Comedy, Crime",
      overview:
          "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth...",
      posterPath: "assets/movie/movie_horizontal_cover.jpg",
      voteAverage: 4.0),
];

final List<Movie> latestMovies = [
  Movie(
      id: 1,
      title: "Hitman's Wife's Bodyguard",
      genre: "Action, Comedy, Crime",
      overview:
          "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth...",
      posterPath: "assets/movie/movie_vertical_cover.jpg",
      voteAverage: 3.5),
  Movie(
      id: 2,
      title: "Hitman's Wife's Bodyguard",
      genre: "Action, Comedy, Crime",
      overview:
          "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth...",
      posterPath: "assets/movie/movie_vertical_cover.jpg",
      voteAverage: 4.0),
  Movie(
      id: 3,
      title: "Hitman's Wife's Bodyguard",
      genre: "Action, Comedy, Crime",
      overview:
          "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth...",
      posterPath: "assets/movie/movie_vertical_cover.jpg",
      voteAverage: 3.5),
  Movie(
      id: 4,
      title: "Hitman's Wife's Bodyguard",
      genre: "Action, Comedy, Crime",
      overview:
          "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth...",
      posterPath: "assets/movie/movie_vertical_cover.jpg",
      voteAverage: 4.5),
  Movie(
      id: 5,
      title: "Hitman's Wife's Bodyguard",
      genre: "Action, Comedy, Crime",
      overview:
          "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth...",
      posterPath: "assets/movie/movie_vertical_cover.jpg",
      voteAverage: 4.0),
  Movie(
      id: 6,
      title: "Hitman's Wife's Bodyguard",
      genre: "Action, Comedy, Crime",
      overview:
          "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth...",
      posterPath: "assets/movie/movie_vertical_cover.jpg",
      voteAverage: 5.0),
];
