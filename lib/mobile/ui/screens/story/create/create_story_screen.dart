import 'dart:io';
import 'package:flemis/mobile/ui/widgets/components/painter/image_painter.dart';
import 'package:flemis/mobile/ui/widgets/image_editor/background_color_editor_widget.dart';
import 'package:flemis/mobile/ui/widgets/text_editor/text_editor_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as dartUi;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({Key? key, this.file, this.selectedFilterColor})
      : super(key: key);
  final File? file;
  final ValueNotifier<Color>? selectedFilterColor;

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen> {
  bool isEditorOpen = false;
  bool isBackgroundColorEditorOpen = false;
  final GlobalKey globalKey = GlobalKey();
  ValueNotifier<dartUi.Image?> image = ValueNotifier(null);
  Offset offset = const Offset(0, 250);
  ValueNotifier<Color>? defaultFilterColor;

  ValueNotifier<bool> isDrawnSelectorActive = ValueNotifier(false);
  ValueNotifier<Color> drawnColorSelected = ValueNotifier(Colors.black);

  final Set<Color> colors = {
    ...Colors.primaries,
    ...Colors.accents,
    Colors.transparent,
    Colors.black,
    Colors.white
  };

  VideoPlayerController? videoPlayerController;
  Map<String, dynamic>? dataFromTextEditor;

  Future<Map<String, dynamic>?> _openTextEditorWidget() async {
    setState(() {
      isEditorOpen = true;
    });
    dynamic datinha;
    await showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 200),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: const TextEditorWidget(),
            ),
          );
        },
        pageBuilder: (context, a, a2) {
          return const Text("");
        }).then((value) => setState(() {
          datinha = value;
        }));

    if (datinha != null) {
      setState(() {
        isEditorOpen = false;
      });
      return datinha;
    }
    setState(() {
      isEditorOpen = false;
    });
    return null;
  }

  Future<Map<String, dynamic>?> _editText(
      String text, TextStyle textStyle) async {
    dynamic datinha;
    setState(() {
      isEditorOpen = true;
    });
    await showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 200),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: TextEditorWidget(
                text: text,
                textStyle: textStyle,
                isTextExist: true,
              ),
            ),
          );
        },
        pageBuilder: (context, a, a2) {
          return const Text("");
        }).then((value) => setState(() {
          datinha = value;
        }));

    if (datinha != null) {
      setState(() {
        isEditorOpen = false;
      });
      return datinha;
    }
    setState(() {
      isEditorOpen = false;
    });
    return null;
  }

  _save() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    image.value = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData =
        await image.value?.toByteData(format: dartUi.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    //String dir = (await getExternalStorageDirectory())!.path;
    String dir = (await getApplicationDocumentsDirectory()).path;
    String fileFormat = widget.file!.path.split('.').last;
    String fullpath =
        "$dir/${DateTime.now().millisecondsSinceEpoch}.$fileFormat";
    File file = File(fullpath);
    file.writeAsBytesSync(pngBytes);
    if (kDebugMode) {
      print(file.path);
    }
    Navigator.of(context).pop();
  }

  _saveVideo() async {
    //FlutterFFmpeg fFmpeg = FlutterFFmpeg();
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    dartUi.Image image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData =
        await image.toByteData(format: dartUi.ImageByteFormat.png);
    Uint8List mp4Bytes = byteData!.buffer.asUint8List();
    String dir = (await getExternalStorageDirectory())!.path;
    String fullpath = "$dir/${DateTime.now()}.mp4";
    File file = File(fullpath);
    file.writeAsBytesSync(mp4Bytes);
    if (kDebugMode) {
      print(file.path);
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CreateStoryScreen(
              file: file,
            )));
  }

  @override
  void initState() {
    defaultFilterColor = ValueNotifier<Color>(
        widget.selectedFilterColor?.value ?? Colors.transparent);
    if (widget.file!.path.endsWith(".mp4")) {
      if (widget.file != null) {
        videoPlayerController = VideoPlayerController.file(widget.file!)
          ..initialize().then((_) {});
        setState(() {});
      }
    }
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    image.value = await _convertFileToImage(widget.file!);
  }

  Future<dartUi.Image> _convertFileToImage(File fileToConvert) async {
    final codec = await dartUi.instantiateImageCodec(
      fileToConvert.readAsBytesSync(),
      targetHeight: MediaQuery.of(context).size.height.toInt(),
      allowUpscaling: true,
      // targetWidth: MediaQuery.of(context).size.width.toInt(),
    );

    return (await codec.getNextFrame().then((value) => value)).image;
  }

  Future<void> pickColor(Color value) async {
    defaultFilterColor?.value == null
        ? defaultFilterColor?.value = Colors.transparent
        : defaultFilterColor?.value = value;
  }

  Future<Color?> _openPickColor() async {
    setState(() {
      isBackgroundColorEditorOpen = true;
    });
    Color? backgroundSelected;
    await showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 200),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: const BackgroundColorEditorWidget(isToChange: false),
            ),
          );
        },
        pageBuilder: (context, a, a2) {
          return const Text("");
        }).then((value) => setState(() {
          if (value != null) {
            value as Map<String, dynamic>;
            backgroundSelected = value["backgroundColorSelected"];
          } else {
            backgroundSelected = Colors.transparent;
          }
        }));

    if (backgroundSelected != null) {
      setState(() {
        isBackgroundColorEditorOpen = false;
      });
      return backgroundSelected;
    }
    setState(() {
      isBackgroundColorEditorOpen = false;
    });
    return null;
  }

  Future<Color?> _editBackgroundColor(Color color, bool isToChange) async {
    Color? backgroundColorChanged;
    setState(() {
      isBackgroundColorEditorOpen = true;
    });
    await showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 200),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: BackgroundColorEditorWidget(
                selectedColor: color,
                isToChange: true,
              ),
            ),
          );
        },
        pageBuilder: (context, a, a2) {
          return const Text("");
        }).then((value) => setState(() {
          value as Map<String, dynamic>?;
          backgroundColorChanged = value!["backgroundColorSelected"];
        }));

    if (backgroundColorChanged != null) {
      setState(() {
        isBackgroundColorEditorOpen = false;
      });
      return backgroundColorChanged;
    }
    setState(() {
      isBackgroundColorEditorOpen = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: !isEditorOpen && !isBackgroundColorEditorOpen
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: defaultFilterColor?.value != Colors.transparent
                          ? () async => defaultFilterColor?.value =
                              (await _editBackgroundColor(
                                  defaultFilterColor!.value, true))!
                          : () async => defaultFilterColor?.value =
                              (await _openPickColor())!,
                      customBorder: const CircleBorder(),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.color_lens_outlined,
                          size: 20,
                          color: Colors.black,
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => isDrawnSelectorActive.value = true,
                      customBorder: const CircleBorder(),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.gesture,
                          size: 20,
                          color: Colors.black,
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async =>
                          dataFromTextEditor = await _openTextEditorWidget(),
                      customBorder: const CircleBorder(),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.text_fields,
                          size: 20,
                          color: Colors.white,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: widget.file!.path.endsWith(".mp4")
                      ? () async => _saveVideo()
                      : () async => _save(),
                  child: const Text("done"),
                ),
              ],
            )
          : null,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        //color: Colors.red,
        child: RepaintBoundary(
          key: globalKey,
          child: Stack(
            children: [
              if (widget.file != null)
                if (!widget.file!.path.endsWith(".mp4"))
                  ValueListenableBuilder<Color>(
                      valueListenable: defaultFilterColor!,
                      builder: (context, color, _) {
                        return SizedBox(
                          height: screenSize.height,
                          width: screenSize.width,
                          child: ValueListenableBuilder<dartUi.Image?>(
                            valueListenable: image,
                            builder: (context, imageObject, _) {
                              if (imageObject != null) {
                                return ValueListenableBuilder<Color>(
                                    valueListenable: drawnColorSelected,
                                    builder: (context, lineColor, _) {
                                      ImagePainter imagePainter = ImagePainter(
                                          image: imageObject, color: lineColor);
                                      return GestureDetector(
                                        onPanUpdate: (details) {
                                          imagePainter
                                              .update(details.localPosition);
                                          globalKey.currentContext
                                              ?.findRenderObject()
                                              ?.markNeedsPaint();
                                        },
                                        onPanDown: (details) {
                                          imagePainter
                                              .update(details.localPosition);
                                          globalKey.currentContext
                                              ?.findRenderObject()
                                              ?.markNeedsPaint();
                                        },
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              color, BlendMode.softLight),
                                          child: CustomPaint(
                                            painter: imagePainter,
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                return ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      color, BlendMode.softLight),
                                  child: Image.file(
                                    widget.file!,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      })
                else if (videoPlayerController != null)
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: SizedBox(
                        height: videoPlayerController?.value.size.height ??
                            screenSize.height,
                        width: videoPlayerController?.value.size.width ??
                            screenSize.width,
                        child: InkWell(
                          onTap: () async =>
                              await videoPlayerController?.play(),
                          child: VideoPlayer(videoPlayerController!),
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    color: Colors.black,
                  ),
              if (dataFromTextEditor != null)
                Positioned(
                  top: offset.dy,
                  left: offset.dx,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        offset = Offset(offset.dx + details.delta.dx,
                            offset.dy + details.delta.dy);
                      });
                    },
                    child: SizedBox(
                      width: screenSize.width * 0.8,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async => dataFromTextEditor =
                              await _editText(dataFromTextEditor!["text"],
                                  dataFromTextEditor!["style"]),
                          child: Text(
                            dataFromTextEditor!["text"],
                            style: dataFromTextEditor!["style"],
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ValueListenableBuilder<bool>(
                valueListenable: isDrawnSelectorActive,
                builder: (context, isSelectorActive, _) {
                  if (isSelectorActive) {
                    return SizedBox(
                      height: screenSize.height,
                      width: screenSize.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(bottom: 10),
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          //shrinkWrap: true,
                          //scrollDirection: Axis.horizontal,

                          children: colors
                              .map(
                                (color) => Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      drawnColorSelected.value = color;
                                      isDrawnSelectorActive.value = false;
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
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
