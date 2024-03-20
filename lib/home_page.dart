import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dog_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DogService>(
      builder: (context, dogService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '멍멍이들',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.cyan,
            actions: [
              IconButton(
                onPressed: () {
                  // 아이콘 버튼 눌렀을 때 동작
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CreatePage()),
                  );
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            children: List.generate(dogService.dogImages.length, (index) {
              String dogImage = dogService.dogImages[index];
              return GestureDetector(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        dogImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 8,
                        right: 8,
                        child: Icon(
                          Icons.favorite,
                          color: dogService.favoriteDogImages.contains(dogImage)
                              ? Colors.red
                              : Colors.transparent,
                        ))
                  ],
                ),
                onTap: () {
                  dogService.toggleFavoriteImage(dogImage);
                },
              );
            }),
          ),
        );
      },
    );
  }
}

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // TextField의 값을 가져올 때 사용
  TextEditingController textController = TextEditingController();

  // 경고 메세지
  String? error;

  @override
  Widget build(BuildContext context) {
    DogService dogService = Provider.of<DogService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "좋아요 리스트",
          style: TextStyle(color: Colors.white),
        ),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: EdgeInsets.all(8),
        children: List.generate(dogService.favoriteDogImages.length, (index) {
          String dogImage = dogService.favoriteDogImages[index];
          return GestureDetector(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    dogImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            onTap: () {
              dogService.toggleFavoriteImage(dogImage);
            },
          );
        }),
      ),
    );
  }
}
