import 'package:flutter/material.dart';
import 'package:pr_1/Provider/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Provider/Contact_provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<themeprovider>(context, listen: false).changetheme();
            },
            icon: Icon(
              (Provider.of<themeprovider>(context, listen: true).theme.isdark ==
                      false)
                  ? Icons.sunny
                  : Icons.brightness_4,
            ),
          )
        ],
        centerTitle: true,
        title: const Text(" Home page "),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("contact_page");
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: (ContactProvider.allContacts.isNotEmpty)
          ? ListView.builder(
              itemCount: ContactProvider.allContacts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'details',
                        arguments: ContactProvider.allContacts[index]);
                  },
                  child: ListTile(
                    title: Text(
                      "${ContactProvider.allContacts[index].FirstName}",
                    ),
                    subtitle: Text(
                        "${ContactProvider.allContacts[index].MobileNumber}"),
                    leading: const CircleAvatar(
                      radius: 30,
                      child: Center(child: Text("Image")),
                    ),
                    // CircleAvatar(
                    //     radius: 30,
                    //     foregroundImage: FileImage(File(Global.pic!.path)),
                    // ),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'hidden',
                            arguments: ContactProvider.allContacts[index]);
                        ContactProvider.hiddenContact
                            .add(ContactProvider.allContacts[index]);
                        setState(() {
                          ContactProvider.allContacts.removeAt(index);
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Contacts Added yet.....",
                      // "${Provider.of<CounterProvider>(context, listen: true).count.count}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ]),
            ),
    );
  }
}
