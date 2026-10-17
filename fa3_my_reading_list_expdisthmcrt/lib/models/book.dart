
import 'package:flutter/material.dart';

enum ReadingStatus {
  wantToRead,
  reading,
  finished,
}

extension ReadingStatusExtension on ReadingStatus {
  String get label {
    switch (this) {
      case ReadingStatus.wantToRead:
        return 'Want to Read';
      case ReadingStatus.reading:
        return 'Currently Reading';
      case ReadingStatus.finished:
        return 'Finished';
    }
  }
}

class Genre {
  const Genre({
    required this.name,
    required this.icon,
  });

  final String name;
  final IconData icon;

  static const fiction = Genre(
    name: 'Fiction',
    icon: Icons.book,
  );

  static const nonFiction = Genre(
    name: 'Non-Fiction',
    icon: Icons.fact_check,
  );

  static const fantasy = Genre(
    name: 'Fantasy',
    icon: Icons.auto_awesome,
  );

  static const biography = Genre(
    name: 'Biography',
    icon: Icons.person,
  );

  static const romance = Genre(
    name: 'Romance',
    icon: Icons.heart_broken,
  );

  static const mystery = Genre(
    name: 'Mystery',
    icon: Icons.search,
  );

  static const List<Genre> defaults = [
    fiction,
    nonFiction,
    fantasy,
    biography,
    romance,
    mystery,
  ];
}

class Book {
  Book({
    required this.title,
    required this.author,
    required this.pages,
    required this.rating,
    required this.genre,
    required this.status,
  }) : id = DateTime.now().microsecondsSinceEpoch.toString();

  final String id;
  final String title;
  final String author;
  final int pages;
  final int rating;
  final Genre genre;

  ReadingStatus status;
}


final List<Book> initialBooks = [
  Book(
    title: 'Para Kay B',
    author: 'Ricky Lee',
    pages: 240,
    rating: 5,
    genre: Genre.romance,
    status: ReadingStatus.finished,
  ),
  Book(
    title: 'I Want to Die but I Want to Eat Tteokbokki',
    author: 'Baek Sehee',
    pages: 208,
    rating: 5,
    genre: Genre.nonFiction,
    status: ReadingStatus.reading,
  ),
  Book(
    title: 'Ikigai',
    author: 'Héctor García and Francesc Miralles',
    pages: 208,
    rating: 5,
    genre: Genre.nonFiction,
    status: ReadingStatus.finished,
  ),
  Book(
    title: 'Before the Coffee Gets Cold',
    author: 'Toshikazu Kawaguchi',
    pages: 213,
    rating: 5,
    genre: Genre.fiction,
    status: ReadingStatus.reading,
  ),
  Book(
    title: 'I Decided to Live as Me',
    author: 'Kim Suhyun',
    pages: 288,
    rating: 5,
    genre: Genre.nonFiction,
    status: ReadingStatus.wantToRead,
  ),
];
