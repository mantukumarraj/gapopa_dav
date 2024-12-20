import 'package:flutter/material.dart';

class DraggableIconsScreen extends StatefulWidget {
  const DraggableIconsScreen({super.key});

  @override
  _DraggableIconsScreenState createState() => _DraggableIconsScreenState();
}

class _DraggableIconsScreenState extends State<DraggableIconsScreen> {
  List<Color> containerColors = [
    const Color(0xffea1e63),
    const Color(0xfffd5822),
    const Color(0xff3f51b5),
    const Color(0xfffc5727),
    const Color(0xffcddc37),
  ];

  List<IconData> icons = [
    Icons.person,
    Icons.message,
    Icons.call,
    Icons.camera,
    Icons.photo,
  ];

  List<bool> isDragging = List.filled(5, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable Icons'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final iconSize = constraints.maxWidth * 0.15;
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black12,
                ),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(icons.length, (index) {
                    return Visibility(
                      visible: !isDragging[index],
                      child: DragTarget<int>(
                        onWillAccept: (data) => true,
                        onAccept: (draggedIndex) {
                          setState(() {
                            // Swap the colors and icons
                            final tempColor = containerColors[index];
                            final tempIcon = icons[index];
                            containerColors[index] = containerColors[draggedIndex];
                            icons[index] = icons[draggedIndex];
                            containerColors[draggedIndex] = tempColor;
                            icons[draggedIndex] = tempIcon;

                            isDragging[draggedIndex] = false;
                          });
                        },
                        builder: (context, candidateData, rejectedData) {
                          return Draggable<int>(
                            data: index,
                            feedback: Container(
                              width: iconSize,
                              height: iconSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: containerColors[index].withOpacity(0.8),
                              ),
                              child: Center(
                                child: Icon(
                                  icons[index],
                                  color: Colors.white,
                                  size: iconSize * 0.5,
                                ),
                              ),
                            ),
                            onDragStarted: () {
                              setState(() {
                                isDragging[index] = true;
                              });
                            },
                            onDraggableCanceled: (_, __) {
                              setState(() {
                                isDragging[index] = false;
                              });
                            },
                            onDragCompleted: () {
                              setState(() {
                                isDragging[index] = false;
                              });
                            },
                            child: Container(
                              width: iconSize,
                              height: iconSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: containerColors[index],
                              ),
                              child: Center(
                                child: Icon(
                                  icons[index],
                                  color: Colors.white,
                                  size: iconSize * 0.5,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
