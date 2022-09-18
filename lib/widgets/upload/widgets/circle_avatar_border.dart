import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_color.dart';

class CircleAvatarBorder extends StatelessWidget {
  final String? avatarUrl;
  final double size;

  const CircleAvatarBorder({
    Key? key,
    this.avatarUrl,
    this.size = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = avatarUrl;

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: imageUrl != null && imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                errorWidget: (ctx, str, obj) => _buildFallback(),
              )
            : _buildFallback(),
      ),
    );
  }

  Widget _buildFallback() {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.lightBlueGrey,
      ),
      child: Icon(
        Icons.person,
        size: size - 10,
        color: AppColors.white,
      ),
    );
  }
}
