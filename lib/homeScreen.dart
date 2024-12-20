import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of image paths
  List<String> images = [
    'assets/images/download.jpeg',
    'assets/images/1.png',
    'assets/images/images.png',
    'assets/images/5977575.png',
    'assets/images/3.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Reorder Images Anywhere',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            color: Colors.cyan,
            alignment: Alignment.center,

            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length + 1, // +1 for the "drop area" at the end
                    (index) {
                  if (index < images.length) {
                    // Image Item
                    return Draggable<int>(
                      data: index,
                      feedback: Image.asset(
                        images[index],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          images[index],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: DragTarget<int>(
                        onAccept: (int oldIndex) {
                          setState(() {
                            // Move image to the new index
                            final String movedImage = images.removeAt(oldIndex);
                            images.insert(index, movedImage);
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.asset(
                              images[index],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    // Drop Area at the end
                    return DragTarget<int>(
                      onAccept: (int oldIndex) {
                        setState(() {
                          // Move image to the end
                          final String movedImage = images.removeAt(oldIndex);
                          images.add(movedImage);
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Container(

                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
