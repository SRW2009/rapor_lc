
import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final List<Widget> contents;

  const BaseDialog({Key? key, required this.title, required this.contents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title, style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black), textAlign: TextAlign.start),
                const SizedBox(height: 24.0),
                for (var content in contents) content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BaseDialogActions extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final Function()? onSave;
  final String posButtonText;

  const BaseDialogActions({Key? key, this.formKey, required this.onSave, this.posButtonText='SIMPAN'}) : super(key: key);

  @override
  State<BaseDialogActions> createState() => _BaseDialogActionsState();
}

class _BaseDialogActionsState extends State<BaseDialogActions> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          child: const Text('BATAL'),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        TextButton(
          child: Text(widget.posButtonText),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
          ),
          onPressed: (widget.onSave == null) ? null : () {
            if (widget.formKey != null && widget.formKey!.currentState!.validate() || widget.formKey == null) {
              widget.onSave!();
              Navigator.pop(context, true);
            }
          },
        ),
      ],
    );
  }
}
