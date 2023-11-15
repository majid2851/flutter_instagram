
import 'package:flutter_instagram/views/'
    'components/animations/lottie_animation_view.dart';
import 'package:flutter_instagram/views/'
    'components/animations/models/lottie_animation.dart';

class LoadingAnimationView extends LottieAnimationView
{
  LoadingAnimationView({super.key})
      : super(
      animation: LottieAnimation.loading
  );



}