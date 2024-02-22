import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class imageMapping extends StatefulWidget {
  const imageMapping({super.key});

  @override
  State<imageMapping> createState() => _imageMappingState();
}

class _imageMappingState extends State<imageMapping> {
  bool cropping = false;

  late Rect rect = Rect.fromCenter(
    center: Offset(MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 2),
    width: 52,
    height: 90,
  );

  late Rect cropRect = rect;
  int selectedIndex = -1;
  int isImageHover = -1;
  int clickCounting = 0;
  bool isUserAnswer = false;
  String isResult = '';
  String correctAnswers = 'BOY Image';
  String _enteredValue = '';
  bool isAnswer = false;
  bool isContainerVisible = true;
  bool reloadClicked = true;
  int incorrectanswercount = 0;
  bool borderColorHighlighting = false;

  GlobalKey imageKey = GlobalKey();
  List<Rect> boxRects = []; // Initialize an empty list

  comparingForCorrectOption() {
    borderColorHighlighting = false;
    if (correctAnswers == _enteredValue) {
      isAnswer = true;

      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          isUserAnswer = false;
        });
      });
      setState(() {
        borderColorHighlighting = true;
        selectedIndex = -1;
      });

      return 'correctanswer';
    } else {
      isAnswer = false;
      incorrectanswercount++;

      if (incorrectanswercount == 3) {
        setState(() {
          selectedIndex = -1;
          borderColorHighlighting = true;
          isImageHover = -1;
        });
      }
      return 'incorrectanswer';
    }
  }

  resetVariable() {
    setState(() {
      selectedIndex = -1;
      isImageHover = -1;
      clickCounting = 0;
      isUserAnswer = false;
      isResult = '';
      correctAnswers = 'BOY Image';
      _enteredValue = '';
      reloadClicked = true;
      isAnswer = false;
      isContainerVisible = true;
      incorrectanswercount = -1;
      borderColorHighlighting = false;
    });
  }

  void toggleContainerVisibility() {
    setState(() {
      isContainerVisible = !isContainerVisible;
    });
  }

  List<Map<String, dynamic>> qAnswerList = [];

  addEmptyOption(
      String title, double width, double height, double left, double top) {
    // Calculate initial positions relative to the background image
    double bgWidth = MediaQuery.of(context).size.width;
    double bgHeight = MediaQuery.of(context).size.height;
    double initialLeft = bgWidth * left / 100;
    double initialTop = bgHeight * top / 50;

    setState(() {
      qAnswerList.add({
        'title': title,
        'width': width,
        'height': height,
        'left': left,
        'top': top,
      });
      boxRects.add(Rect.fromCenter(
        center: Offset(initialLeft, initialTop),
        width: width,
        height: height,
      ));
    });
  }

  addMultipleEmptyOptions(int count) {
    for (int i = 0; i < count; i++) {
      String title = 'Images ${qAnswerList.length + 1}';
      double width = 52;
      double height = 90;
      double left = (5 + i * 10);
      double top = (5 + i * 10);

      addEmptyOption(title, width, height, left, top);
    }
  }

  Widget feedbackpanel() {
    debugPrint('qAnswerListvalues $qAnswerList');
    return Container(
      width: 498,
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
                onTap: toggleContainerVisibility,
                child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.lightGreen[400],
                    child: Icon(
                      isContainerVisible
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 27,
                    ))),
          ),
          Visibility(
            visible: isContainerVisible,
            child: Container(
              height: 75,
              width: 530,
              color: Colors.lightGreen[400],
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Your Correct answer is :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' $correctAnswers',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void renameOptionTitle(int index, String newTitle) {
  //   setState(() {
  //     qAnswerList[index]['title'] = newTitle;
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        height: 488,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 80,
              // width: 500,
              alignment: Alignment.centerLeft,
              color: Colors.lightGreen[400],
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    const Text(
                      'Choose a Boy Image ?',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    if (isUserAnswer)
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          height: 40,
                          child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  if (isResult == 'incorrectanswer') {
                                    clickCounting++;
                                    if (clickCounting == 2) {
                                      reloadClicked = true;
                                    } else if (incorrectanswercount == 3 ||
                                        clickCounting > 2) {
                                      resetVariable();
                                      isResult = '';
                                    }
                                  }

                                  isResult = comparingForCorrectOption();
                                });
                              },
                              color: isResult == ''
                                  ? Colors.white
                                  : isResult == 'correctanswer'
                                      ? Color.fromARGB(255, 32, 112, 36)
                                      : (clickCounting == 2 ||
                                              incorrectanswercount == 3)
                                          ? Colors.orange
                                          : (clickCounting >= 2 ||
                                                  incorrectanswercount > 3)
                                              ? null
                                              : Colors.red[600],
                              textColor: isResult == ''
                                  ? isResult == 'correctanswer'
                                      ? Colors.black
                                      : Colors.black
                                  : (clickCounting == 2 ||
                                          incorrectanswercount == 3)
                                      ? Colors.white
                                      : (clickCounting >= 2)
                                          ? null
                                          : Colors.white,
                              shape: const CircleBorder(),
                              child: Icon(
                                isResult == ''
                                    ? Icons.check
                                    : isResult == 'correctanswer'
                                        ? Icons.check
                                        : (clickCounting == 2 ||
                                                incorrectanswercount == 3)
                                            ? Icons.replay
                                            : (clickCounting >= 2 ||
                                                    incorrectanswercount > 3)
                                                ? null
                                                : Icons.close,
                                size: 20,
                              )))
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 280,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      height: 350,
                      width: 350,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/backgroundimage.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: IgnorePointer(
                        ignoring: (isResult == 'correctanswer')
                            ? true
                            : (incorrectanswercount == 3)
                                ? true
                                : false,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            for (int i = 0; i < qAnswerList.length; i++)
                              TransformableBox(
                                rect: boxRects[i],
                                onChanged: (result) {
                                  setState(() {
                                    boxRects[i] = result.rect;

                                    // Update the boxRects value

                                    // Update the corresponding qAnswerList values
                                    qAnswerList[i]['left'] =
                                        boxRects[i].left.toInt();
                                    qAnswerList[i]['top'] =
                                        boxRects[i].top.toInt();
                                    qAnswerList[i]['width'] =
                                        boxRects[i].width.toInt();
                                    qAnswerList[i]['height'] =
                                        boxRects[i].height.toInt();
                                  });
                                },
                                contentBuilder: (BuildContext context,
                                    Rect rect, Flip flip) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _enteredValue =
                                              qAnswerList[i]['title'];
                                          isUserAnswer = true;
                                          if (isResult == 'incorrectanswer' ||
                                              incorrectanswercount <= 3) {
                                            isResult = '';
                                          }
                                          if (isResult == 'correctanswer' ||
                                              incorrectanswercount > 3) {
                                            selectedIndex = -1;
                                          }
                                          if (isResult == 'incorrectanswer' ||
                                              incorrectanswercount < 3) {
                                            selectedIndex =
                                                (selectedIndex == i) ? -1 : i;
                                          }
                                        });
                                      },
                                      child: MouseRegion(
                                        onHover: (event) {
                                          if (isResult == '' ||
                                              incorrectanswercount < 3) {
                                            setState(() {
                                              isImageHover = i;
                                            });
                                          }
                                        },
                                        onExit: (event) {
                                          setState(() {
                                            isImageHover = -1;
                                          });
                                        },
                                        // Dynamically to change Inside Container width and Height
                                        child: LayoutBuilder(builder:
                                            (BuildContext context,
                                                BoxConstraints constraints) {
                                          double containerWidth =
                                              constraints.maxWidth;
                                          double containerHeight =
                                              constraints.maxHeight;
                                          return DottedBorder(
                                            color: borderColorHighlighting
                                                ? (qAnswerList[i]['title'] ==
                                                        correctAnswers
                                                    ? Colors.green
                                                    : (selectedIndex == i)
                                                        ? Colors.red
                                                        : Colors.red)
                                                : Colors.blue,
                                            padding: EdgeInsets.all(1.0),
                                            strokeWidth: 1,
                                            borderType: BorderType.Rect,
                                            dashPattern: [5, 5],
                                            child: Container(
                                              width: containerWidth,
                                              height: containerHeight,
                                              color: (selectedIndex == i ||
                                                      isImageHover == i)
                                                  ? Color.fromRGBO(
                                                          115, 173, 239, 1)
                                                      .withOpacity(0.7)
                                                  : Colors.transparent,
                                              alignment: Alignment.centerLeft,
                                              child: (isResult ==
                                                      'correctanswer')
                                                  ? Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        '${qAnswerList[i]['title']}',
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    )
                                                  : (clickCounting == 2 ||
                                                          incorrectanswercount ==
                                                              3)
                                                      ? Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            '${qAnswerList[i]['title']}',
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        )
                                                      : Text(''),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    // ),
                                  );
                                },
                                cornerHandleBuilder: (context, handle) =>
                                    DefaultCornerHandle(
                                  handle: handle,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                sideHandleBuilder: (context, handle) =>
                                    DefaultCornerHandle(
                                  handle: handle,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    addMultipleEmptyOptions(1);
                  },
                  color: const Color.fromRGBO(43, 61, 81, 1),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: const CircleBorder(),
                  child: Tooltip(
                    message: "Add Options",
                    child: Icon(
                      Icons.add,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              child: Row(
                children: [
                  if (isResult == 'correctanswer')
                    feedbackpanel()
                  else if (isResult == 'incorrectanswer')
                    if (clickCounting == 2 || incorrectanswercount == 3)
                      feedbackpanel()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
