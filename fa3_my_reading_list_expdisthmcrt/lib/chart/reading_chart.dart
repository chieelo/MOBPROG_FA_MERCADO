import 'package:fa3_my_reading_list_expdisthmcrt/models/genre_bucket.dart';
import 'package:flutter/material.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/chart/chart_bar.dart';

class ReadingChart extends StatelessWidget {
  const ReadingChart({
    super.key,
    required this.books,
  });

  final List<Book> books;

  int countForGenre(Genre genre) {
    return books.where((book) => book.genre == genre).length;
  }

  @override
  Widget build(BuildContext context) {
   final genreBuckets = Genre.defaults
    .map((genre) => GenreBucket.forGenre(genre, books))
    .toList();

  final maxCount = genreBuckets.isEmpty
      ? 0
      : genreBuckets
          .map((bucket) => bucket.totalBooks)
          .reduce((a, b) => a > b ? a : b);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.surfaceContainerHighest,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Books by Genre',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                )
          ),
          const SizedBox(height: 12),
          
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final bucket in genreBuckets)
                  ChartBar(
                    count: bucket.totalBooks,
                    label: bucket.genre.name,
                    fill: maxCount == 0
                        ? 0
                        : bucket.totalBooks / maxCount,
                  ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}