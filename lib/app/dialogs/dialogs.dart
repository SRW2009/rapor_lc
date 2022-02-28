
import 'package:flutter/material.dart';

import 'base_dialog.dart';

class DeleteDialog extends StatelessWidget {
  final List<String> Function() showDeleted;
  final Function() onSave;

  const DeleteDialog({Key? key, required this.showDeleted, required this.onSave}) : super(key: key);

  String get _getContents {
    String content = showDeleted().first;
    for (var i = 1; i < showDeleted().length; ++i) {
      var o = showDeleted()[i];
      content += ', $o';
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    if (showDeleted().isNotEmpty) {
      return BaseDialog(
        title: 'PERHATIAN',
        contents: [
          Text('Anda yakin ingin menghapus $_getContents?'),
          const SizedBox(height: 8.0),
          BaseDialogActions(onSave: onSave, posButtonText: 'YA'),
        ],
      );
    }

    return BaseDialog(
      title: 'PERHATIAN',
      contents: [
        const Text('Pilih sesuatu untuk dihapus terlebih dahulu.'),
        const SizedBox(height: 8.0),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {Navigator.pop(context, false);},
              child: const Text('OK'),
            ),
          ],
        ),
      ],
    );
  }
}
