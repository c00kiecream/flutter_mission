import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DogService extends ChangeNotifier {
  SharedPreferences prefs;
  List<String> dogImages = [];
  List<String> favoriteDogImages = [];

  DogService(this.prefs) {
    getRandomDogImages();
    getFavoriteDogImages();
  }

  void getRandomDogImages() async {
    String path =
        "https://api.thedogapi.com/v1/images/search?limit=10&mime_types=gif";
    var result = await Dio().get(path);
    for (int i = 0; result.data.length > i; i++) {
      var map = result.data[i];
      dogImages.add(map['url']);
    }
    notifyListeners();
  }

  void toggleFavoriteImage(String dogImage) {
    if (favoriteDogImages.contains(dogImage)) {
      favoriteDogImages.remove(dogImage);
    } else {
      favoriteDogImages.add(dogImage);
    }
    prefs.setStringList('favoriteDogImages', favoriteDogImages);
    notifyListeners();
  }

  List<String> getFavoriteDogImages() {
    favoriteDogImages = prefs.getStringList('favoriteDogImages') ?? [];
    return favoriteDogImages;
  }
}
