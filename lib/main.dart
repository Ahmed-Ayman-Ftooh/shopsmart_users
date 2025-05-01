import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/consts/app_api_keys.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/order_provider.dart';
import 'package:shopsmart_users/providers/product_providers.dart';
import 'package:shopsmart_users/providers/theme_provider.dart';
import 'package:shopsmart_users/providers/user_provider.dart';
import 'package:shopsmart_users/providers/viewed_prod_provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/screens/Inner_Screens/viewed_recently.dart';
import 'package:shopsmart_users/screens/Payment/payment_screen.dart';
import 'package:shopsmart_users/screens/Payment/payment_successful_screen.dart';
import 'package:shopsmart_users/screens/auth/forgot_password.dart';
import 'package:shopsmart_users/screens/search_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'consts/theme_data.dart';
import 'root_screen.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/inner_screens/orders/orders_screen.dart';
import 'screens/inner_screens/product_details.dart';
import 'screens/inner_screens/wishlist.dart';

const supabaseUrl = 'https://dbulggkpnofchjcxminf.supabase.co';
// const supabaseKey = String.fromEnvironment(
//   'SUPABASE_KEY',
//   defaultValue:
//       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRidWxnZ2twbm9mY2hqY3htaW5mIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMxNzA3MTEsImV4cCI6MjA1ODc0NjcxMX0.9N3981h2IybWpR8tbcu-1S1Gyq-qrUE74OR3WcswxNc',
// );

//'Hello World!';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = ApiKeys.publishableKeys;
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRidWxnZ2twbm9mY2hqY3htaW5mIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMxNzA3MTEsImV4cCI6MjA1ODc0NjcxMX0.9N3981h2IybWpR8tbcu-1S1Gyq-qrUE74OR3WcswxNc',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: SelectableText(
                  "An error has been occured ${snapshot.error}",
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ThemeProvider()),
              ChangeNotifierProvider(create: (_) => ProductProviders()),
              ChangeNotifierProvider(create: (_) => CartProvider()),
              ChangeNotifierProvider(create: (_) => WishlistProvider()),
              ChangeNotifierProvider(create: (_) => ViewedProdProvider()),
              ChangeNotifierProvider(create: (_) => UserProvider()),
              ChangeNotifierProvider(create: (_) => OrdersProvider()),
            ],
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Shop Smart AR',
                  theme: Styles.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context,
                  ),
                  home: const RootScreen(),
                  // home: const RegisterScreen(),
                  routes: {
                    ProductDetails.routName:
                        (context) => const ProductDetails(),
                    WishlistScreen.routName:
                        (context) => const WishlistScreen(),
                    ViewedRecentlyScreen.routName:
                        (context) => const ViewedRecentlyScreen(),
                    RegisterScreen.routName:
                        (context) => const RegisterScreen(),
                    LoginScreen.routName: (context) => const LoginScreen(),
                    OrdersScreenFree.routeName:
                        (context) => const OrdersScreenFree(),
                    ForgotPasswordScreen.routeName:
                        (context) => const ForgotPasswordScreen(),
                    SearchScreen.routeName: (context) => const SearchScreen(),
                    PaymentScreen.routeName: (context) => const PaymentScreen(),
                    RootScreen.routName: (context) => const RootScreen(),
                    PaymentSuccessfulScreen.routName:
                        (context) => const PaymentSuccessfulScreen(),
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
