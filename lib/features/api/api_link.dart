import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/core/storage/shared/shared_pref.dart';
import 'package:wasity/features/models/appModels.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static const String baseUrl = 'http://192.168.1.104:8000/api';
  static const String imageUrl = 'http://192.168.1.104:8000/storage';

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
      if (kDebugMode) {
        print('Error fetching trending products: $e');
      }
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
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/getAddressesByClientId/$clientId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Address.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load addresses: ${response.body}');
    }
  }

  //? AddAddresses
  Future<void> addAddress(Address address) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/addAddress'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': address.name,
        'lat': address.lat,
        'long': address.long,
        'client_id': address.clientId,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add address: ${response.body}');
    }
  }

  //? UpdateAddress
  Future<void> updateAddress(UpdateAddress address) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/updateAddress'),
      body: jsonEncode(address.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      print(
          'Updating address: name: ${address.name}, id: ${address.id}, ${address.long}, ${address.lat}');

      print(
          'Failed to update address:++++++++++++++++++++++++++++++++++++++++++++ ${response.body}');
      throw Exception('Failed to update address');
    }
  }

  // Future<void> updateAddress(Address address) async {
  //   print(
  //       'Updating address:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${jsonEncode(address.toJsonWithoutClientId())}');

  //   final response = await http.post(
  //     Uri.parse('${Config.baseUrl}/updateAddress'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(address.toJsonWithoutClientId()),
  //   );
  //   print('Response: ${response.body}');

  //   if (response.statusCode != 200 && response.statusCode != 201) {
  //     throw Exception('Failed to update address: ${response.body}');
  //   }
  // }
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
    Uri.parse('${Config.baseUrl}/getProductsBySubBranchId/$subBranchId'),
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

//!Add rate
class RateService {
  static Future<void> submitRating(double value, int productId) async {
    String clientId = AppSharedPreferences.getClientId();

    if (clientId.isEmpty) {
      if (kDebugMode) {
        print('Error: Client ID is null or empty');
      }
      return;
    }

    int? clientIdParsed = int.tryParse(clientId);
    if (clientIdParsed == null) {
      if (kDebugMode) {
        print('Error: Invalid Client ID');
      }
      return;
    }

    // تجهيز البيانات
    Map<String, dynamic> data = {
      "value": value.toStringAsFixed(1),
      "product_id": productId,
      "client_id": clientIdParsed,
    };

    try {
      if (kDebugMode) {
        print(clientId);
      }

      final response = await http.post(
        Uri.parse('${Config.baseUrl}/rateProduct'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Rating submitted successfully');
        }
      } else {
        if (kDebugMode) {
          print(
              'Error submitting rating: ${response.statusCode} - ${response.body}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }
}

//!GetProfile

class ClientProfileService {
  Future<ClientProfile?> fetchClientProfile() async {
    String clientId = AppSharedPreferences.getClientId();
    final url = Uri.parse('${Config.baseUrl}/getClientProfile/$clientId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ClientProfile.fromJson(data);
      } else {
        if (kDebugMode) {
          print('Failed to load profile data');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return null;
    }
  }
}

//!UpdateProfile
class ClientProfileServices {
  // Method to update the client profile
  Future<http.Response?> updateClientProfile({
    required String name,
    required String email,
    required String birthDate,
    required String gender,
    File? imageFile,
  }) async {
    String clientId = AppSharedPreferences.getClientId();
    final url = Uri.parse('${Config.baseUrl}/updateClientProfile');

    final request = http.MultipartRequest('POST', url);

    // Add text fields
    request.fields['id'] = clientId;
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['birth_date'] = birthDate;
    request.fields['gender'] = gender;

    // Add the image if selected
    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );
    }

    try {
      final response = await request.send();
      return await http.Response.fromStream(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating profile: $e');
      }
      return null;
    }
  }
}

//!Wallet
class WalletService {
  static Future<double?> fetchAccountData(int type) async {
    String clientId = AppSharedPreferences.getClientId();

    if (clientId.isNotEmpty) {
      final response = await http.post(
        Uri.parse('${Config.baseUrl}/getAccount'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'type': type,
          'client_id': clientId,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['balance']?.toDouble() ?? 0.0;
      } else {
        if (kDebugMode) {
          print('Error: ${response.statusCode}');
        }
        return null;
      }
    } else {
      if (kDebugMode) {
        print('Client ID is empty');
      }
      return null;
    }
  }

  static Future<int?> fetchPoints() async {
    return AppSharedPreferences.getPoints();
  }
}

//!OrderService
class OrderService {
  Future<List<Order>> fetchOrders() async {
    String clientId = AppSharedPreferences.getClientId();
    if (kDebugMode) {
      print("Fetching orders for client ID: $clientId");
    }

    final response = await http.get(
      Uri.parse('${Config.baseUrl}/getClientOrders/$clientId'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      if (kDebugMode) {
        print("Orders response: $jsonResponse");
      }
      return jsonResponse.map((order) => Order.fromJson(order)).toList();
    } else {
      if (kDebugMode) {
        print("Failed to fetch orders. Status code: ${response.statusCode}");
      }
      throw Exception('Failed to load orders');
    }
  }

  Map<String, dynamic> getStatusInfo(int statusCode) {
    switch (statusCode) {
      case 0:
        return {'text': 'Pending', 'color': AppColorManager.yellow};
      case 1:
        return {'text': 'Accepted', 'color': AppColorManager.green};
      case 2:
        return {'text': 'On the way', 'color': AppColorManager.blue};
      case 3:
        return {'text': 'Delivered', 'color': AppColorManager.grey};
      case 4:
        return {'text': 'rejected', 'color': AppColorManager.red};
      default:
        return {'text': 'Unknown', 'color': AppColorManager.black};
    }
  }
}
//!Place Order


class PlaceOrderService {
  Future<void> placeOrder({
    required int payType,
    required int addressId,
    required int clientId,
    required int deliveryType,
    required List<dynamic> cartItems,
  }) async {
    try {
      final itemsJson = jsonEncode(cartItems);

      final response = await http.post(
        Uri.parse('${Config.baseUrl}/addOrder'),
        body: {
          'pay_type': payType.toString(),
          'address_id': addressId.toString(),
          'client_id': clientId.toString(),
          'delivery_type': deliveryType.toString(),
          'items': itemsJson,
        },
      );

      if (response.statusCode == 200) {
        print("Order placed successfully");
        print("Response: ${response.body}");
      } else {
        print('Failed to add Order: ${response.statusCode}');
        print('Error body: ${response.body}');
        throw Exception('Failed to add Order');
      }
    } catch (e) {
      print('Error occurred while placing order: $e');
      throw Exception('Error occurred while placing order');
    }
  }
}
