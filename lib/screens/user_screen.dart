import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/myWidgets/my_textbox.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final userCollection = FirebaseFirestore.instance.collection("Users");
  final currentUser = FirebaseAuth.instance.currentUser;
  Uint8List? image;
  bool _isImagePickerActive = false;

  Future<void> selectImage() async {
    if (_isImagePickerActive) return;

    _isImagePickerActive = true;

    try {
      Uint8List? img = await pickImage(ImageSource.gallery);
      if (img != null) {
        setState(() {
          image = img;
        });

        // Upload image to Firebase Storage
        Reference ref = FirebaseStorage.instance
            .ref()
            .child("profilePics")
            .child(currentUser!.uid)
            .child("profilePic.png");

        UploadTask uploadTask = ref.putData(img);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Save image URL to Firestore
        await userCollection.doc(currentUser!.email).update({
          'profilePic': downloadUrl,
        });
      }
    } catch (e) {
      print("Image selection failed: $e");
    } finally {
      _isImagePickerActive = false;
    }
  }

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[700],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser!.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile Page",
          style: TextStyle(fontFamily: "Hellix"),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userCollection.doc(currentUser!.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data!.exists) {
              return const Center(
                child: Text("User data does not exist."),
              );
            }

            final userData = snapshot.data!.data() as Map<String, dynamic>?;
            if (userData == null) {
              return const Center(
                child: Text("No user data available."),
              );
            }

            String? profilePicUrl = userData['profilePic'];

            return ListView(
              children: [
                const SizedBox(height: 50),
                Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(64),
                        child: FadeInImage.assetNetwork(
                          placeholder: "lib/assets/images/user.jpg",
                          image: profilePicUrl ?? '',
                          imageErrorBuilder: (context, error, stackTrace) {
                            return const CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  AssetImage("lib/assets/images/user.jpg"),
                            );
                          },
                          fit: BoxFit.cover,
                          width: 128,
                          height: 128,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 210,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo_rounded),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  currentUser!.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "hellix",
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    "My Details",
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  ),
                ),
                MyTextbox(
                  sectionName: "username",
                  text: userData["name"] ?? "No name provided",
                  onPressed: () => editField("name"),
                ),
                MyTextbox(
                  sectionName: "phone number",
                  text: userData["number"] ?? "No number provided",
                  onPressed: () => editField("number"),
                ),
                MyTextbox(
                  sectionName: "bio",
                  text: userData["bio"] ?? "No bio provided",
                  onPressed: () => editField("bio"),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(source: source);

  if (pickedFile != null) {
    return await pickedFile.readAsBytes();
  }
  print("No image selected");
  return null;
}
