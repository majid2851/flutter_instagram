
import 'dart:async';

import 'package:flutter/cupertino.dart';

extension GetImageAspectRatio on Image
{
  Future<double> getAspectRatio() async
  {
    final completer = Completer<double>();
    image.resolve(ImageConfiguration())
         .addListener(ImageStreamListener((imageInfo, synchronousCall) {
            final aspectRatio =  imageInfo.image.width/imageInfo.image.height;
            imageInfo.image.dispose();
            completer.complete(aspectRatio);
         }
    ));
    return completer.future;

  }

}

