import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/Models/user_model.dart';
import 'package:shopsmart_users/providers/user_provider.dart';
import 'package:shopsmart_users/screens/Inner_Screens/orders/orders_screen.dart';
import 'package:shopsmart_users/screens/Inner_Screens/viewed_recently.dart';
import 'package:shopsmart_users/screens/Inner_Screens/wishlist.dart';
import 'package:shopsmart_users/screens/auth/login.dart';
import 'package:shopsmart_users/screens/loading_manger.dart';
import 'package:shopsmart_users/services/my_app_method.dart';
import 'package:shopsmart_users/widgets/app_name_text.dart';
import 'package:shopsmart_users/widgets/subtitel_text.dart';

import 'package:shopsmart_users/widgets/title_text.dart';

import '../providers/theme_provider.dart';
import '../services/assets_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  UserModel? userModel;
  Future<void> fetchUserinfo() async {
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } catch (erorr) {
      if (!mounted) return;
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: 'An error occurred, $erorr',
        fct: () {},
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserinfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(fontSize: 20),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: LoadingManger(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: user == null ? true : false,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TitlesTextWidget(
                    fontSize: 18,
                    label: "Please login to have ultimate access",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              userModel == null
                  ? SizedBox.shrink()
                  : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).cardColor,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.surface,
                              width: 3,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(userModel!.userImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitlesTextWidget(label: userModel!.userName),
                            SubtitelTextWidget(lable: userModel!.userEmail),
                          ],
                        ),
                      ],
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitlesTextWidget(label: "General"),
                    userModel == null
                        ? SizedBox.shrink()
                        : CustomListTile(
                          imagePath: AssetsManager.orderSvg,
                          text: "All orders",
                          function: () async {
                            await Navigator.pushNamed(
                              context,
                              OrdersScreenFree.routeName,
                            );
                          },
                        ),
                    userModel == null
                        ? SizedBox.shrink()
                        : CustomListTile(
                          imagePath: AssetsManager.wishlistSvg,
                          text: "Wishlist",
                          function: () async {
                            await Navigator.pushNamed(
                              context,
                              WishlistScreen.routName,
                            );
                          },
                        ),
                    CustomListTile(
                      imagePath: AssetsManager.recent,
                      text: "Viewed recently",
                      function: () async {
                        await Navigator.pushNamed(
                          context,
                          ViewedRecentlyScreen.routName,
                        );
                      },
                    ),
                    CustomListTile(
                      imagePath: AssetsManager.address,
                      text: "Address",
                      function: () {},
                    ),
                    const Divider(thickness: 1),
                    const SizedBox(height: 7),
                    const TitlesTextWidget(label: "Settings"),
                    const SizedBox(height: 7),
                    SwitchListTile(
                      secondary: Image.asset(AssetsManager.theme, height: 30),
                      title: Text(
                        themeProvider.getIsDarkTheme
                            ? "Dark mode"
                            : "Light mode",
                      ),
                      value: themeProvider.getIsDarkTheme,
                      onChanged: (value) {
                        themeProvider.setDarkTheme(themeValue: value);
                      },
                    ),
                    const Divider(thickness: 1),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: Icon(
                    user == null ? Icons.login : Icons.logout,
                    color: Colors.white,
                  ),
                  label: Text(
                    user == null ? "Login" : 'Logout',
                    style: TextStyle(color: Colors.white),
                  ),

                  onPressed: () async {
                    if (user == null) {
                      await Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routName,
                      );
                    } else {
                      await MyAppMethods.showErrorORWarningDialog(
                        subtitle: "Are you sure You Want to Logout?",
                        context: context,
                        fct: () async {
                          await FirebaseAuth.instance.signOut();
                          if (!mounted) return;
                          await Navigator.pushReplacementNamed(
                            context,
                            LoginScreen.routName,
                          );
                        },
                        isError: false,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(imagePath, height: 30),
      title: SubtitelTextWidget(lable: text),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
