
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackgroundColorEditorWidget extends StatefulWidget {
  const BackgroundColorEditorWidget(
      {Key? key, this.selectedColor, this.isToChange = false})
      : super(key: key);
  final Color? selectedColor;
  final bool? isToChange;

  @override
  State<BackgroundColorEditorWidget> createState() =>
      _BackgroundColorEditorWidgetState();
}

class _BackgroundColorEditorWidgetState
    extends State<BackgroundColorEditorWidget> {
  final Set<String> listFontNames =
      GoogleFonts.asMap().keys.toList().getRange(0, 20).toSet();
  String familyFont = "Acme";
  final Set<Color> colors = {
    ...Colors.primaries,
    ...Colors.accents,
    Colors.transparent,
    Colors.black,
    Colors.white
  };
  Color? backgroundColorSelected = Colors.transparent;
  Color? colorSelected = Colors.white;
  bool isBackgroundColorEditorActive = false;
  @override
  void initState() {
    if (widget.selectedColor != null) {
      if (widget.isToChange != null && widget.isToChange!) {
        setState(() {
          backgroundColorSelected = widget.selectedColor ?? Colors.transparent;
        });
      } else {
        setState(() {
          backgroundColorSelected = widget.selectedColor ?? Colors.transparent;
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return !isBackgroundColorEditorActive
        ? SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            //color: Colors.black.withOpacity(0.5),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2.5,),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                          Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, {
                                "backgroundColorSelected":
                                    backgroundColorSelected,
                              });
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white),
                            child: const Text("Done"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color:
                                  backgroundColorSelected ?? Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "B",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              height: 50,
                              width: screenSize.width,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: colors
                                    .map(
                                      (color) => Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              backgroundColorSelected = color;
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: color == Colors.white
                                                      ? Colors.black
                                                      : Colors.white),
                                              shape: BoxShape.circle,
                                              color: color,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        isBackgroundColorEditorActive = true;
                      },
                    );
                  },
                  child: Text(!isBackgroundColorEditorActive
                      ? "FuckMyAss"
                      : isBackgroundColorEditorActive.toString()),
                )
              ],
            ),
          );
    //);
  }
}
