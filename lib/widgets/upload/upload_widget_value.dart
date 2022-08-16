class UploadWidgetValue {
  const UploadWidgetValue({
    this.progress = 0,
  }) : assert(progress == null || (progress >= 0 && progress <= 1), '');

  final double? progress;

  UploadWidgetValue copyWith({double? progress}) {
    return UploadWidgetValue(
      progress: progress ?? this.progress,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UploadWidgetValue &&
          (runtimeType == other.runtimeType && progress == other.progress);

  @override
  int get hashCode => progress.hashCode;
}
