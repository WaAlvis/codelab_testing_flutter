

import 'package:test/test.dart';
import 'package:testing_app/models/favorites.dart';

void main(){
  group('Testing App Provider', () {
      var favorites =  Favorites();

    test('A item should be added', () {
      int num = 35;
      favorites.add(num);
      expect(favorites.items.contains(num), true);
    });

    test('A item should be removed', () {
      int num = 45;
      favorites.add(num);
      expect(favorites.items.contains(num),true);

      favorites.remove(num);
      expect(favorites.items.contains(num), false);
    });
  });
}