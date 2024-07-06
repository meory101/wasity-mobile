class AppImageManager {
  static const String _imageBasePath = 'assets/images';

  static String personalImage = '$_imageBasePath/placeholder.png';
  static String offerImage = '$_imageBasePath/placeholder.png';
  static String categoryImage = '$_imageBasePath/placeholder.png';
  
  /// this path is the base path for splash image
  /// pass the splash id to change the image path
  static String splash({String? splashId}) =>
      '$_imageBasePath/splash${splashId != null ? "_$splashId" : ""}.png';
}
