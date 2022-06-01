
import 'package:flutter/material.dart';
import 'package:rapor_lc/app/dialogs/base_dialog.dart';
import 'package:rapor_lc/app/widgets/form_field/form_decoration.dart';

class LogsDialog extends StatefulWidget {
  final Function() onClose;

  const LogsDialog({Key? key, required this.onClose}) : super(key: key);

  @override
  State<LogsDialog> createState() => LogsDialogState();
}

class LogsDialogState extends State<LogsDialog> {
  TextEditingController _messageCon = TextEditingController();

  void updateLog(String s) {
    setState(() {
      _messageCon.text = s;
    });
  }

  void addLine(String s) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        _messageCon.text += s;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return logsDialog(
      context: context,
      title: 'Logs',
      contents: [
        Container(
          decoration: containerDecoration,
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            height: 260,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: TextField(
                controller: _messageCon,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                readOnly: true,
              ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('TUTUP'),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
              ),
              onPressed: widget.onClose,
            ),
          ],
        ),
      ],
    );
  }
}
