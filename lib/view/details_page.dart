import 'dart:io';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pr_1/Provider/Contact_provider.dart';
import 'package:pr_1/utils/global_varibal.dart';
import 'package:pr_1/utils/model_page.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    Contacts Number = ModalRoute.of(context)!.settings.arguments as Contacts;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'contact_page');
            },
            icon: const Icon(Icons.edit_calendar_outlined),
          ),
          PopupMenuButton(
            onSelected: (Value) async {
              if (Value == 'hidden') {
                LocalAuthentication authen = LocalAuthentication();
                bool biometric = await authen.canCheckBiometrics;
                bool mobile = await authen.isDeviceSupported();
                Navigator.of(context).pushNamed('hidden',
                    arguments: ContactProvider.allContacts[index]);
                ContactProvider.hiddenContact
                    .add(ContactProvider.allContacts[index]);

                try {
                  if (biometric == true && mobile == true) {
                    bool aut = await authen.authenticate(localizedReason: "");
                    if (aut == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Success lock "),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Plz change a Mobile..."),
                        ),
                      );
                    }
                  }
                } catch (e) {
                  print("==============================");
                  print(e);
                  print("==============================");
                }
              } else if (Value == 'setting') {
                GestureDetector(
                  onTap: () {},
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'setting',
                child: Text("setting"),
              ),
              const PopupMenuItem(
                value: 'hidden',
                child: Text("hidden_contact"),
              )
            ],
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          if (Global.pic == null)
            const CircleAvatar(
              radius: 85,
              child: Text("No Image"),
            )
          else
            CircleAvatar(
              radius: 85,
              foregroundImage: FileImage(File(Global.pic!.path)),
            ),
          Column(
            children: [
              Text(
                "${Number.MobileNumber}",
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                "${Number.FirstName}",
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () async {
                  launchUrl(
                    Uri(scheme: 'sms', path: "${Number.MobileNumber}"),
                  );
                },
                icon: const Icon(Icons.sms),
              ),
              IconButton(
                onPressed: () async {
                  launchUrl(
                    Uri(scheme: 'tel', path: "${Number.MobileNumber}"),
                  );
                },
                icon: const Icon(Icons.phone),
              ),
              IconButton(
                onPressed: () async {
                  launchUrl(
                    Uri(scheme: 'mailto', path: "${Number.Email}"),
                  );
                },
                icon: const Icon(Icons.mail),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
