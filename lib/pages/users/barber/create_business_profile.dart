import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:glamify/services/database.dart';
import 'dart:io';

class CreateBusinessProfile extends StatefulWidget {
  const CreateBusinessProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateBusinessProfileState createState() => _CreateBusinessProfileState();
}

class _CreateBusinessProfileState extends State<CreateBusinessProfile> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController salonNameController = TextEditingController();
  final TextEditingController salonAddressController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController servicesController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Business Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  //  key: _formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          // backgroundColor: Colors.black,
                          backgroundImage:
                              _image != null ? FileImage(_image!) : null,
                          child:
                              _image == null
                                  ? const Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                    color: Colors.white,
                                  )
                                  : null,
                        ),
                      ),

                      // **Saloon Name Field
                      SizedBox(height: 16),
                      TextField(
                        controller: salonNameController,
                        decoration: InputDecoration(
                          labelText: 'Saloon Name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          icon: Icon(
                            Icons.store_mall_directory_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      // **Saloon Address**
                      SizedBox(height: 15),
                      TextField(
                        controller: salonAddressController,
                        decoration: InputDecoration(
                          labelText: 'Saloon Address',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          icon: Icon(Icons.place_sharp, color: Colors.black),
                        ),
                      ),

                      //**Latitude**
                      SizedBox(height: 15),
                      TextField(
                        controller: latitudeController,
                        decoration: InputDecoration(
                          labelText: 'Latitude',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          icon: Icon(Icons.place_sharp, color: Colors.black),
                        ),
                        keyboardType: TextInputType.number,
                      ),

                      //**Longitude**
                      SizedBox(height: 15),
                      TextField(
                        controller: longitudeController,
                        decoration: InputDecoration(
                          labelText: 'Longitude',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          icon: Icon(Icons.place_sharp, color: Colors.black),
                        ),
                        keyboardType: TextInputType.number,
                      ),

                      // **Add Services **
                      SizedBox(height: 15),
                      TextField(
                        controller: servicesController,
                        decoration: InputDecoration(
                          labelText: 'Add Services ',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          icon: Icon(Icons.store, color: Colors.black),
                        ),
                      ),

                      // **Submit Button**
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          // onPressed: (){},
                          onPressed: () async {
                            if (_image != null &&
                                salonNameController.text != "" &&
                                salonAddressController.text != "" &&
                                latitudeController.text != "" &&
                                longitudeController.text != "" &&
                                servicesController.text != "") {
                              String addID = randomAlphaNumeric(10);

                              Map<String, dynamic> SalonShopsInfoMap = {
                                "SalonImage": _image,
                                "SalonName": salonNameController.text,
                                "SalonAddress": salonAddressController.text,
                                "Latitude": latitudeController.text,
                                "Longitude": longitudeController.text,
                                "Services": servicesController.text,
                              };

                              await DatabaseMethods()
                                  .addStudents(SalonShopsInfoMap, addID)
                                  .then((value) {
                                    salonNameController.text = " ";
                                    salonAddressController.text = "";
                                    latitudeController.text = "";
                                    longitudeController.text = "";
                                    servicesController.text = "";

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          "Student data has been uploaded !!!",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 90,
                              vertical: 20,
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
