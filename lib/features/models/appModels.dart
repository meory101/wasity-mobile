// ignore: file_names
import 'dart:convert';
import 'dart:ui';

import 'package:wasity/core/resource/color_manager.dart';
import 'package:wasity/features/api/api_link.dart';

//!AddressModel
class Address {
  final int? id; 
  final String name;
  final double lat;
  final double long;
  final int clientId;

  Address({
    this.id,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lat': lat,
      'long': long,
      'client_id': clientId,
    };
  }

  // Map<String, dynamic> toJsonWithoutClientId() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'lat': lat,
  //     'long': long,
  //   };
  // }
}
class UpdateAddress {
  final int id;
  final double lat;
  final double long;
  final String name;

  UpdateAddress({
    required this.id,
    required this.lat,
    required this.long,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'long': long,
      'name': name,
    };
  }
}

//!ProfileModel

class ClientProfile {
  final String name;
  final String email;
  final String birthDate;
  final String gender;
  final String profileImage;
  final int points;

  ClientProfile({
    required this.name,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.profileImage,
    required this.points, 
  });

  factory ClientProfile.fromJson(Map<String, dynamic> json) {
    return ClientProfile(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      birthDate: json['birth_date'] ?? '',
      gender: json['gender'] ?? '2',
      profileImage: json['image'] != null
          ? '${Config.imageUrl}/${json['image']}'
          : '',
      points: json['points'] ?? 0,
    );
  }
}


//!Product data model
class Product {
  int id;
  String name;
  String desc;
  String image;
  double price;
  int sizeType;
  int procountity;
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
    required this.procountity,
    required this.subBranchId,
    required this.brandId,
    this.subCategoryId,
    required this.rate,
    this.subCategory,
    required this.brand,
    required this.subBranch,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    if (json['product'] == null) {
      throw Exception("Product data is missing");
    }

    return Product(
      id: json['product']['id'] ?? 0,
      name: json['product']['name'] ?? '',
      desc: json['product']['desc'] ?? '',
      image: json['product']['image'] ?? '',
      price: json['product']['price'] != null
          ? json['product']['price'].toDouble()
          : 0.0,
      sizeType: json['product']['size_type'] ?? 0,
      procountity: json['product']['count'] ?? 0,
      subBranchId: json['product']['sub_branch_id'] ?? 0,
      brandId: json['product']['brand_id'] ?? 0,
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
        'count': procountity,
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
class ProductforOrder {
  final int? id;
  final String? name;
  final String? desc;
  final String? image;
  final int? price;
  final int? sizeType;
  final int? count;
  final int? subBranchId;
  final int? brandId;
  final int? subCategoryId;
  final String? createdAt;
  final String? updatedAt;

  ProductforOrder({
    this.id,
    this.name,
    this.desc,
    this.image,
    this.price,
    this.sizeType,
    this.count,
    this.subBranchId,
    this.brandId,
    this.subCategoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductforOrder.fromJson(Map<String, dynamic> json) {
    return ProductforOrder(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      image: json['image'],
      price: json['price'],
      sizeType: json['size_type'],
      count: json['count'],
      subBranchId: json['sub_branch_id'],
      brandId: json['brand_id'],
      subCategoryId: json['sub_category_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
class Order {
  final int? id;
  final String? orderNumber;
  final int? statusCode;
  final int? deliveryType;
  final int? subTotal;
  final int? total;
  final int? deliveryFee;
  final int? clientId;
  final int? deliveryManId;
  final int? addressId;
  final String? createdAt;
  final String? updatedAt;
  final List<ProductforOrder>? products;

  Order({
    this.id,
    this.orderNumber,
    this.statusCode,
    this.deliveryType,
    this.subTotal,
    this.total,
    this.deliveryFee,
    this.clientId,
    this.deliveryManId,
    this.addressId,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List?;
    List<ProductforOrder>? productsList = productList?.map((i) => ProductforOrder.fromJson(i)).toList();

    return Order(
      id: json['order']['id'],
      orderNumber: json['order']['order_number'],
      statusCode: json['order']['status_code'],
      deliveryType: json['order']['delivery_type'],
      subTotal: json['order']['sub_total'],
      total: json['order']['total'],
      deliveryFee: json['order']['delivery_fee'],
      clientId: json['order']['client_id'],
      deliveryManId: json['order']['delivery_man_id'],
      addressId: json['order']['address_id'],
      createdAt: json['order']['created_at'],
      updatedAt: json['order']['updated_at'],
      products: productsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': {
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
        'created_at': createdAt,
        'updated_at': updatedAt,
      },
      'products': products?.map((product) => product.toJson()).toList(),
    };
  }
}
