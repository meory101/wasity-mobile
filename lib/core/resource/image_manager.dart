class AppImageManager {
  static const String _imageBasePath = 'assets/images';

  static String personalImage = '$_imageBasePath/placeholder.png';
  static String offerImage = '$_imageBasePath/placeholder.png';
  static String categoryImage = '$_imageBasePath/placeholder.png';

  static String subCategoryImage = '$_imageBasePath/placeholder.png';
  static String productImage = '$_imageBasePath/placeholder.png';
  static String logo = '$_imageBasePath/logoo.png';
  static String logo2 = '$_imageBasePath/logo2.jpg';
  static String cash = 'assets/images/cash.png';
  static String card = 'assets/images/card.jpg';

  /// this path is the base path for splash image
  /// pass the splash id to change the image path
  static String splash({String? splashId}) =>
      '$_imageBasePath/splash${splashId != null ? "_$splashId" : ""}.png';
}
