import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flemis/mobile/models/camera_type.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/ui/screens/camera/preview_screen.dart';
import 'package:flemis/mobile/ui/screens/story/create/create_story_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_camera_demo/screens/preview_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../../../../main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  List<CameraType> menu = [
    CameraType.post,
    CameraType.stories,
    CameraType.live,
    CameraType.shorts
  ];
  CameraController controller =
      CameraController(cameras![1], ResolutionPreset.high, enableAudio: true);
  VideoPlayerController? videoController;

  File? _imageFile;
  File? _videoFile;

  // Initial values
  final ValueNotifier<CameraType> selectType =
      ValueNotifier<CameraType>(CameraType.post);
  bool _isCameraInitialized = false;
  final ValueNotifier<bool> _isCameraPermissionGranted =
      ValueNotifier<bool>(false);
  bool _isRearCameraSelected = true;
  final bool _isVideoCameraSelected = false;
  final ValueNotifier<bool> _isRecordingInProgress = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isRecordingPaused = ValueNotifier<bool>(false);
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 4.0;
  Timer? timer;
  ValueNotifier<String> recordingTime = ValueNotifier("");
  // Current values
  double _currentZoomLevel = 1.0;
  double _currentExposureOffset = 0.0;
  FlashMode _currentFlashMode = FlashMode.off;

  List<File> allFileList = [];

  final resolutionPresets = ResolutionPreset.values;

  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  Future<void> getPermissionStatus() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> permissions = await [
        Permission.camera,
        Permission.microphone,
        Permission.manageExternalStorage,
      ].request();
      if (permissions[Permission.camera] == PermissionStatus.granted &&
          permissions[Permission.microphone] == PermissionStatus.granted) {
        log('Camera Permission: GRANTED');
        _isCameraPermissionGranted.value = true;
        _isCameraPermissionGranted.notifyListeners();
        // Set and initialize the new camera
        // onNewCameraSelected(cameras![0]);
        refreshAlreadyCapturedImages();
      } else {
        _isCameraPermissionGranted.value = false;
        _isCameraPermissionGranted.notifyListeners();
        // await openAppSettings();
        log('Camera Permission: DENIED');
      }
    } else {
      Map<Permission, PermissionStatus> permissions = await [
        Permission.camera,
        Permission.microphone,
        Permission.storage,
        Permission.photos,
      ].request();
      if (permissions[Permission.camera] == PermissionStatus.granted &&
              permissions[Permission.microphone] == PermissionStatus.granted &&
              permissions[Permission.storage] == PermissionStatus.granted &&
              permissions[Permission.photos] == PermissionStatus.granted ||
          permissions[Permission.camera] == PermissionStatus.limited &&
              permissions[Permission.microphone] == PermissionStatus.limited &&
              permissions[Permission.storage] == PermissionStatus.limited &&
              permissions[Permission.photos] == PermissionStatus.limited) {
        log('Camera Permission: GRANTED');

        _isCameraPermissionGranted.value = true;

        // Set and initialize the new camera
        // onNewCameraSelected(cameras![0]);
        refreshAlreadyCapturedImages();
      } else {
        _isCameraPermissionGranted.value = false;

        // await openAppSettings();
        log('Camera Permission: DENIED');
      }
    }
  }

  refreshAlreadyCapturedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();
    List<Map<int, dynamic>> fileNames = [];

    for (var file in fileList) {
      if (file.path.contains('.jpg') || file.path.contains('.mp4')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    }

    if (fileNames.isNotEmpty) {
      final recentFile =
          fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      String recentFileName = recentFile[1];
      if (recentFileName.contains('.mp4')) {
        _videoFile = File('${directory.path}/$recentFileName');
        _imageFile = null;
        _startVideoPlayer();
      } else {
        _imageFile = File('${directory.path}/$recentFileName');
        _videoFile = null;
      }

      setState(() {});
    }
  }

  Future<void> takePicture(CameraType selectedType) async {
    final CameraController cameraController = controller;

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return;
    }

    try {
      var rawImage = await cameraController.takePicture();
      File? imageFile;
      setState(() {
        imageFile = File(rawImage.path);
      });

      int currentUnix = DateTime.now().millisecondsSinceEpoch;

      final directory = await getApplicationDocumentsDirectory();

      String fileFormat = imageFile!.path.split('.').last;

      if (kDebugMode) {
        print(fileFormat);
      }

      _imageFile = await imageFile?.copy(
        '${directory.path}/$currentUnix.$fileFormat',
      );
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CreateStoryScreen(
                file: _imageFile,
              )));

      refreshAlreadyCapturedImages();
    } on CameraException catch (e) {
      if (kDebugMode) {
        print('Error occured while taking picture: $e');
      }
    }
  }

  Future<void> _startVideoPlayer() async {
    if (_videoFile != null) {
      videoController = VideoPlayerController.file(_videoFile!);
      await videoController!.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      });
      await videoController!.setLooping(true);
      await videoController!.play();
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      recordingTime.value = t.tick.toString();
    });
  }

  Future<void> startVideoRecording() async {
    _isRecordingInProgress.value = true;

    try {
      await controller.startVideoRecording();
      startTimer();
    } on CameraException catch (e) {
      if (kDebugMode) {
        print('Error starting to record video: $e');
      }
    }
  }

  Future<void> stopVideoRecording() async {
    _isRecordingInProgress.value = false;

    try {
      var rawVideo = await controller.stopVideoRecording();
      String tempTime = recordingTime.value;
      timer?.cancel();
      recordingTime.value = "";
      File? videoFile;
      setState(() {
        videoFile = File(rawVideo.path);
      });

      int currentUnix = DateTime.now().millisecondsSinceEpoch;

      final directory = await getApplicationDocumentsDirectory();

      String fileFormat = videoFile!.path.split('.').last;

      _videoFile = await videoFile!.copy(
        '${directory.path}/$currentUnix.$fileFormat',
      );
      refreshAlreadyCapturedImages();
    } on CameraException catch (e) {
      if (kDebugMode) {
        print('Error stopping video recording: $e');
      }
    }
  }

  Future<void> pauseVideoRecording(CameraController controller) async {
    _isRecordingPaused.value = true;

    try {
      await controller.pauseVideoRecording();
      timer?.cancel();
    } on CameraException catch (e) {
      if (kDebugMode) {
        print('Error pausing video recording: $e');
      }
    }
  }

  Future<void> resumeVideoRecording(CameraController controller) async {
    _isRecordingPaused.value = false;

    try {
      await controller.resumeVideoRecording();
    } on CameraException catch (e) {
      if (kDebugMode) {
        print('Error resuming video recording: $e');
      }
    }
  }

  void resetCameraValues() async {
    _currentZoomLevel = 1.0;
    _currentExposureOffset = 0.0;
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    //final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      enableAudio: true,
      imageFormatGroup: Platform.isIOS ? null : ImageFormatGroup.jpeg,
    );

    // await previousCameraController?.dispose();

    resetCameraValues();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      // await cameraController.initialize();
      await Future.wait([
        cameraController
            .getMinExposureOffset()
            .then((value) => _minAvailableExposureOffset = value),
        cameraController
            .getMaxExposureOffset()
            .then((value) => _maxAvailableExposureOffset = value),
        cameraController
            .getMaxZoomLevel()
            .then((value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((value) => _minAvailableZoom = value),
      ]);

      _currentFlashMode = controller.value.flashMode;
    } on CameraException catch (e) {
      if (kDebugMode) {
        print('Error initializing camera: $e');
      }
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller.value.isInitialized;
      });
    }
  }

  Future<void> onViewFinderTap(
      TapDownDetails details, BoxConstraints constraints) async {
    if (!controller.value.isInitialized) {
      return;
    }

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    await controller.setExposurePoint(offset);
    if (Platform.isAndroid) {
      await controller.setFocusPoint(offset);
    }
  }

  Future<void> _initCamera() async {
    await controller.initialize().then((value) {
      if (mounted) {
        /*  setState(() {
          _isCameraInitialized = controller.value.isInitialized;
        }); */
        _isCameraPermissionGranted.value = controller.value.isInitialized;
      } else {
        return;
      }
      refreshAlreadyCapturedImages();

      setState(() {});
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isCameraPermissionGranted.value) {
      await _initCamera();
    }
    refreshAlreadyCapturedImages();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (!controller.value.isInitialized) {
      controller = CameraController(cameras![0], ResolutionPreset.high,
          enableAudio: true);
      /*  controller.initialize().then((value) {
        if (!mounted) return;
        setState(() {});
        //onNewCameraSelected(cameraController.description);
      }); */
      return;
    }

    if (state == AppLifecycleState.inactive) {
      if (!Platform.isIOS) {
        controller.dispose();
      }
    } else if (state == AppLifecycleState.resumed) {
      controller = CameraController(cameras![1], ResolutionPreset.high,
          enableAudio: true);
      /*controller.initialize().then((value) {
        if (!mounted) return;
        setState(() {});
        //onNewCameraSelected(cameraController.description);
      });*/
      onNewCameraSelected(controller.description);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    controller.debugCheckIsDisposed();
    videoController?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //await stopVideoRecording();
      _isRecordingInProgress.value = false;
    });
    super.dispose();
  }

  IconData _currentFlashModeIcon(FlashMode flashMode) {
    switch (flashMode) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.torch:
        return Icons.flash_on;
      case FlashMode.auto:
        return Icons.flash_auto;
      default:
        return Icons.flash_off;
    }
  }

  Future<void> _changeCurrentFlashMode(FlashMode currentFlashMode) async {
    if (currentFlashMode == FlashMode.off) {
      setState(() {
        _currentFlashMode = FlashMode.auto;
      });
      await controller.setFlashMode(_currentFlashMode);
    } else if (currentFlashMode == FlashMode.auto) {
      setState(() {
        _currentFlashMode = FlashMode.torch;
      });
      await controller.setFlashMode(_currentFlashMode);
    } else {
      setState(() {
        _currentFlashMode = FlashMode.off;
      });
      await controller.setFlashMode(_currentFlashMode);
    }
  }

  String formatTime(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  //changing to front camera or back camera
  Future<void> _changeCamera(bool isRearCameraSelected) async {
    if (_isRearCameraSelected) {
      controller = CameraController(cameras![0], ResolutionPreset.high);
      await _initCamera();
    } else {
      controller = CameraController(cameras![1], ResolutionPreset.high);

      await _initCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var deviceRatio = screenSize.width / screenSize.height;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 200,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: whiteColor,
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
        actions: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.height * 0.05,
            margin: const EdgeInsets.only(right: 10, top: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 2.0,
                right: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      _currentFlashModeIcon(_currentFlashMode),
                      color: whiteColor,
                    ),
                    onPressed: () async =>
                        _changeCurrentFlashMode(_currentFlashMode),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: primaryColor,
      body: ValueListenableBuilder<bool>(
        valueListenable: _isCameraPermissionGranted,
        //  ? _isCameraInitialized
        builder: (context, permissionGranted, _) {
          if (permissionGranted) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: AspectRatio(
                aspectRatio: (!controller.value.isInitialized)
                    ? 1 / deviceRatio
                    : 1 / controller.value.aspectRatio,
                child: _cameraWidget(screenSize),
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                Text(
                  'Permission denied',
                  style: primaryFontStyle[4],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    // await openAppSettings()
                    //     .then((value) async => await getPermissionStatus());
                    await getPermissionStatus();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Give permission',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _cameraWidget(Size screenSize) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.expand,
      children: [
        CameraPreview(
          controller,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (details) async =>
                  await onViewFinderTap(details, constraints),
            );
          }),
        ),
        ValueListenableBuilder<CameraType>(
            valueListenable: selectType,
            builder: (context, selectedValue, _) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                  16.0,
                  8.0,
                  16.0,
                  8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: _currentZoomLevel,
                            min: _minAvailableZoom,
                            max: _maxAvailableZoom,
                            activeColor: Colors.white,
                            inactiveColor: Colors.white30,
                            onChanged: (value) async {
                              setState(() {
                                _currentZoomLevel = value;
                              });
                              await controller.setZoomLevel(value);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${_currentZoomLevel.toStringAsFixed(1)}x',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ValueListenableBuilder<String>(
                              valueListenable: recordingTime,
                              builder: (context, timeRecorded, _) {
                                return Text(
                                  timeRecorded == ""
                                      ? "0:0:0"
                                      : formatTime(
                                          int.parse(recordingTime.value)),
                                  style: const TextStyle(color: whiteColor),
                                );
                              }),
                        ],
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isRecordingInProgress,
                      builder: (context, value, _) {
                        return Container(
                          margin: Platform.isIOS
                              ? const EdgeInsets.only(bottom: 10)
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ValueListenableBuilder<bool>(
                                valueListenable: _isRecordingPaused,
                                builder: (context, paused, _) {
                                  return InkWell(
                                    onTap: !value
                                        ? () async {
                                            /*  onNewCameraSelected(cameras[
                                                            _isRearCameraSelected ? 1 : 0]); */
                                            await _changeCamera(
                                                _isRearCameraSelected);
                                            setState(() {
                                              _isRearCameraSelected =
                                                  !_isRearCameraSelected;
                                            });
                                          }
                                        : () async {
                                            if (!paused) {
                                              await pauseVideoRecording(
                                                  controller);
                                            } else {
                                              await resumeVideoRecording(
                                                  controller);
                                            }
                                          },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.black38,
                                          size: 60,
                                        ),
                                        !value
                                            ? Icon(
                                                _isRearCameraSelected
                                                    ? Icons.flip_camera_android
                                                    : Icons.flip_camera_android,
                                                color: Colors.white,
                                                size: 30,
                                              )
                                            : !paused
                                                ? const Icon(
                                                    Icons.pause,
                                                    color: Colors.white,
                                                    size: 30,
                                                  )
                                                : const Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              ValueListenableBuilder<bool>(
                                  valueListenable: _isRecordingInProgress,
                                  builder: (context, value, _) {
                                    return InkWell(
                                      onLongPress: () async =>
                                          await startVideoRecording(),
                                      onTap: !value
                                          ? () async {
                                              await takePicture(selectedValue);
                                            }
                                          : () async {
                                              await stopVideoRecording();
                                              //_startVideoPlayer();
                                            },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: !value
                                                ? Colors.white38
                                                : whiteColor,
                                            size: 80,
                                          ),
                                          Icon(
                                            Icons.circle,
                                            color: !value
                                                ? whiteColor
                                                : Colors.red,
                                            size: 65,
                                          ),
                                          !value
                                              ? Container()
                                              : const Icon(
                                                  Icons.stop_rounded,
                                                  color: Colors.white,
                                                  size: 32,
                                                ),
                                        ],
                                      ),
                                    );
                                  }),
                              InkWell(
                                onTap: _imageFile != null || _videoFile != null
                                    ? () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => PreviewScreen(
                                              imageFile: _imageFile,
                                              fileList: allFileList,
                                            ),
                                          ),
                                        );
                                      }
                                    : null,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: whiteColor,
                                      width: 2,
                                    ),
                                    image: _imageFile != null
                                        ? DecorationImage(
                                            image: FileImage(_imageFile!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: videoController != null &&
                                          videoController!.value.isInitialized
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: AspectRatio(
                                            aspectRatio: videoController!
                                                .value.aspectRatio,
                                            child:
                                                VideoPlayer(videoController!),
                                          ),
                                        )
                                      : Container(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Center(
                      child: _chooseMenu(screenSize, menu, selectType),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }

  Widget _chooseMenu(Size screenSize, List<CameraType> menu,
      ValueNotifier<CameraType> selectType) {
    return Container(
      margin: EdgeInsets.only(bottom: Platform.isIOS ? 30 : 0),
      decoration: BoxDecoration(
        color: Colors.grey[700]?.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 40,
      width: screenSize.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: menu
            .map(
              (selectItem) => Flexible(
                child: InkWell(
                  onTap: () async => selectType.value = selectItem,
                  child: Container(
                    margin: menu.indexOf(selectItem) == 0
                        ? const EdgeInsets.only(
                            left: 10,
                          )
                        : null,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      selectItem.name.toUpperCase(),
                      style: TextStyle(
                        color:
                            menu.indexOf(selectItem) == selectType.value.index
                                ? Colors.yellow
                                : null,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
