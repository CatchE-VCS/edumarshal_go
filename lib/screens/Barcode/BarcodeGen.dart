import 'package:barcode_widget/barcode_widget.dart';
import 'package:edumarshal/controllers/profile.dart';
import 'package:edumarshal/models/profile_model.dart';
import 'package:flutter/material.dart';

class BarGen extends StatefulWidget {
  const BarGen({super.key});

  @override
  State<BarGen> createState() => _BarGenState();
}

class _BarGenState extends State<BarGen> {
  String? name;
  String? phone;
  String? admissionNo;
  String? address;

  String? branch;
  int? section;
  DateTime? dob;
  String? fatherName;
  String? fatherPhone;
  String? motherName;
  String? bloodG;
  String? smsMobileNumber;
  int? batchid;
  // String? courseBatchName;
  String? rollNumber;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ProfileController().getProfileData(),
        builder: (BuildContext context, AsyncSnapshot<ProfileData?> snapshot) {
          // Add a snapshot
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Check the connection state
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Check if error occurred
            return const Center(
              child: Text('Error fetching data'),
            );
          } else {
            // If no error occurred
            if (snapshot.data == null) {
              return const Center(
                child: Text('No data found'),
              );
            }
            name =
                '${snapshot.data!.firstName}${snapshot.data!.middleName != '' ? '${snapshot.data!.middleName}' : ''} ${snapshot.data!.lastName}';
            // email = snapshot.data!.email!;
            fatherName = snapshot.data!.fatherName!;
            motherName = snapshot.data!.motherName!;
            smsMobileNumber = snapshot.data!.smsMobileNumber!;
            rollNumber = snapshot.data!.rollNumber!;
            admissionNo = snapshot.data!.admissionNumber!;

            section = snapshot.data!.sectionName != null
                ? int.parse(snapshot.data!.sectionName!)
                : 1;
            dob = snapshot.data!.dob;
            fatherName = snapshot.data!.parentFullName;
            bloodG = snapshot.data!.batchName;
            fatherPhone = snapshot.data!.parentMobileNumber;
            address = snapshot.data!.address;
            batchid = snapshot.data!.batchId;
            return Scaffold(
                body: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(
                top: 107,
              ),
              child: Center(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 75, 85, 162),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 13),
                            Text(
                              "Student Number -  $admissionNo",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              // style: CustomTextStyles.titleLargePrimary,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Name -  $name",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                              // style: CustomTextStyles.titleLargePrimary,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Address-$address",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                              // style: CustomTextStyles.titleLargePrimary,
                            ),
                            Text(
                              "$branch",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                              // style: CustomTextStyles.titleLargePrimary,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "$bloodG",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                              // style: CustomTextStyles.titleLargePrimary,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Mobile No-$smsMobileNumber",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                              // style: CustomTextStyles.titleLargePrimary,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Father's Name-$fatherName",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                              // style: CustomTextStyles.titleLargePrimary,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "$fatherPhone",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                              // style: CustomTextStyles.titleLargePrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                      width: 250,
                      height: 40,
                      // decoration: AppDecoration.fillWhiteA,
                      child: BarcodeWidget(
                        drawText: false,
                        barcode: Barcode.code39(),
                        data: admissionNo.toString(),
                      )),
                ]),
              ),
            ));
          }
          ;
        });
  }
}
