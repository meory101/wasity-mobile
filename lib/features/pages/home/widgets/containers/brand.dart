import 'package:flutter/material.dart';
import 'package:wasity/core/resource/size_manager.dart';
import 'package:wasity/features/api/api_link.dart';
import 'package:wasity/features/models/appModels.dart';

class BrandList extends StatefulWidget {
  const BrandList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BrandListState createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  late Future<List<Brand>> futureBrands;

  @override
  void initState() {
    super.initState();
    futureBrands = Brands().fetchBrands();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Brand>>(
      future: futureBrands,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Brands Available'));
        }

        final brands = snapshot.data!;

        return SizedBox(
          height: AppHeightManager.h14 + AppHeightManager.h3Point5,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              final imageUrl =
                  'http://192.168.1.103:8000/storage/${brand.image}';
              print(imageUrl);
              return Padding(
                padding: EdgeInsets.only(
                    bottom: AppHeightManager.h1point8,
                    right: AppWidthManager.w1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadiusManager.r5),
                  child: SizedBox(
                    height: AppHeightManager.h10,
                    width: AppWidthManager.w30,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.error));
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
