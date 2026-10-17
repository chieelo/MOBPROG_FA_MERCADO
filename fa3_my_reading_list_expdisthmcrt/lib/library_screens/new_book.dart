import 'package:flutter/material.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/services.dart';

class NewBook extends StatefulWidget {
  const NewBook({
    super.key,
    required this.addBook,
  });

  final void Function(Book book) addBook;

  @override
  State<NewBook> createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _pagesnumberController = TextEditingController();

  int _rating = 5;
  Genre _selectedGenre = Genre.defaults.first;
  ReadingStatus _selectedStatus = ReadingStatus.wantToRead;

  void _addNewBook() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final book = Book(
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      pages: int.parse(_pagesnumberController.text.trim()),
      rating: _rating,
      genre: _selectedGenre,
      status: _selectedStatus,
    );

    widget.addBook(book);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _pagesnumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        24,
        16,
        16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add a New Book',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Book Title',
                  prefixIcon: Icon(Icons.book),
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kindly enter the book title.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Author',
                  prefixIcon: Icon(Icons.person),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the author\'s name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pagesnumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Number of Pages',
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (value) {
                  final pages = int.tryParse(value ?? '');

                  if (pages == null || pages <= 0) {
                    return 'May libro bang zero o negative ang pages? aucn mo baks';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Genre>(
                initialValue: _selectedGenre,
                decoration: const InputDecoration(
                  labelText: 'Genre',
                ),
                items: Genre.defaults.map((genre) {
                  return DropdownMenuItem<Genre>(
                    value: genre,
                    child: Text(genre.name),
                  );
                }).toList(),
                onChanged: (genre) {
                  if (genre != null) {
                    setState(() => _selectedGenre = genre);
                  }
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ReadingStatus>(
                initialValue: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Reading Status',
                ),
                items: ReadingStatus.values.map((status) {
                  return DropdownMenuItem<ReadingStatus>(
                    value: status,
                    child: Text(status.label),
                  );
                }).toList(),
                onChanged: (status) {
                  if (status != null) {
                    setState(() => _selectedStatus = status);
                  }
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: _rating,
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  prefixIcon: Icon(Icons.rate_review),
                ),
                items: List.generate(5, (index) {
                  final rating = index + 1;

                  return DropdownMenuItem<int>(
                    value: rating,
                    child: Row(
                      children: [
                        Text('$rating '),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                      ],
                    ),
                  );
                }),
                onChanged: (rating) {
                  if (rating != null) {
                    setState(() => _rating = rating);
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _addNewBook,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Book'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}