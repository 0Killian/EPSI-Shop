import 'package:flutter/foundation.dart';

import '../models/article.dart';

class Cart extends ChangeNotifier {
  final List<Article> _items = [];

  List<Article> get items => _items;
  int get itemCount => _items.length;
  num get total => _items.fold(0.0, (total, item) => total + item.price) * 1.2;

  void addItem(Article article) {
    _items.add(article);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}