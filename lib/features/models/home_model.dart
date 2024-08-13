

// //?Home Model
// class MainCategory {
//   final int id;
//   final String name;
//   final String image;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   MainCategory({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory MainCategory.fromJson(Map<String, dynamic> json) {
//     return MainCategory(
//       id: json['id'],
//       name: json['name'],
//       image: json['image'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }

// class NewItem {
//   final int id;
//   final String name;
//   final String image;
//   final int price;
//   final int subBranchId;
//   final int brandId;
//   final int subCategoryId;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   NewItem({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.price,
//     required this.subBranchId,
//     required this.brandId,
//     required this.subCategoryId,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory NewItem.fromJson(Map<String, dynamic> json) {
//     return NewItem(
//       id: json['id'],
//       name: json['name'],
//       image: json['image'],
//       price: json['price'],
//       subBranchId: json['sub_branch_id'],
//       brandId: json['brand_id'],
//       subCategoryId: json['sub_category_id'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }

// class ClientHomeResponse {
//   final MainCategory mainCategory;
//   final List<NewItem> newItems;

//   ClientHomeResponse({
//     required this.mainCategory,
//     required this.newItems,
//   });

//   factory ClientHomeResponse.fromJson(Map<String, dynamic> json) {
//     var newItemsList = json['newItems'] as List;
//     List<NewItem> newItems = newItemsList.map((i) => NewItem.fromJson(i)).toList();

//     return ClientHomeResponse(
//       mainCategory: MainCategory.fromJson(json['mainCategory']),
//       newItems: newItems,
//     );
//   }
// }

// List<ClientHomeResponse> parseClientHomeResponse(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

//   return parsed.map<ClientHomeResponse>((json) => ClientHomeResponse.fromJson(json)).toList();
// }