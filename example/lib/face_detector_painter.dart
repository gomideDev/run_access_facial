import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:run_access_facial/run_access_facial.dart';

import 'UtilsScanner.dart';

class FaceDetectorPainter extends CustomPainter {
  final Size absoluteImageSize;
  final List<Face> faces;

  FaceDetectorPainter(
      this.absoluteImageSize, this.faces);

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    final Paint greenPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.green;

    for (final Face face in faces) {
      final contour = face.getContour((FaceContourType.allPoints));
      canvas.drawPoints(
          PointMode.points,
          contour.positionsList
              .map((offset) => Offset((offset.dx * scaleX), offset.dy * scaleY))
              .toList(),
          paint);
      /*for (int i = 0; i < contour.positionsList.length - 1; i++) {
        canvas.drawLine(contour.positionsList[i].scale(scaleX, scaleY),
            contour.positionsList[i + 1].scale(scaleX, scaleY), paint);
      }*/
      for (final connection in faceMaskConnections) {
        canvas.drawLine(
            contour.positionsList[connection.x].scale(scaleX, scaleY),
            contour.positionsList[connection.y].scale(scaleX, scaleY),
            paint);
      }

      canvas.drawRect(
        Rect.fromLTRB(
          face.boundingBox.left * scaleX,
          face.boundingBox.top * scaleY,
          face.boundingBox.right * scaleX,
          face.boundingBox.bottom * scaleY,
        ),
        greenPaint,
      );
    }
  }

  @override
  bool shouldRepaint( FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
