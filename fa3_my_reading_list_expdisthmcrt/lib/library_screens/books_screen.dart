import 'package:flutter/material.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/chart/reading_chart.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/library_screens/books_list.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/library_screens/new_book.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/commons/app_theme.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key, required this.onSwitchBack});

  final VoidCallback onSwitchBack;

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final List<Book> _registeredBooks = [...initialBooks];

  int _countForStatus(ReadingStatus status) {
    return _registeredBooks
        .where((book) => book.status == status)
        .length;
  }

  void _openBookModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => NewBook(addBook: _addBook),
    );
  }

  void _addBook(Book book) {
    setState(() {
      _registeredBooks.add(book);
    });
  }

  void _updateStatus(Book book, ReadingStatus status) {
    setState(() {
      book.status = status;
    });
  }

  void _removeBook(Book book) {
    final index = _registeredBooks.indexOf(book);

    setState(() {
      _registeredBooks.remove(book);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${book.title}" removed.'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredBooks.insert(index, book);
            });
          },
        ),
      ),
    );
  }

  void _toggleThemeMode() {
    themeModeNotifier.value =
        themeModeNotifier.value == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    final finished = _countForStatus(ReadingStatus.finished);
    final toRead = _countForStatus(ReadingStatus.wantToRead);
    final reading = _countForStatus(ReadingStatus.reading);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: widget.onSwitchBack,
          tooltip: 'Back to Home',
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('My Reading List', style: Theme.of(context).textTheme.titleLarge,),
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, themeMode, child) {
              return IconButton(
                onPressed: _toggleThemeMode,
                tooltip: themeMode == ThemeMode.light
                    ? 'Switch to Dark Mode'
                    : 'Switch to Light Mode',
                icon: Icon(
                  themeMode == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
              );
            },
          ),
          IconButton(
            onPressed: _openBookModal,
            tooltip: 'Add a book',
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cielo\'s Reading Summary',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _SummaryItem(
                          label: 'Total',
                          count: _registeredBooks.length,
                          icon: Icons.library_books,
                        ),
                        _SummaryItem(
                          label: 'To Read',
                          count: toRead,
                          icon: Icons.bookmark_border,
                        ),
                        _SummaryItem(
                          label: 'Reading',
                          count: reading,
                          icon: Icons.menu_book,
                        ),
                        _SummaryItem(
                          label: 'Finished',
                          count: finished,
                          icon: Icons.check_circle_outline,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ReadingChart(books: _registeredBooks),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _registeredBooks.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_stories,
                              size: 64,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No books in your reading list yet.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Tap the add button above to add your first book and start tracking your reading journey!',
                              textAlign: TextAlign.center,
                            ),
                  
                          ],
                        ),
                      ),
                    )
                  : BookList(
                      books: _registeredBooks,
                      updateStatus: _updateStatus,
                      removeBook: _removeBook,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.count,
    required this.icon,
  });

  final String label;
  final int count;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 4),
          Text(
            '$count',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
