import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  ImageWidget(
      {@required this.url,
      this.w,
      this.h,
      this.fit = BoxFit.cover,
      this.defImagePath = 'assets/images/01.png'});
  final String url;
  final double w;
  final double h;
  final BoxFit fit;
  final String defImagePath;

  @override
  State<StatefulWidget> createState() {
    return _ImageWidget();
  }
}

class _ImageWidget extends State<ImageWidget> {
  Image _image;

  @override
  void initState() {
    _image = Image.network(
      widget.url,
      fit: widget.fit,
      width: widget.w,
      height: widget.h,
    );
    var resolve = _image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(
      ImageStreamListener(
        (_, __) {},
        onError: (dynamic exception, StackTrace stackTrace) {
          setState(
            () {
              _image = Image.asset(
                widget.defImagePath,
                width: widget.w,
                height: widget.h,
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _image;
  }
}
