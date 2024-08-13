import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wasity/features/models/appModels.dart';
class Config {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  
  static String getFullUrl(String endpoint) {
    return '$baseUrl/$endpoint';
  }
}

//!Auth
class OTPService {
  Future<String?> generateOTP(String number, String userType) async {
    String url = Config.getFullUrl('generateOTP');

    Map<String, dynamic> data = {
      "number": number,
      "type": 0,
    };

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "user-type": userType,
    };

    try {
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData["otp_code"].toString();
      } else {
        return Future.error(
            "Failed to generate OTP. Status code: ${response.statusCode}");
      }
    } catch (error) {
      return Future.error("Error: $error");
    }
  }

  Future<bool> verifyOTP(String number, String otpCode) async {
    String url = Config.getFullUrl('verifyOTP');

    Map<String, dynamic> data = {
      "number": number,
      "otp_code": otpCode,
    };

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(data));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return Future.error("Error: $error");
    }
  }
}

//!fetchBrands
class Brands {
  Future<List<Brand>> fetchBrands() async {
    final response = await http.get(Uri.parse(Config.getFullUrl('getBrands')));

    if (response.statusCode == 200) {
      return parseBrands(response.body);
    } else {
      throw Exception('Failed to load brands');
    }
  }
}


//!FetchNewArrivais
Future<List<NewArrivaisData>> fetchNewArrivais() async {
  final response = await http.get(Uri.parse(Config.getFullUrl('clientHome')));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((item) => NewArrivaisData.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load new arrivals');
  }
}


//!FetchMainCategories
Future<List<SubCategory>> fetchMainCategories() async {
  final response = await http.get(Uri.parse(Config.getFullUrl('getMainCatgories')));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => SubCategory.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load MainCategories');
  }
}

//!FetchSubCategories
Future<List<MainCategory>> fetchSubCategories(int mainCategoryId) async {
  final response = await http.get(Uri.parse(Config.getFullUrl('getSubCategoriesByMainCategoryId/$mainCategoryId')));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((category) => MainCategory.fromJson(category))
        .toList();
  } else {
    throw Exception('Failed to load subcategories');
  }
}

//!FetchProductsBySubCategoryId
class ProductService {
  Future<List<Product>> fetchProductsBySubCategoryId(int subCategoryId) async {
    final response = await http.get(Uri.parse(Config.getFullUrl('getProductsBySubCategoryId/$subCategoryId')));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}


// //!GetProfile
// class ProfileService {
//   final String baseUrl;

//   ProfileService({required this.baseUrl});

//   Future<Map<String, dynamic>> getProfile(int id) async {
//     final url = Uri.parse('$baseUrl/api/getClientProfile/$id');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load profile');
//     }
//   }
// //!UpdateProfile
//   Future<void> updateProfile({
//     required int id,
//     required String name,
//     required String email,
//     required String birthdate,
//     required int gender,
//   }) async {
//     final url = Uri.parse('$baseUrl/api/updateClientProfile');
//     final response = await http.post(
//       url,
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'id': id.toString(),
//         'name': name,
//         'email': email,
//         'birthdate': birthdate,
//         'gender': gender.toString(),
//       }),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Failed to update profile');
//     }
//   }
// }

//!fetchProductsBySubCategoryId
// Future<List<Product>> fetchProductsBySubCategoryId(int subCategoryId) async {
//   final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/getProductsBySubCategoryId/$subCategoryId'));

//   if (response.statusCode == 200) {
//     List<dynamic> jsonResponse = json.decode(response.body);
//     return jsonResponse.map((data) => Product.fromJson(data)).toList();
//   } else {
//     throw Exception('Failed to load products');
//   }
// }

// Product? findProductById(List<Product> products, int productId) {
//   return products.firstWhere((product) => product.id == productId, orElse: () => );
// }





