import 'package:flutter/material.dart';

Widget watermarkedImage(String imageUrl, {String watermark = 'INEWS'}) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.network(
          imageUrl,
          width: double.infinity,
          height: 180,
          fit: BoxFit.cover,
        ),
      ),
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.18),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      Positioned(
        right: 16,
        bottom: 12,
        child: Text(
          watermark,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.bold,
            fontSize: 16,
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black26,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
