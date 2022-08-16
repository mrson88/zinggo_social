// import 'package:flutter/material.dart';
//
// class UploadWidget extends StatefulWidget {
//   final UploadWidgetController controller;
//   final Widget child;
//
//   const UploadWidget({Key? key, required this.controller, required this.child}) : super(key: key);
//
//   @override
//   _UploadWidgetState createState() => _UploadWidgetState();
// }
//
// class _UploadWidgetState extends State<UploadWidget> {
//   @override
//   void initState() {
//     super.initState();
//     widget.controller.addListener(_didChangeUploadValue);
//   }
//
//   @override
//   void didUpdateWidget(UploadWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.controller != oldWidget.controller) {
//       oldWidget.controller.removeListener(_didChangeUploadValue);
//       widget.controller.addListener(_didChangeUploadValue);
//     }
//   }
//
//   @override
//   void dispose() {
//     widget.controller.removeListener(_didChangeUploadValue);
//     super.dispose();
//   }
//
//   void _didChangeUploadValue() {
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: <Widget>[
//         widget.child,
//         showCircular()
//             ? Center(
//           child: Theme(
//             data: ThemeData(accentColor: Theme.of(context).canvasColor),
//             child: CircularProgressIndicator(
//               value: widget.controller.progress,
//             ),
//           ),
//         )
//             : Container(),
//       ],
//     );
//   }
//
//   bool showCircular() {
//     return widget.controller.progress != null &&
//         widget.controller.progress != 1.0;
//   }
// }
//
// // class UploadWidgetController extends ValueNotifier<UploadWidgetValue> {
// //   UploadWidgetController() : super(const UploadWidgetValue());
// //
// //   double get progress => value.progress;
// //
// //   UploadWidgetState get state {
// //     if (progress == 1) {
// //       return UploadWidgetState.done;
// //     } else if (progress == 0) {
// //       return UploadWidgetState.init;
// //     }
// //
// //     return UploadWidgetState.uploading;
// //   }
// //
// //   set progress(double progress) {
// //     value = value.copyWith(progress: progress);
// //   }
// //
// //   void clear() {
// //     value = const UploadWidgetValue();
// //   }
// // }
// //
// // @immutable
// // class UploadWidgetValue {
// //   const UploadWidgetValue({
// //     this.progress = 0,
// //   }) : assert(progress == null ||
// //       (progress != null && progress >= 0 && progress <= 1));
// //
// //   final double progress;
// //
// //   // UploadWidgetValue copyWith({double progress}) {
// //   //   return UploadWidgetValue(
// //   //     progress: progress ?? this.progress,
// //   //   );
// //   // }
// //
// //   @override
// //   bool operator ==(Object other) =>
// //       identical(this, other) ||
// //           other is UploadWidgetValue &&
// //               (runtimeType == other.runtimeType && progress == other.progress);
// //
// //   @override
// //   int get hashCode => progress.hashCode;
// // }
// //
// // enum UploadWidgetState {
// //   init,
// //   uploading,
// //   done,
// // }
