# customizedvideoplayer

一个可定制样式的 Flutter video_player

## 安装(Installation)
```
在你的pubspec.yaml中添加 customized_video_player 依赖
First, add customized_video_player as a dependency in your pubspec.yaml file.
```

## 实例（Example)
```
import 'package:customized_video_player/customized_video_player.dart';
import 'package:flutter/material.dart';

void main() => runApp(VideoApp());

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  String url = 'http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: Video(
            url: url
          ),
        ),
      ),
    );
  }
  // 视频状态监听回调函数
  videoCallback(_chewieController) {
    if (!_chewieController.isFullScreen) {
     // 如果不是全屏情况
     print('_chewieController.isFullScreen');
   }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
```
