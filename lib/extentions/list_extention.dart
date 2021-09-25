import 'package:filemanager/bootstrap.dart';

extension ListExtention<E> on List<E> {
  // fungsi untuk menghapus list item setelah index yg diberikan
  List<E> removeAfter(int index) {
    List<E> newList = [];

    if (index > this.length)
      throw new Exception('tidak ada item yg ditemukan dengan index $index');

    for (var i = 0; i <= this.length; i++) {
      newList.add(this[i]);
      if (index == i) break;
    }

    return newList;
  }

  // fungsi untuk print item di dalam list
  // note: yg dibaca hanya stringable object
  void printItems() => pList(this);

  // fungsi untuk mengecek jika ada nilai dlm list
  // note: hanya berlaku untuk tipe data string,number,boolean
  bool haveValue(E value) {
    for (E _value in this) {
      if (_value == value) {
        return true;
      }
    }
    return false;
  }

  /// method for get the index of value in list,
  /// this wll return [int] which is index of list
  /// otherwise return null
  int? getIndexOfValue(E value) {
    for (int i = 0; i < this.length; i++) {
      if (value == this[i]) return i;
    }
    return null;
  }

  // ...
}
