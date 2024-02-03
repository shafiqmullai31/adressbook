import 'package:flutter/material.dart';

void main() {
  runApp(AddressBookApp());
}

class Contact {
  final String name;
  final String phoneNumber;
  final String email;

  Contact({required this.name, required this.phoneNumber, required this.email});
}

class AddressBookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Address Book',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddressBookHomePage(),
    );
  }
}

class AddressBookHomePage extends StatefulWidget {
  @override
  _AddressBookHomePageState createState() => _AddressBookHomePageState();
}

class _AddressBookHomePageState extends State<AddressBookHomePage> {
  final List<Contact> contacts = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[200],
        title: Text('Address Book'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].phoneNumber),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Contact Details'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Name: ${contacts[index].name}'),
                        Text('Phone Number: ${contacts[index].phoneNumber}'),
                        Text('Email: ${contacts[index].email}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 150.0, // Adjust the width as needed
        height: 50.0, // Adjust the height as needed
        child: FloatingActionButton(
          onPressed: () {
            _showAddContactDialog(context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add Your Details'),
              Icon(Icons.add),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  contacts.add(Contact(
                    name: nameController.text,
                    phoneNumber: phoneNumberController.text,
                    email: emailController.text,
                  ));
                  nameController.clear();
                  phoneNumberController.clear();
                  emailController.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
