import 'package:flutter/material.dart';
import 'package:pr_1/Provider/Contact_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Hiddenpage extends StatelessWidget {
  const Hiddenpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hidden Cotact"),
        centerTitle: true,
      ),
      body: (ContactProvider.hiddenContact.isNotEmpty)
          ? ListView.builder(
              itemCount: ContactProvider.hiddenContact.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  title: Text(
                    "${ContactProvider.hiddenContact[index].FirstName}",
                  ),
                  subtitle: Text(
                      "${ContactProvider.hiddenContact[index].MobileNumber}"),
                  trailing: IconButton(
                    onPressed: () async {
                      launchUrl(
                        Uri(
                            scheme: 'tel',
                            path:
                                "${ContactProvider.hiddenContact[index].MobileNumber}"),
                      );
                    },
                    icon: const Icon(Icons.phone),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                "Hidde Contacts Not Avilable...",
                style: TextStyle(fontSize: 24),
              ),
            ),
    );
  }
}
