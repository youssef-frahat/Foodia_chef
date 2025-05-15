import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUploadImage extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onTap;
  final String? networkImage;

  const CustomUploadImage({
    super.key,
    required this.selectedImage,
    required this.onTap,
    this.networkImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120.w,
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.orange, width: 4),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildImage(),
            Positioned(
              right: 8.w,
              bottom: 8.h,
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.camera_alt, size: 20, color: Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (selectedImage != null) {
      // إذا كانت الصورة محلية
      return ClipOval(
        child: Image.file(
          selectedImage!,
          width: 120.w,
          height: 120.h,
          fit: BoxFit.cover,
        ),
      );
    } else if (networkImage != null && networkImage!.isNotEmpty) {
      final url = _formatNetworkImage(networkImage!);
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          width: 120.w,
          height: 120.h,
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Container(
                width: 120.w,
                height: 120.h,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
          errorWidget:
              (context, url, error) => Container(
                width: 120.w,
                height: 120.h,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.broken_image,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
        ),
      );
    } else {
      // إذا لم توجد صورة نهائيًا
      return const Icon(Icons.person, size: 60, color: Colors.grey);
    }
  }

  String _formatNetworkImage(String path) {
    if (path.startsWith('http')) {
      return path;
    } else {
      return 'https://mangamediaa.com/house-food/public/storage/uploads/images/users/$path';
    }
  }
}
