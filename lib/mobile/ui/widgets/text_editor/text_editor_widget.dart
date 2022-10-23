import 'package:flemis/mobile/my_app_mobile.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextEditorWidget extends StatefulWidget {
  const TextEditorWidget(
      {Key? key, this.text = "", this.textStyle, this.isTextExist = false})
      : super(key: key);
  final String? text;
  final TextStyle? textStyle;
  final bool? isTextExist;

  @override
  State<TextEditorWidget> createState() => _TextEditorWidgetState();
}

class _TextEditorWidgetState extends State<TextEditorWidget> {
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
  double? fontSize = 30;
  FontWeight? fontWeight = FontWeight.normal;
  String text = "";
  TextEditingController textEditingController = TextEditingController(text: "");
  bool isTextEditorActive = false;
  bool isTextChanged = false;
  TextStyle? textStyle;
  List<Widget> listWidget = [];
  Offset offset = Offset.zero;
  @override
  void initState() {
    if (widget.text != null) {
      if (widget.textStyle != null) {
        setState(() {
          textEditingController.text = widget.text ?? "";
          textStyle = widget.textStyle;
        });
      } else {
        setState(() {
          textEditingController.text = widget.text ?? "";
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    textStyle = TextStyle(
      color: colorSelected ?? Colors.black,
      fontSize: fontSize ?? 20,
      backgroundColor: backgroundColorSelected ?? Colors.white,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: familyFont.isNotEmpty
          ? GoogleFonts.getFont(familyFont).fontFamily
          : null,
    );
    return !isTextEditorActive
        ? Container(
            height: screenSize.height,
            width: screenSize.width,
            color: Colors.black.withOpacity(0.5),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
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
                          children: [
                            const SizedBox(
                              height: 30,
                              width: 30,
                              child: Center(
                                child: Icon(
                                  Icons.format_align_center_sharp,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "A",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                                context, {"text": text, "style": textStyle});
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white),
                          child: const Text("Done"),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.71,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: SliderTheme(
                              data: const SliderThemeData(
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Colors.white,
                                thumbColor: Colors.white,
                                showValueIndicator: ShowValueIndicator.always,
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: Slider(
                                  min: 0,
                                  max: 100,
                                  value: fontSize!,
                                  onChanged: widget.isTextExist == true
                                      ? (editedFontSize) {
                                          setState(() {
                                            fontSize = editedFontSize;
                                          });
                                        }
                                      : (newFontSize) {
                                          setState(() {
                                            fontSize = newFontSize;
                                          });
                                        },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.8,
                          child: Stack(
                            children: [
                              Positioned(
                                top: offset.dy,
                                left: offset.dx,
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    setState(() {
                                      offset = Offset(
                                          offset.dx + details.delta.dx,
                                          offset.dy + details.delta.dy);
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          //border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: widget.isTextExist ==
                                                  true
                                              ? InputBorder.none
                                              : const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: secondaryColor),
                                                ),
                                          errorBorder: InputBorder.none,
                                          // disabledBorder: InputBorder.none,
                                        ),
                                        enabled: true,
                                        showCursor: true,
                                        // autofocus: true,
                                        onChanged: widget.isTextExist == true
                                            ? (changedValue) {
                                                setState(() {
                                                  text = changedValue;
                                                });
                                              }
                                            : (value) {
                                                setState(() {
                                                  text = value;
                                                });
                                              },
                                        controller: textEditingController,
                                        /*  textAlign: fontSize != null && fontSize! > 40
                                                ? TextAlign.center
                                                : TextAlign.center, */
                                        textAlign: TextAlign.center,
                                        minLines: null,
                                        maxLines: null,
                                        style: textStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: screenSize.width,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: listFontNames
                              .map(
                                (e) => Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        familyFont = e;
                                        textStyle?.apply(
                                            color: Colors.red,
                                            fontFamily: GoogleFonts.getFont(e)
                                                .fontFamily);
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: familyFont == e
                                              ? Colors.white
                                              : primaryColor,
                                          border: Border.all(
                                              color: familyFont == e
                                                  ? Colors.black
                                                  : Colors.white,
                                              width: 2)),
                                      child: Center(
                                        child: Text(
                                          "Aa",
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.getFont(e)
                                                  .fontFamily,
                                              color: familyFont == e
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: colorSelected ?? Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                            child:
                                const Icon(Icons.colorize_outlined, size: 20),
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
                                              colorSelected = color;
                                              textStyle?.apply(
                                                  color: colorSelected);
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
                                              textStyle?.apply(
                                                  backgroundColor:
                                                      backgroundColorSelected);
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
                Text(
                  text,
                  style: textStyle,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        isTextEditorActive = true;
                      },
                    );
                  },
                  child: Text(!isTextEditorActive
                      ? "FuckMyAss"
                      : isTextEditorActive.toString()),
                )
              ],
            ),
          );
    //);
  }
}
