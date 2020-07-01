library customizedvideoplayer;
import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'material_controls.dart';
import 'cupertino_controls.dart';

// 参数注释
// -----------------------------------------------------
// * 播放器参数列表 ******
// * url: 视频地址
// * aspectRatio: 视频比例，默认 16 / 9
// * autoInitialize: 是否在启动时初始化视频
// * autoPlay: 是否自动播放
// * startAt:
// * loop: 是否循环播放
// * fullScreenByDefault: 是否初始化全屏显示
// * showControls: 是否显示控制条，默认值true
// * showControlsOnInitialize: 是否初始化显示控制条初，默认值true
// * allowMuting: 是否显示静音图标，默认值true
// * allowFullScreen: 是否显全屏控件，默认值true
// * allowedScreenSleep: 定义播放器是否显全屏睡眠，默认值true
// * isLive: 定义控件是否应用于实时流视频，默认值false
// * videoCallback: 视频状态监听回调函数
// * 进度控制条参数列表 ******
// * onlyMaterial: iOS安卓是否统一显示material样式（安卓样式），默认值为true 统一显示安卓样式
// * playedColor: 已经播放的进度条颜色
// * handleColor: 进度条拖拽圆钮颜色
// * backgroundColor: 总进度条颜色
// * bufferedColor: 缓冲进度条颜色
// -----------------------------------------------------

class Video extends StatefulWidget {
  String url;
  double aspectRatio;
  bool autoInitialize;
  bool autoPlay;
  Duration startAt;
  bool looping;
  bool fullScreenByDefault;
  bool showControlsOnInitialize;
  bool showControls;
  bool allowMuting;
  bool allowFullScreen;
  bool allowedScreenSleep;
  bool isLive;
  final videoCallback;
  bool onlyMaterial;
  Color playedColor;
  Color handleColor;
  Color backgroundColor;
  Color bufferedColor;
  final barHeight;
  final errorIconColor;
  final controlColor;
  final mainBgColor;

  Video({
    Key key,
    this.url,
    this.aspectRatio = 16 / 9,
    this.autoInitialize = false,
    this.autoPlay = false,
    this.startAt,
    this.looping = false,
    this.fullScreenByDefault = false,
    this.showControlsOnInitialize = true,
    this.showControls = true,
    this.allowMuting = true,
    this.allowFullScreen = true,
    this.allowedScreenSleep = true,
    this.isLive = false,
    this.videoCallback,
    this.onlyMaterial = true,
    this.playedColor,
    this.handleColor,
    this.backgroundColor,
    this.bufferedColor,
    this.barHeight,
    this.errorIconColor,
    this.controlColor,
    this.mainBgColor,
  }) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;


  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _videoPlayerController.initialize().then((_) => { setState(() {}) });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: new Chewie(
            controller: initController(context),
          ),
        ),
      ],
    );
  }

  ChewieController initController (context) {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: this.widget.aspectRatio,
      autoInitialize: this.widget.autoInitialize,
      autoPlay: this.widget.autoPlay,
      startAt: this.widget.startAt,
      looping: this.widget.looping,
      fullScreenByDefault: this.widget.fullScreenByDefault,
      showControlsOnInitialize: this.widget.showControlsOnInitialize,
      showControls: this.widget.showControls,
      allowMuting: this.widget.allowMuting,
      allowFullScreen: this.widget.allowFullScreen,
      allowedScreenSleep: this.widget.allowedScreenSleep,
      isLive: this.widget.isLive,
      materialProgressColors: new ChewieProgressColors(
        playedColor: this.widget.playedColor ?? Color.fromRGBO(75, 184, 239, 1),
        handleColor: this.widget.handleColor ?? Color.fromRGBO(75, 184, 239, 1),
        backgroundColor: this.widget.backgroundColor ?? Color.fromRGBO(255, 255, 255, 0.2),
        bufferedColor: this.widget.bufferedColor ?? Color.fromRGBO(255, 255, 255, 0.4),
      ),
      customControls: getCustomControlsStatus(),
    );
    _chewieController.addListener(() {
      if (this.widget.videoCallback != null) {
        this.widget.videoCallback(_chewieController);
      }
    });
    return _chewieController;
  }

  getCustomControlsStatus() {
    if (Theme.of(context).platform == TargetPlatform.android || this.widget.onlyMaterial) {
      return MaterialControls(
        barHeight: this.widget.barHeight,
        mainBgColor: this.widget.mainBgColor,
        controlColor: this.widget.controlColor,
        errorIconColor: this.widget.errorIconColor,
      );
    } else {
      return CupertinoControls(iconColor: this.widget.controlColor, backgroundColor: this.widget.mainBgColor,);
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
