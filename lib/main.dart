import 'package:flutter/material.dart';
import 'package:pr_1/Provider/Contact_provider.dart';
import 'package:pr_1/Provider/themeprovider.dart';
import 'package:pr_1/view/Contact_page.dart';
import 'package:pr_1/view/Hiddenpage.dart';
import 'package:pr_1/view/Homepage.dart';
import 'package:pr_1/view/details_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<ContactProvider>(
          create: (ctx) => ContactProvider(),
        ),
        ListenableProvider<themeprovider>(
          create: (ctx) => themeprovider(),
        ),
      ],
      builder: (ctx, _) => MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode:
            (Provider.of<themeprovider>(ctx, listen: true).theme.isdark ==
                    false)
                ? ThemeMode.dark
                : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const Homepage(),
          'contact_page': (context) => Contact(),
          'details': (context) => const Details(),
          'hidden': (context) => Hiddenpage(),
        },
      ),
    ),
  );
}
