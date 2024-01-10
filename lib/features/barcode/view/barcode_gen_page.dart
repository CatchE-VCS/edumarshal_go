import 'package:barcode_widget/barcode_widget.dart';
import 'package:edumarshal/features/profile/controller/profile_state_pod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BarGen extends ConsumerWidget {
  const BarGen({super.key});

  //
  // String? smsMobileNumber;
  //
  // int? batchid;
  //
  // // String? courseBatchName;
  // String? rollNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ref.watch(profileDataProvider).when(
        // Check the connection state
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stack) {
          // Check if error occurred
          return const Center(
            child: Text('Error fetching data'),
          );
        },
        data: (data) {
          // If no error occurred
          if (data == null) {
            return const Center(
              child: Text('No data found'),
            );
          }
          String? name =
              '${data.firstName} ${data.middleName != '' ? '${data.middleName}' : ''} ${data.lastName}';
          // email = data!.email!;
          String? fatherName = data.fatherName!;
          // String? motherName = data.motherName!;
          String? smsMobileNumber = data.smsMobileNumber!;
          // String? rollNumber = data.rollNumber!;
          String? admissionNo = data.admissionNumber!;
          // int? section = data.sectionName != null
          //     ? int.parse(data.sectionName!)
          //     : 1;
          // DateTime? dob = data.dob;
          String? bloodG = data.batchName;
          String? fatherPhone = data.parentMobileNumber;
          String? address = data.address;
          String? branch;
          // int? batchid = data.batchId;
          return Scaffold(
            body: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(
                top: 107,
              ),
              child: Column(
                children: [
                  SizedBox(
                      width: 250,
                      height: 50,
                      // decoration: AppDecoration.fillWhiteA,
                      child: BarcodeWidget(
                        drawText: false,
                        barcode: Barcode.code39(),
                        data: admissionNo.toString(),
                      )),
                  const SizedBox(height: 13),
                  Text(
                    "Student Number -$admissionNo",
                    // style: CustomTextStyles.titleLargePrimary,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Student Name -$name",
                    // style: CustomTextStyles.titleLargePrimary,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Address-$address",
                    // style: CustomTextStyles.titleLargePrimary,
                  ),
                  Text("$branch"
                      // style: CustomTextStyles.titleLargePrimary,
                      ),
                  const SizedBox(height: 6),
                  Text(
                    "$bloodG",
                    // style: CustomTextStyles.titleLargePrimary,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Mobile No-$smsMobileNumber",
                    // style: CustomTextStyles.titleLargePrimary,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Father's Name-$fatherName",
                    // style: CustomTextStyles.titleLargePrimary,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "$fatherPhone",
                    // style: CustomTextStyles.titleLargePrimary,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
