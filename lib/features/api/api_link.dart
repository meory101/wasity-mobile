import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:wasity/features/models/appModels.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static const String baseUrl = 'http://192.168.1.103:8000/api';
  static const String imageUrl = 'http://192.168.1.103:8000/storage';

  static String getFullUrl(String endpoint) {
    return '$baseUrl/$endpoint';
  }
}

//! Auth
class OTPService {
  Future<Map<String, dynamic>?> generateOTP(
      String number, String userType) async {
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
        return {
          "otp_code": responseData["otp_code"].toString(),
          "client_id": responseData["client_id"].toString(),
        };
      } else {
        return Future.error(
            "Failed to generate OTP. Status code: ${response.statusCode}");
      }
    } catch (error) {
      return Future.error("Error: $error");
    }
  }

  Future<void> verifyOTPAndStoreToken(String number, String otpCode) async {
    String url = Config.getFullUrl('clientDeliveryLogin');

    Map<String, dynamic> data = {
      "number": number,
      "otp_code": otpCode,
      "type": 0,
    };
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    try {
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(data));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String token = responseData['token'];
        String userId = responseData['user']['id'].toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('user_id', userId);
      } else {
        return Future.error(
            "Failed to verify OTP. Status code: ${response.statusCode}");
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

//!Fetch Trending Products
class TrendingProductService {
  Future<List<Product>> fetchTrendingProducts() async {
    try {
      final response =
          await http.get(Uri.parse('${Config.baseUrl}/getPopulatItems'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load trending products');
      }
    } catch (e) {
      // print('Error fetching trending products: $e');
      rethrow;
    }
  }
}

//!FetchNewArrivais
Future<List<Product>> fetchNewItems() async {
  final response = await http.get(Uri.parse(Config.getFullUrl('getNewItems')));
  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load new items');
  }
}

//!FetchMainCategories
Future<List<MainCategory>> fetchCategories() async {
  final response =
      await http.get(Uri.parse('${Config.baseUrl}/getMainCatgories'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((category) => MainCategory.fromJson(category))
        .toList();
  } else {
    throw Exception('Failed to load categories');
  }
}

//!FetchSubCategories
Future<List<MainCategory>> fetchSubCategories(int mainCategoryId) async {
  final response = await http.get(Uri.parse(
      Config.getFullUrl('getSubCategoriesByMainCategoryId/$mainCategoryId')));

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
    final response = await http.get(Uri.parse(
        Config.getFullUrl('getProductsBySubCategoryId/$subCategoryId')));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

//!AddressService
class AddressService {
  //? FetchAddresses
  Future<List<Address>> fetchAddresses(int clientId) async {
    final response = await http
        .get(Uri.parse('${Config.baseUrl}/getAddressesByClientId/$clientId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Address.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load addresses');
    }
  }

//?AddAddress
  Future<void> addAddress(Address address) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/addAddress'),
      body: {
        'name': address.name,
        'lat': address.lat.toString(),
        'long': address.long.toString(),
        'client_id': address.clientId.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add address');
    }
  }

//?UpdateAddress
  Future<void> updateAddress(Address address) async {
    final response = await http.put(
      Uri.parse('${Config.baseUrl}/updateAddress'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id': address.id,
        'name': address.name,
        'lat': address.lat,
        'long': address.long,
        'client_id': address.clientId,
      }),
    );

    if (response.statusCode == 200) {
    } else {
      if (kDebugMode) {
        print('Failed to update address: ${response.body}');
      }
      throw Exception('Failed to update address');
    }
  }
}

//!fetchSubBranches
Future<List<SubBranch>> fetchSubBranches(int mainBranchId) async {
  final response = await http.get(Uri.parse(
      '${Config.baseUrl}/getSubBranchesByMainBranchId/$mainBranchId'));

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => SubBranch.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load sub-branches');
  }
}

//!FetchProducts By SubBranch Id
Future<List<Product>> fetchProductsBySubBranchId(int subBranchId) async {
  final response = await http.get(
    Uri.parse(
        'http://192.168.1.103:8000/api/getProductsBySubBranchId/$subBranchId'),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);

    return data.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}

//!FetchMainBranches
class MainBranches {
  Future<List<MainBranchModel>> fetchMainBranches() async {
    final response =
        await http.get(Uri.parse('${Config.baseUrl}/getMainBranches'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((branch) => MainBranchModel.fromJson(branch))
          .toList();
    } else {
      throw Exception('Failed to load main branches');
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

