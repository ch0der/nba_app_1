import 'package:flutter/material.dart';


class ShaderContainer extends StatelessWidget {
  ShaderContainer({this.width,this.height,this.image,this.stop});

  final double stop;
  final double width;
  final double height;
  final String image;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
        child: ShaderMask(
          child: Image(
            image: AssetImage(image),
          ),
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              tileMode: TileMode.mirror,
              colors: [Colors.white.withOpacity(.7), Colors.grey[50]],
              stops: [
                0.0,
                stop,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
        ),
      ),
    );
  }
}
