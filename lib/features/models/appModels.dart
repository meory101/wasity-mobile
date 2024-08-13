import 'dart:convert';

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
//!SubCategory
class SubCategory {
  final int id;
  final String name;
  final String image;

  SubCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

//!EditUserProfile
class UserProfile {
  final int id;
  final String name;
  final String email;
  final String gender;
  final String? birthDate;
  final String number;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    this.birthDate,
    required this.number,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      birthDate: json['birth_date'],
      number: json['number'],
    );
  }
}
//!NewArrivais
class NewItem {
  final int id;
  final String name;
  final String image;
  final double price;

  NewItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  factory NewItem.fromJson(Map<String, dynamic> json) {
    return NewItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }
}

class NewArrivaisData {
  final MainCategory mainCategory;
  final List<NewItem> newItems;

  NewArrivaisData({
    required this.mainCategory,
    required this.newItems,
  });

  factory NewArrivaisData.fromJson(Map<String, dynamic> json) {
    var list = json['newItems'] as List;
    List<NewItem> newItemsList = list.map((i) => NewItem.fromJson(i)).toList();

    return NewArrivaisData(
      mainCategory: MainCategory.fromJson(json['mainCategory']),
      newItems: newItemsList,
    );
  }
}

//!BrandModel
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




//!ProductModel
class Product {
  final int id;
  final String name;
  final String image;
  final double price;
  // final Brand brand;
  // final SubCategory subCategory;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    // required this.brand,
    // required this.subCategory,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final productData = json['product'];
    return Product(
      id: productData['id'],
      name: productData['name'],
      image: productData['image'],
      price: productData['price'].toDouble(),
      // brand: Brand.fromJson(productData['brand']),
      // subCategory: SubCategory.fromJson(productData['sub_category']),
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


