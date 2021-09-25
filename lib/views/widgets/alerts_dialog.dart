import 'package:filemanager/bootstrap.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertsDialog {
  // ...

  static DialogButton _dialogButton({
    required String text,
    required void Function() onPressed,
    Color color = Colors.grey,
  }) {
    return DialogButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      onPressed: onPressed,
      color: color,
    );
  }

  /// Method for showing alert confirmation
  static Alert confirm(
    BuildContext context, {
    required void Function() onConfirm,
    String title ="Konfirmasi dibutuhkan",
    String desc ="Konfirmasi dibutuhkan",
    String cancelText = "Batal",
    String confirmText = "Ya",
  }) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: desc,
      buttons: [
        _dialogButton(
          color: Colors.blue.shade400,
          text: cancelText,
          onPressed: () => Navigator.pop(context),
        ),
        _dialogButton(
          color: Colors.red.shade400,
          text: confirmText,
          onPressed: onConfirm,
        ),
      ],
    );
  }

  static Alert simpleAlert(
    BuildContext context, {
    AlertType type = AlertType.info,
    required String title,
    String? desc,
  }) {
    return Alert(
      context: context,
      type: type,
      title: title,
      desc: desc,
      buttons: [
        _dialogButton(
          text: 'Tutup',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  static Alert formDialog(
    BuildContext context, {
    required String title,
    String? desc,
    required List<Widget> children,
    required String textSubmit,
    required void Function() onSubmit,
  }) {
    return Alert(
      context: context,
      title: title,
      desc: desc,
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(children: children),
      ),
      buttons: [
        _dialogButton(
          text: 'Batal',
          onPressed: () => Navigator.pop(context),
          color: Colors.red.shade400,
        ),
        _dialogButton(
          text: textSubmit,
          onPressed: onSubmit,
          color: Colors.blue.shade600,
        ),
      ],
    );
  }
  

  static Alert costumeDialog(
    BuildContext context, {
    required String title,
    required List<Widget> children,
    List<DialogButton>? buttons,
  }) {
    return Alert(
      context: context,
      title: title,
      content: Column(children: children),
      buttons: buttons,
    );
  }

  // ...
}
