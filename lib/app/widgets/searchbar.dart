
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/widgets/form_field/form_decoration.dart';

typedef SearchOnSubmitted = void Function(String)?;

Widget Searchbar(SearchOnSubmitted function) => Padding(
  padding: const EdgeInsets.only(bottom: 8.0),
  child: TextField(
    decoration: inputDecoration.copyWith(
      hintText: 'Search...',
      prefixIcon: const Icon(Icons.search),
    ),
    onSubmitted: function,
  ),
);