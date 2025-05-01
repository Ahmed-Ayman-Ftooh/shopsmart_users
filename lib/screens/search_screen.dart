import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopsmart_users/providers/product_providers.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

import '../Models/product_model.dart';
import '../services/assets_manager.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

import '../widgets/products/product_widget.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModels> productListSearch = [];
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProviders>(context);

    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;

    final List<ProductModels> productList =
        passedCategory == null
            ? productProvider.getProducts
            : productProvider.findByCategory(ctgName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TitlesTextWidget(label: passedCategory ?? "Search"),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
        ),
        body:
        // productList.isEmpty
        //         ? const Center(
        //           child: TitlesTextWidget(label: "No product found"),
        //         )
        //         :
        StreamBuilder<List<ProductModels>>(
          stream: productProvider.fetchProductsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: TitlesTextWidget(
                  label: "An error has been occured ${snapshot.error}",
                ),
              );
            } else if (snapshot.data == null) {
              return Center(child: TitlesTextWidget(label: "No product found"));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 15.0),
                  TextField(
                    controller: searchTextController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // setState(() {
                          searchTextController.clear();
                          FocusScope.of(context).unfocus();
                          // });
                        },
                        child: const Icon(Icons.clear, color: Colors.red),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        productListSearch = productProvider.searchQuery(
                          passedList: productList,
                          searchText: searchTextController.text,
                        );
                      });
                    },
                    onSubmitted: (value) {
                      // setState(() {
                      //   productListSearch = productProvider.searchQuery(
                      //     productTitle: searchTextController.text,
                      //     passedList: productList,
                      //   );
                      // });
                    },
                  ),
                  const SizedBox(height: 15.0),
                  if (searchTextController.text.isNotEmpty &&
                      productListSearch.isEmpty) ...[
                    const Center(
                      child: TitlesTextWidget(
                        label: "No results found",
                        fontSize: 40,
                      ),
                    ),
                  ],
                  Expanded(
                    child: DynamicHeightGridView(
                      itemCount:
                          searchTextController.text.isNotEmpty
                              ? productListSearch.length
                              : productList.length,
                      builder: ((context, index) {
                        return ProductWidget(
                          productId:
                              searchTextController.text.isNotEmpty
                                  ? productListSearch[index].productId
                                  : productList[index].productId,
                        );
                      }),
                      crossAxisCount: 2,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
