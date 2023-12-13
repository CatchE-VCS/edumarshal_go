import 'dart:convert';
import 'dart:ui';

import 'package:edumarshal/const/strings.dart';
import 'package:edumarshal/controllers/db_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String token = '';
  late String userRole;
  late String email;
  late String photoUrl;
  late String fname;
  late String lname;
  late String phone;
  late String aadhar;
  late String address;
  late int semester;
  late String branch;
  late int section;
  late String dob;
  late String? fatherName;
  late String? fatherPhone;
  late String? fatherEmail;
  late String? motherName;
  late String? motherPhone;
  late String? motherEmail;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    loadUserCredentials();
  }

  Future<void> loadUserCredentials() async {
    setState(() {
      // Retrieve token and role from SharedPreferences
      token = '';
      userRole = '';
    });
  }

  Future<void> fetchData() async {
    try {
      // var headers = {
      //   'Token':
      //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoic3R1ZGVudDAxIiwicm9sZSI6InN0dWRlbnQifQ.UkULa-lSkrgCyxlHi106ocV1261_YpI3tFbxRfk09lg'
      // };
      final user = await DataBaseCon().getUserById(1);
      var headers = {
        'Authorization': "Bearer ${user!.accessToken}",
        'X-ContextId': user.xContextId,
        'X-UserId': user.xUserId,
      };

      var request = http.Request(
        'GET',
        Uri.parse('${domain}api/v1/user'),
      );

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseBody);

        setState(() {
          // photoUrl = jsonData['photo_url'];
          // fname = jsonData['fname'];
          // lname = jsonData['lname'];
          // phone = jsonData['phone'];
          // aadhar = jsonData['aadhar'];
          // address = jsonData['address'];
          // semester = jsonData['semester'];
          // branch = jsonData['branch'];
          // section = jsonData['section'];
          // dob = jsonData['dob'];
          // fatherName = jsonData['father_name'];
          // fatherPhone = jsonData['father_phone'];
          // fatherEmail = jsonData['father_email'];
          // motherName = jsonData['mother_name'];
          // motherPhone = jsonData['mother_phone'];
          // motherEmail = jsonData['mother_email'];
          email = jsonData['email'];
          photoUrl = jsonData['photo_url'] ?? '';
          fname = jsonData['fname'] ?? '';
          lname = jsonData['lname'] ?? '';
          phone = jsonData['phone'] ?? '';
          aadhar = jsonData['aadhar'] ?? '';
          address = jsonData['address'] ?? '';
          semester = jsonData['semester'] ?? 0;
          branch = jsonData['branch'] ?? '';
          section = jsonData['section'] ?? 0;
          dob = jsonData['dob'] ?? '';
          fatherName = jsonData['father_name'] ?? '';
          fatherPhone = jsonData['father_phone'] ?? '';
          fatherEmail = jsonData['father_email'] ?? '';
          motherName = jsonData['mother_name'] ?? '';
          motherPhone = jsonData['mother_phone'] ?? '';
          motherEmail = jsonData['mother_email'] ?? '';
          isLoading = false;
        });
      } else {
        if (kDebugMode) {
          print('Error: ${response.reasonPhrase}');
        }
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      ' $fname  $lname ',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 175, 139, 238),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      email,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 175, 139, 238),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CircleAvatar(
                              backgroundImage: NetworkImage(photoUrl),
                              radius: 50,
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color.fromARGB(255, 214, 196, 238),
                                width: 8)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: photoUrl.isNotEmpty
                                ? Image.network(photoUrl, fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, errorBuilder: (context, object, stack) {
                                    return const Icon(
                                      Icons.error_outline,
                                      color: Colors.amber,
                                    );
                                  })
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  )),
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      ' BTech (1st Year) ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 175, 139, 238),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      ' $branch',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 175, 139, 238),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      alignment: Alignment.center,
                      height: 270,
                      width: 380,
                      child: Card(
                        shadowColor: Colors.white,
                        color: const Color.fromARGB(255, 141, 150, 218),
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 5,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Align(
                                    //   alignment: Alignment.topLeft,
                                    //   child: Text(
                                    //     ' Estimated Cgpa:-',
                                    //     style: TextStyle(
                                    //         fontSize: 18,
                                    //         fontWeight: FontWeight.normal,
                                    //         color: const Color.fromARGB(
                                    //             255, 120, 119, 119)),
                                    //   ),
                                    // ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, left: 0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Personal Information',
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                              ' Name:- $fname $lname ',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),

                                            // Text(
                                            //   '$fname',
                                            //   style: TextStyle(
                                            //     fontSize: 20,
                                            //     fontWeight: FontWeight.normal,
                                            //     color: Colors.white,
                                            //   ),
                                            // ),

                                            Text(
                                              'Contact No.:- $phone',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),

                                            Text(
                                              'Aadhar:- $aadhar',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),

                                            Text(
                                              'Semester:- $semester',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),

                                            Text(
                                              'Section:- $section',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),

                                            Text(
                                              'DOB:- $dob'.substring(0, 16),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      alignment: Alignment.center,
                      height: 250,
                      width: 380,
                      child: Card(
                        shadowColor: Colors.white,
                        color: const Color.fromARGB(255, 141, 150, 218),
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 5,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Align(
                                    //   alignment: Alignment.topLeft,
                                    //   child: Text(
                                    //     ' Estimated Cgpa:-',
                                    //     style: TextStyle(
                                    //         fontSize: 18,
                                    //         fontWeight: FontWeight.normal,
                                    //         color: const Color.fromARGB(
                                    //             255, 120, 119, 119)),
                                    //   ),
                                    // ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, left: 0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              ' Parents Details',
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Father Name:- $fatherName',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Mother Name:- $motherName',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Father Email:- $fatherEmail',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Mother Email:- $motherEmail',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Father No.:- $fatherPhone',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Mother No.:- $motherPhone',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // SizedBox(height: 16),
                    // Text('First Name: $fname'),
                    // Text('Last Name: $lname'),
                    // Text('Phone: $phone'),
                    // Text('Aadhar: $aadhar'),
                    // Text('Address: $address'),
                    // Text('Semester: $semester'),
                    // Text('Branch: $branch'),
                    // Text('Section: $section'),
                    // Text('Date of Birth: $dob'),
                  ],
                ),
              ),
            ),
    );
  }
}
