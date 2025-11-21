import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;

  ImageDialog({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding:
          EdgeInsets.only(top: size.height * 0.05, bottom: size.height * 0.02),
      child: InteractiveViewer(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: size.width * 0.9,
          errorBuilder: (context, object, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
