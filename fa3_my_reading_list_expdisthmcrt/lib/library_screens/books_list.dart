
import 'package:flutter/material.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/library_screens/book_items.dart';

class BookList extends StatelessWidget {
  const BookList({
    super.key,
    required this.books,
    required this.updateStatus,
    required this.removeBook,
  });

  final List<Book> books;
  final void Function(Book book, ReadingStatus status) updateStatus;
  final void Function(Book book) removeBook;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];

        return Dismissible(
          key: ValueKey(book.id),
          background: Container(
            color: Theme.of(context)
                .colorScheme
                .error
                .withOpacity(0.75),
            margin: Theme.of(context).cardTheme.margin,
          ),
          onDismissed: (direction) {
            removeBook(book);
          },
         child: BookItem(
          book: book,
          updateReadingStatus: updateStatus,
        ),
        );
      },
    );
  }
}
