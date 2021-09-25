import 'package:filemanager/bootstrap.dart';
import 'package:filemanager/configs/_configs.dart';

// shorthand of printText
void pText(Object text) => printText(text);

// Usefull for printing a text to the console/terminal
@deprecated
void printText(Object text) {
  if (!App.debug) return;

  print(text.toString());
  // ...
}

// shorthand of printTexts
void pList(List<dynamic> list) => printTexts(list);

// Usefull for printiing a collection/list of text to the console/terminal
@deprecated
void printTexts(List<dynamic> list) {
  if (!App.debug) return;
  list.forEach((dynamic e) {
    print(e.toString());
  });
  // ...
}
