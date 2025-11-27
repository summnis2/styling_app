import 'package:flutter/material.dart';

class CategoryDetail extends StatefulWidget {
  final String category;
  final List<String> imageUrls;
  final Function(String) onFavoriteToggle;

  const CategoryDetail({
    Key? key,
    required this.category,
    required this.imageUrls,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  List<String> sortedImageUrls = [];
  String sortOption = '최신순';
  Map<String, bool> favoriteStatus = {};

  @override
  void initState() {
    super.initState();
    sortedImageUrls = widget.imageUrls;
    for (String url in widget.imageUrls) {
      favoriteStatus[url] = false; // 초기 즐겨찾기 상태를 false로 설정
    }
  }

  void sortImages() {
    setState(() {
      if (sortOption == '최신순') {
        sortedImageUrls.sort((a, b) => b.compareTo(a)); // 최신순
      } else if (sortOption == '오래된순') {
        sortedImageUrls.sort((a, b) => a.compareTo(b)); // 오래된순
      } else if (sortOption == 'LIKE') {}
    });
  }

  void toggleFavorite(String imageUrl) {
    setState(() {
      favoriteStatus[imageUrl] = !favoriteStatus[imageUrl]!;
    });
    widget.onFavoriteToggle(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.category),
        actions: [
          DropdownButton<String>(
            value: sortOption,
            items: <String>['최신순', '오래된순', 'LIKE']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                sortOption = newValue!;
                sortImages();
              });
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: sortedImageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          String imageUrl = sortedImageUrls[index];
          bool isFavorite = favoriteStatus[imageUrl] ?? false;
          return Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                  onPressed: () {
                    toggleFavorite(imageUrl);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
