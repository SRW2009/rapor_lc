
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'form_decoration.dart';

class FormDropdownSearch<E> extends StatelessWidget {
  final String label;
  final bool Function(E? obj1, E? obj2)? compareFn;
  final Future<List<E>> Function(String? query)? onFind;
  final String Function(E suggestion) showItem;
  final void Function(E suggestion) onPick;
  final String? Function(E?)? validator;
  final E? Function()? selectedItem;

  const FormDropdownSearch({
    Key? key, required this.label,
    required this.compareFn, required this.onFind,
    required this.showItem, required this.onPick,
    this.validator, this.selectedItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: DropdownSearch<E>(
        mode: Mode.MENU,
        showSelectedItems: true,
        showSearchBox: true,
        selectedItem: (selectedItem != null) ? selectedItem!() : null,
        onFind: onFind,
        itemAsString: (o) => (o != null) ? showItem(o) : '',
        onChanged: (o) => (o != null) ? onPick(o) : null,
        dropdownSearchDecoration: inputDecoration.copyWith(
          labelText: label,
        ),
        compareFn: compareFn,
        validator: (s) {
          if (validator != null) return validator!(s);

          if (s == null) return 'Harus diisi';
          return null;
        },
      ),
    );
  }
}