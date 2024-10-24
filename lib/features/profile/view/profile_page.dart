import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../core/theme/theme_controller.dart';
import '../profile.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      strokeWidth: 3,
      onRefresh: () async {
        var refresh = ref.refresh(profileDataProvider);
        if (kDebugMode) {
          print(refresh);
        }
      },
      child: ref.watch(profileDataProvider).when(
            // Check the connection state
            loading: () => SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            // Check if error occurred
            error: (error, stack) => SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: Text('Error fetching data'),
              ),
            ),
            data: (ProfileData? data) {
              // If no error occurred
              if (data == null) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: Text('No data found'),
                  ),
                );
              }
              String name =
                  '${data.firstName}${data.middleName != '' ? '${data.middleName}' : ''} ${data.lastName}';
              String email = data.email ?? '';
              String fatherName = data.fatherName ?? '';
              String motherName = data.motherName ?? '';
              String smsMobileNumber = data.smsMobileNumber ?? '';
              String rollNumber = data.rollNumber ?? '';
              String photoUrl =
                  "https://akgecerp.edumarshal.com/api/fileblob/${data.profilePictureId}";
              int semester =
                  data.semester != null ? int.parse(data.semester) : 1;
              int section =
                  data.sectionName != null ? int.parse(data.sectionName) : 1;
              DateTime dob = data.dob;
              String motherPhone = data.mothersMobileNumber ?? '';
              String fatherPhone = data.parentMobileNumber ?? '';
              String address = data.address ?? '';

              final currentTheme = ref.watch(themeControllerProvider);
              final isLightMode =
                  Theme.of(context).brightness == Brightness.light;
              final myBanner = ref.watch(profileBannerAdProvider);
              // courseName = data.courseName;
              // batchName = data.batchName;
              return Scaffold(
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height + 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          name,
                          style: const TextStyle(
                            // color: Color.fromARGB(255, 175, 139, 238),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: const TextStyle(
                            // color: Color.fromARGB(255, 175, 139, 238),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 5,
                                      sigmaY: 5,
                                    ),
                                    child: Image(
                                      height: 300,
                                      width: 300,
                                      image: NetworkImage(photoUrl, scale: 1),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 140,
                            width: 140,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // border: Border.all(
                              //   // color: const Color.fromARGB(255, 214, 196, 238),
                              //   width: 8,
                              // ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: photoUrl.isNotEmpty
                                  ? Image.network(
                                      photoUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorBuilder: (context, object, stack) {
                                        return Image.network(
                                            fit: BoxFit.cover,
                                            "https://beta.edumarshal.com/app/img/no-image-person.png");
                                      },
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Student Details',
                          style: TextStyle(
                            // color: Color.fromARGB(255, 175, 139, 238),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          padding: const EdgeInsets.all(
                            24.0,
                          ),
                          decoration: const BoxDecoration(
                            // color: Color.fromARGB(255, 141, 150, 218),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 0.0,
                                sigmaY: 0.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(children: [
                                      BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 15.0,
                                          sigmaY: 15.0,
                                        ),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 270,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                32,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: currentTheme ==
                                                    ThemeMode.light
                                                ? [
                                                    Colors.white
                                                        .withOpacity(0.2),
                                                    Colors.white
                                                        .withOpacity(0.23),
                                                    Colors.white
                                                        .withOpacity(0.13),
                                                  ]
                                                : currentTheme == ThemeMode.dark
                                                    ? [
                                                        Colors.grey.shade800
                                                            .withOpacity(0.3),
                                                        Colors.grey.shade800
                                                            .withOpacity(0.2),
                                                        Colors.black54
                                                            .withOpacity(0.1)
                                                      ]
                                                    : isLightMode
                                                        ? [
                                                            Colors.white
                                                                .withOpacity(
                                                                    0.2),
                                                            Colors.white
                                                                .withOpacity(
                                                                    0.23),
                                                            Colors.white
                                                                .withOpacity(
                                                                    0.13),
                                                          ]
                                                        : [
                                                            Colors.grey.shade800
                                                                .withOpacity(
                                                                    0.3),
                                                            Colors.grey.shade800
                                                                .withOpacity(
                                                                    0.2),
                                                            Colors.black54
                                                                .withOpacity(
                                                                    0.1)
                                                          ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Personal Information',
                                              style: TextStyle(
                                                fontSize: 22,
                                                // color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              'Name: $name',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                // color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Contact No: $smsMobileNumber',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                // color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Roll number: $rollNumber',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                // color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Semester: $semester',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                // color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Section: $section',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                // color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'DOB: ${DateTime.parse(dob.toString()).day}/${DateTime.parse(dob.toString()).month}/${DateTime.parse(dob.toString()).year}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                // color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              'Address: $address',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                // color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          padding: const EdgeInsets.all(
                            24.0,
                          ),
                          decoration: const BoxDecoration(
                            // color: Color.fromARGB(255, 141, 150, 218),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 5,
                                sigmaY: 5,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Parents Details',
                                    style: TextStyle(
                                      fontSize: 22,
                                      // color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Father Name: $fatherName',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      // color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Mother Name: $motherName',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      // color: Colors.white,
                                    ),
                                  ),
                                  // Text(
                                  //   'Father Email: $fatherEmail',
                                  //   style: const TextStyle(
                                  //     fontSize: 18,
                                  //     fontWeight:
                                  //         FontWeight.normal,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  // Text(
                                  //   'Mother Email: $motherEmail',
                                  //   style: const TextStyle(
                                  //     fontSize: 18,
                                  //     fontWeight:
                                  //         FontWeight.normal,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  Text(
                                    'Father No: $fatherPhone',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      // color: Colors.white,
                                    ),
                                  ),

                                  Text(
                                    'Mother No: $motherPhone',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      // color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: (MediaQuery.of(context).size.width -
                                    myBanner.size.width.toDouble()) /
                                2,
                          ),
                          width: myBanner.size.width.toDouble(),
                          height: myBanner.size.height.toDouble(),
                          child: AdWidget(ad: myBanner),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
