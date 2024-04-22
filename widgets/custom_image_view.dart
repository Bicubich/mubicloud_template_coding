// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';

class CustomImageView extends StatelessWidget {
  ///[url] is required parameter for fetching network image
  String? url;

  ///[imagePath] is required parameter for showing png,jpg,etc image
  String? imagePath;

  ///[svgPath] is required parameter for showing svg image
  String? svgPath;

  ///[file] is required parameter for fetching image file
  File? file;

  double? height;
  double? width;
  Color? color;
  bool? colorBlendMode;
  BoxFit? fit;
  final String placeHolder;
  Alignment? alignment;
  VoidCallback? onTap;
  EdgeInsetsGeometry? margin;
  BorderRadius? radius;
  BoxBorder? border;

  ///a [CustomImageView] it can be used for showing any type of images
  /// it will shows the placeholder image if image is not found on network image
  CustomImageView({
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = 'assets/images/image_not_found.png',
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        enableFeedback: false,
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  ///build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius!,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  ///build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (svgPath != null && svgPath!.isNotEmpty) {
      if (colorBlendMode == null) {
        return Container(
          height: height,
          width: width,
          child: SvgPicture.asset(
            svgPath!,
            placeholderBuilder: (context) => Container(
              color: UIConstants().textColor.withAlpha(90),
              child: LottieBuilder.asset(
                'assets/images/lottie/circle_loader.json',
                width: 25.w,
              ),
            ),
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            color: color,
          ),
        );
      } else {
        return Container(
          height: height,
          width: width,
          child: SvgPicture.asset(
            svgPath!,
            placeholderBuilder: (context) => Container(
              color: UIConstants().textColor.withAlpha(90),
              child: LottieBuilder.asset(
                'assets/images/lottie/circle_loader.json',
                width: 25.w,
              ),
            ),
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            color: color,
            colorBlendMode: BlendMode.modulate,
          ),
        );
      }
    } else if (file != null && file!.path.isNotEmpty) {
      return Image.file(
        file!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
      );
    } else if (url != null && url!.isNotEmpty) {
      _checkMemory();
      return CachedNetworkImage(
        height: height,
        width: width,
        maxWidthDiskCache: width?.toInt(),
        maxHeightDiskCache: height?.toInt(),
        memCacheHeight: height?.toInt(),
        memCacheWidth: width?.toInt(),
        fit: fit,
        imageUrl: url!,
        color: color,
        imageBuilder: (context, imageProvider) => Image(image: imageProvider),
        placeholder: (context, url) => Container(
          color: UIConstants().textColor.withAlpha(90),
          child: LottieBuilder.asset(
            'assets/images/lottie/circle_loader.json',
            width: width,
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppConfig().getDefaultTrackImageAsset(),
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
        ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
      );
    }
    return Image.asset(
      AppConfig().getDefaultTrackImageAsset(),
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
    );
  }

  void _checkMemory() {
    ImageCache _imageCache = PaintingBinding.instance.imageCache;
    if (_imageCache.liveImageCount >= 55 << 20) {
      _imageCache.clear();
      _imageCache.clearLiveImages();
    }
  }
}
