// ignore: file_names
import 'dart:convert';
import 'dart:ui';

import 'package:wasity/core/resource/color_manager.dart';

//!AddressModel

class Address {
  final int id;
  final String name;
  final double lat;
  final double long;
  final int clientId;

  Address({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.clientId,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      lat: json['lat'].toDouble(),
      long: json['long'].toDouble(),
      clientId: json['client_id'],
    );
  }
}
// //!ProfileModel

// class ProfileModel {
//   String name;
//   String email;
//   String birthdate;
//   int gender;

//   ProfileModel({
//     required this.name,
//     required this.email,
//     required this.birthdate,
//     required this.gender,
//   });

//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       birthdate: json['birthdate'] ?? '',
//       gender: json['gender'] == 'Female' ? 1 : 2,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'email': email,
//       'birthdate': birthdate,
//       'gender': gender.toString(),
//     };
//   }
// }

// //!EditUserProfile
// class UserProfile {
//   final int id;
//   final String name;
//   final String email;
//   final String gender;
//   final String? birthDate;
//   final String number;

//   UserProfile({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.gender,
//     this.birthDate,
//     required this.number,
//   });

//   factory UserProfile.fromJson(Map<String, dynamic> json) {
//     return UserProfile(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       gender: json['gender'],
//       birthDate: json['birth_date'],
//       number: json['number'],
//     );
//   }
// }
//!Product data model
class Product {
  int id;
  String name;
  String desc;
  String image;
  double price;
  int sizeType;
  int count;
  int subBranchId;
  int brandId;
  int? subCategoryId;

  double? rate;
  SubCategory? subCategory;
  Brand brand;
  SubBranch subBranch;

  Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
    required this.price,
    required this.sizeType,
    required this.count,
    required this.subBranchId,
    required this.brandId,
    this.subCategoryId,
    required this.rate,
    this.subCategory,
    required this.brand,
    required this.subBranch,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product']['id'],
      name: json['product']['name'],
      desc: json['product']['desc'],
      image: json['product']['image'],
      price: json['product']['price'].toDouble(),
      sizeType: json['product']['size_type'],
      count: json['product']['count'],
      subBranchId: json['product']['sub_branch_id'],
      brandId: json['product']['brand_id'],
      subCategoryId: json['product']['sub_category_id'],

      rate: json['rate'] != null ? json['rate'].toDouble() : 0.0,
      subCategory: json['subCategory'] != null
          ? SubCategory.fromJson(json['subCategory'])
          : null,
      brand: Brand.fromJson(json['brand']),
      subBranch: SubBranch.fromJson(json['subBranch']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': {
        'id': id,
        'name': name,
        'desc': desc,
        'image': image,
        'price': price,
        'size_type': sizeType,
        'count': count,
        'sub_branch_id': subBranchId,
        'brand_id': brandId,
        'sub_category_id': subCategoryId,
      },
      'rate': rate,
      'subCategory': subCategory?.toJson(),
      'brand': brand.toJson(),
      'subBranch': subBranch.toJson(),
    };
  }
}

//!SubCategory
class SubCategory {
  int id;
  String name;
  String image;
  int mainCategoryId;

  SubCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.mainCategoryId,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      mainCategoryId: json['main_category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'main_category_id': mainCategoryId,
    };
  }
}


// //!SubBranchModel

class SubBranch {
  final int id;
  final String name;
  final String image;
  final int activeStatus;
  final double lat;
  final double long;
  int mainBranchId;

  SubBranch({
    required this.id,
    required this.name,
    required this.image,
    required this.activeStatus,
    required this.lat,
    required this.long,
    required this.mainBranchId,
  });

  factory SubBranch.fromJson(Map<String, dynamic> json) {
    return SubBranch(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      activeStatus: json['active_status'],
      lat: json['lat'].toDouble(),
      long: json['long'].toDouble(),
      mainBranchId: json['main_branch_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'active_status': activeStatus,
      'lat': lat,
      'long': long,
      'main_branch_id': mainBranchId,
    };
  }


  String get status => activeStatus == 1 ? 'Available' : 'Stopped';

  Color get statusColor =>
      activeStatus == 1 ? AppColorManager.green : AppColorManager.red;
}

//!MainCategory
class MainCategory {
  final int id;
  final String name;
  final String image;

  MainCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    return MainCategory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

// //!MainBranchModel
class MainBranchModel {
  final int id;
  final String name;
  final String image;

  MainBranchModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory MainBranchModel.fromJson(Map<String, dynamic> json) {
    return MainBranchModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

// //!BrandModel
class Brand {
  final int id;
  final String name;
  final String image;

  Brand({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}

List<Brand> parseBrands(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Brand>((json) => Brand.fromJson(json)).toList();
}
//!Order model 

class OrderResponse {
  final Order order;
  final List<ProductItem> products;

  OrderResponse({
    required this.order,
    required this.products,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      order: Order.fromJson(json['order']),
      products: (json['products'] as List<dynamic>).map((item) => ProductItem.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order.toJson(),
      'products': products.map((item) => item.toJson()).toList(),
    };
  }
}

class Order {
  final int id;
  final String orderNumber;
  final int statusCode;
  final int deliveryType;
  final double subTotal;
  final double? total;
  final double? deliveryFee;
  final int clientId;
  final int? deliveryManId;
  final int addressId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.orderNumber,
    required this.statusCode,
    required this.deliveryType,
    required this.subTotal,
    this.total,
    this.deliveryFee,
    required this.clientId,
    this.deliveryManId,
    required this.addressId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderNumber: json['order_number'],
      statusCode: json['status_code'],
      deliveryType: json['delivery_type'],
      subTotal: json['sub_total'].toDouble(),
      total: json['total']?.toDouble(),
      deliveryFee: json['delivery_fee']?.toDouble(),
      clientId: json['client_id'],
      deliveryManId: json['delivery_man_id'],
      addressId: json['address_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'status_code': statusCode,
      'delivery_type': deliveryType,
      'sub_total': subTotal,
      'total': total,
      'delivery_fee': deliveryFee,
      'client_id': clientId,
      'delivery_man_id': deliveryManId,
      'address_id': addressId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class ProductItem {
  final int id;
  final int count;

  ProductItem({
    required this.id,
    required this.count,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'count': count,
    };
  }
}
