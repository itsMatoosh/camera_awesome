import 'dart:typed_data';

enum InputAnalysisImageFormat { yuv_420_888, nv21, jpeg, unknown }

InputAnalysisImageFormat inputAnalysisImageFormatParser(String value) {
  switch (value) {
    case 'yuv_420_888': // android.graphics.ImageFormat.YUV_420_888
      return InputAnalysisImageFormat.yuv_420_888;
    case 'jpeg': // android.graphics.ImageFormat.JPEG
      return InputAnalysisImageFormat.jpeg;
    case 'nv21':
      return InputAnalysisImageFormat.nv21;
  }
  return InputAnalysisImageFormat.unknown;
}

class AnalysisConfig {
  final InputAnalysisImageFormat outputFormat;
  final int width;

  AnalysisConfig({
    required this.outputFormat,
    required this.width,
  });
}

class AnalysisParams {
  InputAnalysisImageFormat format;
  int? width;
  int? height;

  AnalysisParams({
    required this.format,
    this.width,
    this.height,
  });
}

class AnalysisImage {
  int height;
  int width;
  List<ImagePlane> planes;
  InputAnalysisImageFormat format;
  int rotation;
  Uint8List? nv21Image;

  AnalysisImage({
    required this.height,
    required this.width,
    required this.planes,
    required this.format,
    required this.rotation,
    this.nv21Image,
  });

  factory AnalysisImage.from(Map<String, dynamic> map) {
    return AnalysisImage(
      height: map["height"],
      width: map["width"],
      planes: (map["planes"] as List<dynamic>)
          .map((e) => ImagePlane.from(Map<String, dynamic>.from(e)))
          .toList(),
      format: inputAnalysisImageFormatParser(map["format"]),
      rotation: map["rotation"],
      nv21Image: map.containsKey("nv21Image") ? map["nv21Image"] : null,
    );
  }
}

class ImagePlane {
  Uint8List bytes;
  int rowStride;
  int pixelStride;

  ImagePlane({
    required this.bytes,
    required this.rowStride,
    required this.pixelStride,
  });

  factory ImagePlane.from(Map<String, dynamic> map) {
    return ImagePlane(
      bytes: map["bytes"],
      rowStride: map["rowStride"],
      pixelStride: map["pixelStride"],
    );
  }
}
