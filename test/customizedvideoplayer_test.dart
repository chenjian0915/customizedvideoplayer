import 'package:flutter_test/flutter_test.dart';

import 'package:customized_video_player/customized_video_player.dart';

void main() {
  String url = 'http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4';

  test('adds one to input values', () {
    final calculator = Video(url: url,);
  });
}
