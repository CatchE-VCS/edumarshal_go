// To parse this JSON data, do
//
//     final attendanceData = attendanceDataFromJson(jsonString);

import 'dart:convert';

AttendanceData attendanceDataFromJson(Map<String, dynamic> str) =>
    AttendanceData.fromJson(str);

String attendanceDataToJson(AttendanceData data) => json.encode(data.toJson());

class AttendanceData {
  final dynamic attendance;
  final int? businessDays;
  final dynamic userBusinessDay;
  final List<AttendanceDatum> attendanceData;
  final List<AttendanceCopy> extraLectures;
  final StdSubAtdDetails stdSubAtdDetails;

  AttendanceData({
    required this.attendance,
    required this.businessDays,
    required this.userBusinessDay,
    required this.attendanceData,
    required this.extraLectures,
    required this.stdSubAtdDetails,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) => AttendanceData(
        attendance: json["attendance"],
        businessDays: json["businessDays"],
        userBusinessDay: json["userBusinessDay"],
        attendanceData: List<AttendanceDatum>.from(
            json["attendanceData"].map((x) => AttendanceDatum.fromJson(x))),
        extraLectures: List<AttendanceCopy>.from(
            json["extraLectures"].map((x) => AttendanceCopy.fromJson(x))),
        stdSubAtdDetails: StdSubAtdDetails.fromJson(json["stdSubAtdDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "attendance": attendance,
        "businessDays": businessDays,
        "userBusinessDay": userBusinessDay,
        "attendanceData":
            List<dynamic>.from(attendanceData.map((x) => x.toJson())),
        "extraLectures":
            List<dynamic>.from(extraLectures.map((x) => x.toJson())),
        "stdSubAtdDetails": stdSubAtdDetails.toJson(),
      };
}

class AttendanceCopy {
  final int? orgnizationId;
  final int? absentCount;
  final int? attendanceId;
  final int? attendeeUserId;
  final dynamic batchName;
  final dynamic courseName;
  final dynamic departmentName;
  final dynamic empNumber;
  final int? organizationId;
  final dynamic leaveTypeId;
  final int? profilePictureId;
  final int? attandanceType;
  final DateTime absentDate;
  final dynamic absentDateLable;
  final dynamic oldAttendanceDate;
  final String comment;
  final dynamic firstName;
  final dynamic middleName;
  final dynamic lastName;
  final dynamic admissionNumber;
  final String subjectName;
  final int? batchId;
  final int? randomPresent;
  final int? subjectId;
  final bool isAbsent;
  final int? markedBy;
  final int? adjustmentMode;
  final dynamic isHalfDay;
  final dynamic subSubjectId;
  final dynamic smsMobileNumber;
  final int? lectureAbsentId;
  final dynamic bulkAttendance;
  final AttendanceLable? attendanceLable;
  final int? sequence;
  final bool repeatAttendance;
  final dynamic isExtraLecture;
  final dynamic extraLeactureLable;
  final int? studentAbsentCount;
  final int? newBatchId;
  final int? uiMode;
  final int? masterSubjectId;
  final Css? css;
  final int? userGroupId;
  final dynamic userDetails;
  final int? inoutMode;
  final dynamic outDateTime;
  final dynamic outDateTimeLable;
  final dynamic totalAttendace;
  final dynamic firstClassAttendance;
  final bool flag;
  final dynamic dateOfAbsent;
  final dynamic rollNumber;
  final dynamic errorMessage;
  final int? totalPresent;
  final int? totalAbsent;
  final dynamic eventCode;
  final dynamic colour;
  final dynamic absentLecture;
  final dynamic selectedStudentId;
  final dynamic email;
  final dynamic fatherEmail;

  AttendanceCopy({
    required this.orgnizationId,
    required this.absentCount,
    required this.attendanceId,
    required this.attendeeUserId,
    required this.batchName,
    required this.courseName,
    required this.departmentName,
    required this.empNumber,
    required this.organizationId,
    required this.leaveTypeId,
    required this.profilePictureId,
    required this.attandanceType,
    required this.absentDate,
    required this.absentDateLable,
    required this.oldAttendanceDate,
    required this.comment,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.admissionNumber,
    required this.subjectName,
    required this.batchId,
    required this.randomPresent,
    required this.subjectId,
    required this.isAbsent,
    required this.markedBy,
    required this.adjustmentMode,
    required this.isHalfDay,
    required this.subSubjectId,
    required this.smsMobileNumber,
    required this.lectureAbsentId,
    required this.bulkAttendance,
    this.attendanceLable,
    required this.sequence,
    required this.repeatAttendance,
    required this.isExtraLecture,
    required this.extraLeactureLable,
    required this.studentAbsentCount,
    required this.newBatchId,
    required this.uiMode,
    required this.masterSubjectId,
    this.css,
    required this.userGroupId,
    required this.userDetails,
    required this.inoutMode,
    required this.outDateTime,
    required this.outDateTimeLable,
    required this.totalAttendace,
    required this.firstClassAttendance,
    required this.flag,
    required this.dateOfAbsent,
    required this.rollNumber,
    required this.errorMessage,
    required this.totalPresent,
    required this.totalAbsent,
    required this.eventCode,
    required this.colour,
    required this.absentLecture,
    required this.selectedStudentId,
    required this.email,
    required this.fatherEmail,
  });

  factory AttendanceCopy.fromJson(Map<String, dynamic> json) => AttendanceCopy(
        orgnizationId: json["orgnizationId"],
        absentCount: json["absentCount"],
        attendanceId: json["attendanceID"],
        attendeeUserId: json["attendeeUserID"],
        batchName: json["batchName"],
        courseName: json["courseName"],
        departmentName: json["departmentName"],
        empNumber: json["empNumber"],
        organizationId: json["organizationId"],
        leaveTypeId: json["leaveTypeId"],
        profilePictureId: json["profilePictureId"],
        attandanceType: json["attandanceType"],
        absentDate: DateTime.parse(json["absentDate"]),
        absentDateLable: json["absentDateLable"],
        oldAttendanceDate: json["oldAttendanceDate"],
        comment: json["comment"] ?? "",
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        admissionNumber: json["admissionNumber"],
        subjectName: json["subjectName"] ?? "",
        batchId: json["batchId"],
        randomPresent: json["randomPresent"],
        subjectId: json["subjectId"],
        isAbsent: json["isAbsent"],
        markedBy: json["markedBy"],
        adjustmentMode: json["adjustmentMode"],
        isHalfDay: json["isHalfDay"],
        subSubjectId: json["subSubjectId"],
        smsMobileNumber: json["smsMobileNumber"],
        lectureAbsentId: json["lectureAbsentId"],
        bulkAttendance: json["bulkAttendance"],
        attendanceLable: attendanceLableValues.map[json["attendanceLable"]],
        sequence: json["sequence"],
        repeatAttendance: json["repeatAttendance"],
        isExtraLecture: json["isExtraLecture"],
        extraLeactureLable: json["extraLeactureLable"],
        studentAbsentCount: json["studentAbsentCount"],
        newBatchId: json["newBatchId"],
        uiMode: json["uiMode"],
        masterSubjectId: json["masterSubjectId"],
        css: cssValues.map[json["css"]],
        userGroupId: json["userGroupId"],
        userDetails: json["userDetails"],
        inoutMode: json["inoutMode"],
        outDateTime: json["outDateTime"],
        outDateTimeLable: json["outDateTimeLable"],
        totalAttendace: json["totalAttendace"],
        firstClassAttendance: json["firstClassAttendance"],
        flag: json["flag"],
        dateOfAbsent: json["dateOfAbsent"],
        rollNumber: json["rollNumber"],
        errorMessage: json["errorMessage"],
        totalPresent: json["totalPresent"],
        totalAbsent: json["totalAbsent"],
        eventCode: json["eventCode"],
        colour: json["colour"],
        absentLecture: json["absentLecture"],
        selectedStudentId: json["selectedStudentId"],
        email: json["email"],
        fatherEmail: json["fatherEmail"],
      );

  Map<String, dynamic> toJson() => {
        "orgnizationId": orgnizationId,
        "absentCount": absentCount,
        "attendanceID": attendanceId,
        "attendeeUserID": attendeeUserId,
        "batchName": batchName,
        "courseName": courseName,
        "departmentName": departmentName,
        "empNumber": empNumber,
        "organizationId": organizationId,
        "leaveTypeId": leaveTypeId,
        "profilePictureId": profilePictureId,
        "attandanceType": attandanceType,
        "absentDate": absentDate.toIso8601String(),
        "absentDateLable": absentDateLable,
        "oldAttendanceDate": oldAttendanceDate,
        "comment": comment,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "admissionNumber": admissionNumber,
        "subjectName": subjectName,
        "batchId": batchId,
        "randomPresent": randomPresent,
        "subjectId": subjectId,
        "isAbsent": isAbsent,
        "markedBy": markedBy,
        "adjustmentMode": adjustmentMode,
        "isHalfDay": isHalfDay,
        "subSubjectId": subSubjectId,
        "smsMobileNumber": smsMobileNumber,
        "lectureAbsentId": lectureAbsentId,
        "bulkAttendance": bulkAttendance,
        "attendanceLable": attendanceLableValues.reverse[attendanceLable],
        "sequence": sequence,
        "repeatAttendance": repeatAttendance,
        "isExtraLecture": isExtraLecture,
        "extraLeactureLable": extraLeactureLable,
        "studentAbsentCount": studentAbsentCount,
        "newBatchId": newBatchId,
        "uiMode": uiMode,
        "masterSubjectId": masterSubjectId,
        "css": cssValues.reverse[css],
        "userGroupId": userGroupId,
        "userDetails": userDetails,
        "inoutMode": inoutMode,
        "outDateTime": outDateTime,
        "outDateTimeLable": outDateTimeLable,
        "totalAttendace": totalAttendace,
        "firstClassAttendance": firstClassAttendance,
        "flag": flag,
        "dateOfAbsent": dateOfAbsent,
        "rollNumber": rollNumber,
        "errorMessage": errorMessage,
        "totalPresent": totalPresent,
        "totalAbsent": totalAbsent,
        "eventCode": eventCode,
        "colour": colour,
        "absentLecture": absentLecture,
        "selectedStudentId": selectedStudentId,
        "email": email,
        "fatherEmail": fatherEmail,
      };
}

enum AttendanceLable { A, P }

final attendanceLableValues =
    EnumValues({"A": AttendanceLable.A, "P": AttendanceLable.P});

enum Css { absent, present }

final cssValues = EnumValues({"absent": Css.absent, "present": Css.present});

class AttendanceDatum {
  final int? orgnizationId;
  final int? absentCount;
  final int? attendanceId;
  final int? attendeeUserId;
  final int? organizationId;
  final int? profilePictureId;
  final int? attandanceType;
  final DateTime absentDate;
  final String subjectName;
  final int? batchId;
  final int? randomPresent;
  final int? subjectId;
  final bool isAbsent;
  final int? markedBy;
  final int? lectureAbsentId;
  final int? sequence;
  final bool repeatAttendance;
  final int? studentAbsentCount;
  final int? newBatchId;
  final int? uiMode;
  final int? masterSubjectId;
  final int? userGroupId;
  final int? inoutMode;
  final bool flag;
  final int? totalPresent;
  final int? totalAbsent;
  final String comment;
  final int? adjustmentMode;

  AttendanceDatum({
    required this.orgnizationId,
    required this.absentCount,
    required this.attendanceId,
    required this.attendeeUserId,
    required this.organizationId,
    required this.profilePictureId,
    required this.attandanceType,
    required this.absentDate,
    required this.subjectName,
    required this.batchId,
    required this.randomPresent,
    required this.subjectId,
    required this.isAbsent,
    required this.markedBy,
    required this.lectureAbsentId,
    required this.sequence,
    required this.repeatAttendance,
    required this.studentAbsentCount,
    required this.newBatchId,
    required this.uiMode,
    required this.masterSubjectId,
    required this.userGroupId,
    required this.inoutMode,
    required this.flag,
    required this.totalPresent,
    required this.totalAbsent,
    required this.comment,
    required this.adjustmentMode,
  });

  factory AttendanceDatum.fromJson(Map<String, dynamic> json) =>
      AttendanceDatum(
        orgnizationId: json["orgnizationId"],
        absentCount: json["absentCount"],
        attendanceId: json["attendanceID"],
        attendeeUserId: json["attendeeUserID"],
        organizationId: json["organizationId"],
        profilePictureId: json["profilePictureId"],
        attandanceType: json["attandanceType"],
        absentDate: DateTime.parse(json["absentDate"]),
        subjectName: json["subjectName"] ?? "",
        batchId: json["batchId"],
        randomPresent: json["randomPresent"],
        subjectId: json["subjectId"],
        isAbsent: json["isAbsent"],
        markedBy: json["markedBy"],
        lectureAbsentId: json["lectureAbsentId"],
        sequence: json["sequence"],
        repeatAttendance: json["repeatAttendance"],
        studentAbsentCount: json["studentAbsentCount"],
        newBatchId: json["newBatchId"],
        uiMode: json["uiMode"],
        masterSubjectId: json["masterSubjectId"],
        userGroupId: json["userGroupId"],
        inoutMode: json["inoutMode"],
        flag: json["flag"],
        totalPresent: json["totalPresent"],
        totalAbsent: json["totalAbsent"],
        comment: json["comment"] ?? "",
        adjustmentMode: json["adjustmentMode"],
      );

  Map<String, dynamic> toJson() => {
        "orgnizationId": orgnizationId,
        "absentCount": absentCount,
        "attendanceID": attendanceId,
        "attendeeUserID": attendeeUserId,
        "organizationId": organizationId,
        "profilePictureId": profilePictureId,
        "attandanceType": attandanceType,
        "absentDate": absentDate.toIso8601String(),
        "subjectName": subjectName,
        "batchId": batchId,
        "randomPresent": randomPresent,
        "subjectId": subjectId,
        "isAbsent": isAbsent,
        "markedBy": markedBy,
        "lectureAbsentId": lectureAbsentId,
        "sequence": sequence,
        "repeatAttendance": repeatAttendance,
        "studentAbsentCount": studentAbsentCount,
        "newBatchId": newBatchId,
        "uiMode": uiMode,
        "masterSubjectId": masterSubjectId,
        "userGroupId": userGroupId,
        "inoutMode": inoutMode,
        "flag": flag,
        "totalPresent": totalPresent,
        "totalAbsent": totalAbsent,
        "comment": comment,
        "adjustmentMode": adjustmentMode,
      };
}

class StdSubAtdDetails {
  final List<StudentSubjectAttendance> studentSubjectAttendance;
  final double overallPercentage;
  final int? overallPresent;
  final int? overallLecture;

  StdSubAtdDetails({
    required this.studentSubjectAttendance,
    required this.overallPercentage,
    required this.overallPresent,
    required this.overallLecture,
  });

  factory StdSubAtdDetails.fromJson(Map<String, dynamic> json) =>
      StdSubAtdDetails(
        studentSubjectAttendance: List<StudentSubjectAttendance>.from(
            json["studentSubjectAttendance"]
                .map((x) => StudentSubjectAttendance.fromJson(x))),
        overallPercentage: json["overallPercentage"].toDouble(),
        overallPresent: json["overallPresent"],
        overallLecture: json["overallLecture"],
      );

  Map<String, dynamic> toJson() => {
        "studentSubjectAttendance":
            List<dynamic>.from(studentSubjectAttendance.map((x) => x.toJson())),
        "overallPercentage": overallPercentage,
        "overallPresent": overallPresent,
        "overallLecture": overallLecture,
      };
}

class StudentSubjectAttendance {
  final String userDetails;
  final dynamic userType;
  final bool userStatus;
  final int? batchId;
  final String rollNumber;
  final int? studentSequence;
  final int? categoryId;
  final String fatherName;
  final dynamic batchName;
  final dynamic email;
  final dynamic addressLine1;
  final dynamic addressLine2;
  final dynamic employeeNumber;
  final int? userId;
  final dynamic familyId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String smsMobileNumber;
  final String admissionNumber;
  final dynamic boardRegistrationNumber;
  final dynamic registrationNumberNine;
  final dynamic motherbusiness;
  final dynamic motheremail;
  final dynamic registrationNumber;
  final dynamic registrationNumberEleven;
  final dynamic rollNumberTenth;
  final dynamic rollNumberTwelve;
  final dynamic aadhaarNumber;
  final dynamic city;
  final dynamic state;
  final dynamic pincode;
  final dynamic birthPlace;
  final dynamic height;
  final dynamic weight;
  final dynamic nation;
  final dynamic bpl;
  final dynamic physical;
  final dynamic medical;
  final dynamic motherTongue;
  final dynamic religion;
  final dynamic caste;
  final dynamic parentMobileNumber;
  final String mothersMobileNumber;
  final dynamic motherFullName;
  final dynamic parentOccupation;
  final dynamic routeNumber;
  final dynamic transportPickPoint;
  final dynamic categoryName;
  final dynamic minority;
  final dynamic perobtained;
  final dynamic bankaccount;
  final dynamic ifsccode;
  final dynamic attendedschool;
  final dynamic social;
  final dynamic previousEducationClass;
  final dynamic firstFeeReceiptNumber;
  final dynamic firstFeeAmount;
  final bool isDeleted;
  final int? migrationStatus;
  final int? userCount;
  final DateTime dob;
  final DateTime admissionDate;
  final dynamic joiningDate;
  final int? profilePictureId;
  final dynamic loginTime;
  final dynamic transportMode;
  final dynamic payrollDetail;
  final dynamic personalPayrollDetail;
  final int? salaryPaidDays;
  final int? salaryTotalEarning;
  final int? salaryTotalDeduction;
  final bool isPaySlipAdded;
  final dynamic grossSalary;
  final DateTime dateTimeStampIns;
  final String motherName;
  final String address;
  final dynamic parentFullName;
  final dynamic bloodGroup;
  final int? age;
  final int? courseId;
  final String gender;
  final dynamic financialYear;
  final dynamic semester;
  final dynamic deviceId;
  final dynamic remarkSettingKey;
  final List<Subject> subjects;
  final String loginName;
  final dynamic qrCodeImagePath;
  final int? loginHistoryId;
  final int? loginMode;
  final dynamic barCodeImagePath;
  final dynamic remark;
  final dynamic placementCategory;
  final dynamic placementCategoryOtherValue;
  final int? organizationId;
  final dynamic studentName;
  final dynamic fieldValue;
  final dynamic healthData;
  final double studentPercentage;
  final int? studentFirstTermPercentage;
  final int? studentSecondTermPercentage;
  final int? studentTotalAttendance;
  final int? studentPresentAttendance;
  final int? studentRemedialAttendance;
  final dynamic fatherEmail;
  final dynamic fullName;
  final dynamic courseName;
  final dynamic designationId;
  final int? lopDays;
  final dynamic submissionDate;
  final dynamic score;
  final dynamic maxScore;
  final dynamic percentage;
  final dynamic attendanceStatus;
  final int? refndAmount;
  final dynamic refundDescription;
  final dynamic departmentId;
  final dynamic genderInEnglish;
  final dynamic genderInHindi;
  final dynamic userTitles;
  final dynamic userVerb;
  final dynamic userG;
  final dynamic userGenderInHindi;
  final dynamic userInHindi;
  final dynamic userTextInHindi;
  final dynamic attendanceDateRange;
  final dynamic tenthPercentageObtained;
  final dynamic twelfthpercentageObtained;
  final dynamic tenthboardName;
  final dynamic twelfthboardName;
  final dynamic presentCity;
  final dynamic presentState;
  final dynamic presentPincode;
  final dynamic tenthPassingyear;
  final dynamic tenthGraduatingState;
  final dynamic tenthSchoolName;
  final dynamic appearedForTwelveImprovement;
  final dynamic twelfthpassingYear;
  final dynamic twelveGraduatingState;
  final dynamic twelveSchoolName;
  final dynamic diplomaAdmissionYear;
  final dynamic diplomaInstitute;
  final dynamic diplomaBranch;
  final dynamic permenentAddress;
  final dynamic permenentCity;
  final dynamic permenentState;
  final dynamic permenentPincode;
  final dynamic studentFulName;
  final dynamic numberOfQuestionAttempt;
  final dynamic udf;
  final dynamic udf1;
  final dynamic udf2;
  final int? enquiryId;
  final int? userRoleId;
  final int? totalFee;
  final int? totalPendingFee;
  final int? totalPaidFee;
  final int? totlFeesAmount;
  final int? totlPendingAmount;
  final dynamic departmentName;
  final dynamic enrollmentNumber;
  final dynamic seatNumber;
  final dynamic alternateStudentEmail;
  final dynamic reportCardStatus;
  final int? reportCardId;
  final dynamic categoryCode;
  final dynamic admissionStatus;
  final int? studentAdmissionType;
  final bool isSelfMigrated;
  final dynamic previousClassUserId;
  final int? hostelTaken;
  final dynamic inactiveDate;
  final dynamic house;
  final dynamic studentResidentialType;
  final dynamic courseBatchName;
  final int? hostelId;
  final dynamic hostelName;
  final dynamic addedBy;
  final dynamic loginStatus;

  StudentSubjectAttendance({
    required this.userDetails,
    required this.userType,
    required this.userStatus,
    required this.batchId,
    required this.rollNumber,
    required this.studentSequence,
    required this.categoryId,
    required this.fatherName,
    required this.batchName,
    required this.email,
    required this.addressLine1,
    required this.addressLine2,
    required this.employeeNumber,
    required this.userId,
    required this.familyId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.smsMobileNumber,
    required this.admissionNumber,
    required this.boardRegistrationNumber,
    required this.registrationNumberNine,
    required this.motherbusiness,
    required this.motheremail,
    required this.registrationNumber,
    required this.registrationNumberEleven,
    required this.rollNumberTenth,
    required this.rollNumberTwelve,
    required this.aadhaarNumber,
    required this.city,
    required this.state,
    required this.pincode,
    required this.birthPlace,
    required this.height,
    required this.weight,
    required this.nation,
    required this.bpl,
    required this.physical,
    required this.medical,
    required this.motherTongue,
    required this.religion,
    required this.caste,
    required this.parentMobileNumber,
    required this.mothersMobileNumber,
    required this.motherFullName,
    required this.parentOccupation,
    required this.routeNumber,
    required this.transportPickPoint,
    required this.categoryName,
    required this.minority,
    required this.perobtained,
    required this.bankaccount,
    required this.ifsccode,
    required this.attendedschool,
    required this.social,
    required this.previousEducationClass,
    required this.firstFeeReceiptNumber,
    required this.firstFeeAmount,
    required this.isDeleted,
    required this.migrationStatus,
    required this.userCount,
    required this.dob,
    required this.admissionDate,
    required this.joiningDate,
    required this.profilePictureId,
    required this.loginTime,
    required this.transportMode,
    required this.payrollDetail,
    required this.personalPayrollDetail,
    required this.salaryPaidDays,
    required this.salaryTotalEarning,
    required this.salaryTotalDeduction,
    required this.isPaySlipAdded,
    required this.grossSalary,
    required this.dateTimeStampIns,
    required this.motherName,
    required this.address,
    required this.parentFullName,
    required this.bloodGroup,
    required this.age,
    required this.courseId,
    required this.gender,
    required this.financialYear,
    required this.semester,
    required this.deviceId,
    required this.remarkSettingKey,
    required this.subjects,
    required this.loginName,
    required this.qrCodeImagePath,
    required this.loginHistoryId,
    required this.loginMode,
    required this.barCodeImagePath,
    required this.remark,
    required this.placementCategory,
    required this.placementCategoryOtherValue,
    required this.organizationId,
    required this.studentName,
    required this.fieldValue,
    required this.healthData,
    required this.studentPercentage,
    required this.studentFirstTermPercentage,
    required this.studentSecondTermPercentage,
    required this.studentTotalAttendance,
    required this.studentPresentAttendance,
    required this.studentRemedialAttendance,
    required this.fatherEmail,
    required this.fullName,
    required this.courseName,
    required this.designationId,
    required this.lopDays,
    required this.submissionDate,
    required this.score,
    required this.maxScore,
    required this.percentage,
    required this.attendanceStatus,
    required this.refndAmount,
    required this.refundDescription,
    required this.departmentId,
    required this.genderInEnglish,
    required this.genderInHindi,
    required this.userTitles,
    required this.userVerb,
    required this.userG,
    required this.userGenderInHindi,
    required this.userInHindi,
    required this.userTextInHindi,
    required this.attendanceDateRange,
    required this.tenthPercentageObtained,
    required this.twelfthpercentageObtained,
    required this.tenthboardName,
    required this.twelfthboardName,
    required this.presentCity,
    required this.presentState,
    required this.presentPincode,
    required this.tenthPassingyear,
    required this.tenthGraduatingState,
    required this.tenthSchoolName,
    required this.appearedForTwelveImprovement,
    required this.twelfthpassingYear,
    required this.twelveGraduatingState,
    required this.twelveSchoolName,
    required this.diplomaAdmissionYear,
    required this.diplomaInstitute,
    required this.diplomaBranch,
    required this.permenentAddress,
    required this.permenentCity,
    required this.permenentState,
    required this.permenentPincode,
    required this.studentFulName,
    required this.numberOfQuestionAttempt,
    required this.udf,
    required this.udf1,
    required this.udf2,
    required this.enquiryId,
    required this.userRoleId,
    required this.totalFee,
    required this.totalPendingFee,
    required this.totalPaidFee,
    required this.totlFeesAmount,
    required this.totlPendingAmount,
    required this.departmentName,
    required this.enrollmentNumber,
    required this.seatNumber,
    required this.alternateStudentEmail,
    required this.reportCardStatus,
    required this.reportCardId,
    required this.categoryCode,
    required this.admissionStatus,
    required this.studentAdmissionType,
    required this.isSelfMigrated,
    required this.previousClassUserId,
    required this.hostelTaken,
    required this.inactiveDate,
    required this.house,
    required this.studentResidentialType,
    required this.courseBatchName,
    required this.hostelId,
    required this.hostelName,
    required this.addedBy,
    required this.loginStatus,
  });

  factory StudentSubjectAttendance.fromJson(Map<String, dynamic> json) =>
      StudentSubjectAttendance(
        userDetails: json["userDetails"],
        userType: json["userType"],
        userStatus: json["userStatus"],
        batchId: json["batchId"],
        rollNumber: json["rollNumber"],
        studentSequence: json["studentSequence"],
        categoryId: json["categoryId"],
        fatherName: json["fatherName"],
        batchName: json["batchName"],
        email: json["email"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        employeeNumber: json["employeeNumber"],
        userId: json["userId"],
        familyId: json["familyId"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        smsMobileNumber: json["smsMobileNumber"],
        admissionNumber: json["admissionNumber"],
        boardRegistrationNumber: json["boardRegistrationNumber"],
        registrationNumberNine: json["registrationNumberNine"],
        motherbusiness: json["motherbusiness"],
        motheremail: json["motheremail"],
        registrationNumber: json["registrationNumber"],
        registrationNumberEleven: json["registrationNumberEleven"],
        rollNumberTenth: json["rollNumberTenth"],
        rollNumberTwelve: json["rollNumberTwelve"],
        aadhaarNumber: json["aadhaarNumber"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        birthPlace: json["birthPlace"],
        height: json["height"],
        weight: json["weight"],
        nation: json["nation"],
        bpl: json["bpl"],
        physical: json["physical"],
        medical: json["medical"],
        motherTongue: json["motherTongue"],
        religion: json["religion"],
        caste: json["caste"],
        parentMobileNumber: json["parentMobileNumber"],
        mothersMobileNumber: json["mothersMobileNumber"],
        motherFullName: json["motherFullName"],
        parentOccupation: json["parentOccupation"],
        routeNumber: json["routeNumber"],
        transportPickPoint: json["transportPickPoint"],
        categoryName: json["categoryName"],
        minority: json["minority"],
        perobtained: json["perobtained"],
        bankaccount: json["bankaccount"],
        ifsccode: json["ifsccode"],
        attendedschool: json["attendedschool"],
        social: json["social"],
        previousEducationClass: json["previousEducationClass"],
        firstFeeReceiptNumber: json["firstFeeReceiptNumber"],
        firstFeeAmount: json["firstFeeAmount"],
        isDeleted: json["isDeleted"],
        migrationStatus: json["migrationStatus"],
        userCount: json["userCount"],
        dob: DateTime.parse(json["dob"]),
        admissionDate: DateTime.parse(json["admissionDate"]),
        joiningDate: json["joiningDate"],
        profilePictureId: json["profilePictureId"],
        loginTime: json["loginTime"],
        transportMode: json["transportMode"],
        payrollDetail: json["payrollDetail"],
        personalPayrollDetail: json["personalPayrollDetail"],
        salaryPaidDays: json["salaryPaidDays"],
        salaryTotalEarning: json["salaryTotalEarning"],
        salaryTotalDeduction: json["salaryTotalDeduction"],
        isPaySlipAdded: json["isPaySlipAdded"],
        grossSalary: json["grossSalary"],
        dateTimeStampIns: DateTime.parse(json["dateTimeStampIns"]),
        motherName: json["motherName"],
        address: json["address"],
        parentFullName: json["parentFullName"],
        bloodGroup: json["bloodGroup"],
        age: json["age"],
        courseId: json["courseId"],
        gender: json["gender"],
        financialYear: json["financialYear"],
        semester: json["semester"],
        deviceId: json["deviceId"],
        remarkSettingKey: json["remarkSettingKey"],
        subjects: List<Subject>.from(
            json["subjects"].map((x) => Subject.fromJson(x))),
        loginName: json["loginName"],
        qrCodeImagePath: json["qrCodeImagePath"],
        loginHistoryId: json["loginHistoryId"],
        loginMode: json["loginMode"],
        barCodeImagePath: json["barCodeImagePath"],
        remark: json["remark"],
        placementCategory: json["placementCategory"],
        placementCategoryOtherValue: json["placementCategoryOtherValue"],
        organizationId: json["organizationId"],
        studentName: json["studentName"],
        fieldValue: json["fieldValue"],
        healthData: json["healthData"],
        studentPercentage: json["studentPercentage"].toDouble(),
        studentFirstTermPercentage: json["studentFirstTermPercentage"],
        studentSecondTermPercentage: json["studentSecondTermPercentage"],
        studentTotalAttendance: json["studentTotalAttendance"],
        studentPresentAttendance: json["studentPresentAttendance"],
        studentRemedialAttendance: json["studentRemedialAttendance"],
        fatherEmail: json["fatherEmail"],
        fullName: json["fullName"],
        courseName: json["courseName"],
        designationId: json["designationId"],
        lopDays: json["lopDays"],
        submissionDate: json["submissionDate"],
        score: json["score"],
        maxScore: json["maxScore"],
        percentage: json["percentage"],
        attendanceStatus: json["attendanceStatus"],
        refndAmount: json["refndAmount"],
        refundDescription: json["refundDescription"],
        departmentId: json["departmentId"],
        genderInEnglish: json["genderInEnglish"],
        genderInHindi: json["genderInHindi"],
        userTitles: json["userTitles"],
        userVerb: json["userVerb"],
        userG: json["userG"],
        userGenderInHindi: json["userGenderInHindi"],
        userInHindi: json["userInHindi"],
        userTextInHindi: json["userTextInHindi"],
        attendanceDateRange: json["attendanceDateRange"],
        tenthPercentageObtained: json["tenthPercentageObtained"],
        twelfthpercentageObtained: json["twelfthpercentageObtained"],
        tenthboardName: json["tenthboardName"],
        twelfthboardName: json["twelfthboardName"],
        presentCity: json["presentCity"],
        presentState: json["presentState"],
        presentPincode: json["presentPincode"],
        tenthPassingyear: json["tenthPassingyear"],
        tenthGraduatingState: json["tenthGraduatingState"],
        tenthSchoolName: json["tenthSchoolName"],
        appearedForTwelveImprovement: json["appearedForTwelveImprovement"],
        twelfthpassingYear: json["twelfthpassingYear"],
        twelveGraduatingState: json["twelveGraduatingState"],
        twelveSchoolName: json["twelveSchoolName"],
        diplomaAdmissionYear: json["diplomaAdmissionYear"],
        diplomaInstitute: json["diplomaInstitute"],
        diplomaBranch: json["diplomaBranch"],
        permenentAddress: json["permenentAddress"],
        permenentCity: json["permenentCity"],
        permenentState: json["permenentState"],
        permenentPincode: json["permenentPincode"],
        studentFulName: json["studentFulName"],
        numberOfQuestionAttempt: json["numberOfQuestionAttempt"],
        udf: json["udf"],
        udf1: json["udf1"],
        udf2: json["udf2"],
        enquiryId: json["enquiryId"],
        userRoleId: json["userRoleId"],
        totalFee: json["totalFee"],
        totalPendingFee: json["totalPendingFee"],
        totalPaidFee: json["totalPaidFee"],
        totlFeesAmount: json["totlFeesAmount"],
        totlPendingAmount: json["totlPendingAmount"],
        departmentName: json["departmentName"],
        enrollmentNumber: json["enrollmentNumber"],
        seatNumber: json["seatNumber"],
        alternateStudentEmail: json["alternateStudentEmail"],
        reportCardStatus: json["reportCardStatus"],
        reportCardId: json["reportCardId"],
        categoryCode: json["categoryCode"],
        admissionStatus: json["admissionStatus"],
        studentAdmissionType: json["studentAdmissionType"],
        isSelfMigrated: json["isSelfMigrated"],
        previousClassUserId: json["previousClassUserId"],
        hostelTaken: json["hostelTaken"],
        inactiveDate: json["inactiveDate"],
        house: json["house"],
        studentResidentialType: json["studentResidentialType"],
        courseBatchName: json["courseBatchName"],
        hostelId: json["hostelId"],
        hostelName: json["hostelName"],
        addedBy: json["addedBy"],
        loginStatus: json["loginStatus"],
      );

  Map<String, dynamic> toJson() => {
        "userDetails": userDetails,
        "userType": userType,
        "userStatus": userStatus,
        "batchId": batchId,
        "rollNumber": rollNumber,
        "studentSequence": studentSequence,
        "categoryId": categoryId,
        "fatherName": fatherName,
        "batchName": batchName,
        "email": email,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "employeeNumber": employeeNumber,
        "userId": userId,
        "familyId": familyId,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "smsMobileNumber": smsMobileNumber,
        "admissionNumber": admissionNumber,
        "boardRegistrationNumber": boardRegistrationNumber,
        "registrationNumberNine": registrationNumberNine,
        "motherbusiness": motherbusiness,
        "motheremail": motheremail,
        "registrationNumber": registrationNumber,
        "registrationNumberEleven": registrationNumberEleven,
        "rollNumberTenth": rollNumberTenth,
        "rollNumberTwelve": rollNumberTwelve,
        "aadhaarNumber": aadhaarNumber,
        "city": city,
        "state": state,
        "pincode": pincode,
        "birthPlace": birthPlace,
        "height": height,
        "weight": weight,
        "nation": nation,
        "bpl": bpl,
        "physical": physical,
        "medical": medical,
        "motherTongue": motherTongue,
        "religion": religion,
        "caste": caste,
        "parentMobileNumber": parentMobileNumber,
        "mothersMobileNumber": mothersMobileNumber,
        "motherFullName": motherFullName,
        "parentOccupation": parentOccupation,
        "routeNumber": routeNumber,
        "transportPickPoint": transportPickPoint,
        "categoryName": categoryName,
        "minority": minority,
        "perobtained": perobtained,
        "bankaccount": bankaccount,
        "ifsccode": ifsccode,
        "attendedschool": attendedschool,
        "social": social,
        "previousEducationClass": previousEducationClass,
        "firstFeeReceiptNumber": firstFeeReceiptNumber,
        "firstFeeAmount": firstFeeAmount,
        "isDeleted": isDeleted,
        "migrationStatus": migrationStatus,
        "userCount": userCount,
        "dob": dob.toIso8601String(),
        "admissionDate": admissionDate.toIso8601String(),
        "joiningDate": joiningDate,
        "profilePictureId": profilePictureId,
        "loginTime": loginTime,
        "transportMode": transportMode,
        "payrollDetail": payrollDetail,
        "personalPayrollDetail": personalPayrollDetail,
        "salaryPaidDays": salaryPaidDays,
        "salaryTotalEarning": salaryTotalEarning,
        "salaryTotalDeduction": salaryTotalDeduction,
        "isPaySlipAdded": isPaySlipAdded,
        "grossSalary": grossSalary,
        "dateTimeStampIns": dateTimeStampIns.toIso8601String(),
        "motherName": motherName,
        "address": address,
        "parentFullName": parentFullName,
        "bloodGroup": bloodGroup,
        "age": age,
        "courseId": courseId,
        "gender": gender,
        "financialYear": financialYear,
        "semester": semester,
        "deviceId": deviceId,
        "remarkSettingKey": remarkSettingKey,
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
        "loginName": loginName,
        "qrCodeImagePath": qrCodeImagePath,
        "loginHistoryId": loginHistoryId,
        "loginMode": loginMode,
        "barCodeImagePath": barCodeImagePath,
        "remark": remark,
        "placementCategory": placementCategory,
        "placementCategoryOtherValue": placementCategoryOtherValue,
        "organizationId": organizationId,
        "studentName": studentName,
        "fieldValue": fieldValue,
        "healthData": healthData,
        "studentPercentage": studentPercentage,
        "studentFirstTermPercentage": studentFirstTermPercentage,
        "studentSecondTermPercentage": studentSecondTermPercentage,
        "studentTotalAttendance": studentTotalAttendance,
        "studentPresentAttendance": studentPresentAttendance,
        "studentRemedialAttendance": studentRemedialAttendance,
        "fatherEmail": fatherEmail,
        "fullName": fullName,
        "courseName": courseName,
        "designationId": designationId,
        "lopDays": lopDays,
        "submissionDate": submissionDate,
        "score": score,
        "maxScore": maxScore,
        "percentage": percentage,
        "attendanceStatus": attendanceStatus,
        "refndAmount": refndAmount,
        "refundDescription": refundDescription,
        "departmentId": departmentId,
        "genderInEnglish": genderInEnglish,
        "genderInHindi": genderInHindi,
        "userTitles": userTitles,
        "userVerb": userVerb,
        "userG": userG,
        "userGenderInHindi": userGenderInHindi,
        "userInHindi": userInHindi,
        "userTextInHindi": userTextInHindi,
        "attendanceDateRange": attendanceDateRange,
        "tenthPercentageObtained": tenthPercentageObtained,
        "twelfthpercentageObtained": twelfthpercentageObtained,
        "tenthboardName": tenthboardName,
        "twelfthboardName": twelfthboardName,
        "presentCity": presentCity,
        "presentState": presentState,
        "presentPincode": presentPincode,
        "tenthPassingyear": tenthPassingyear,
        "tenthGraduatingState": tenthGraduatingState,
        "tenthSchoolName": tenthSchoolName,
        "appearedForTwelveImprovement": appearedForTwelveImprovement,
        "twelfthpassingYear": twelfthpassingYear,
        "twelveGraduatingState": twelveGraduatingState,
        "twelveSchoolName": twelveSchoolName,
        "diplomaAdmissionYear": diplomaAdmissionYear,
        "diplomaInstitute": diplomaInstitute,
        "diplomaBranch": diplomaBranch,
        "permenentAddress": permenentAddress,
        "permenentCity": permenentCity,
        "permenentState": permenentState,
        "permenentPincode": permenentPincode,
        "studentFulName": studentFulName,
        "numberOfQuestionAttempt": numberOfQuestionAttempt,
        "udf": udf,
        "udf1": udf1,
        "udf2": udf2,
        "enquiryId": enquiryId,
        "userRoleId": userRoleId,
        "totalFee": totalFee,
        "totalPendingFee": totalPendingFee,
        "totalPaidFee": totalPaidFee,
        "totlFeesAmount": totlFeesAmount,
        "totlPendingAmount": totlPendingAmount,
        "departmentName": departmentName,
        "enrollmentNumber": enrollmentNumber,
        "seatNumber": seatNumber,
        "alternateStudentEmail": alternateStudentEmail,
        "reportCardStatus": reportCardStatus,
        "reportCardId": reportCardId,
        "categoryCode": categoryCode,
        "admissionStatus": admissionStatus,
        "studentAdmissionType": studentAdmissionType,
        "isSelfMigrated": isSelfMigrated,
        "previousClassUserId": previousClassUserId,
        "hostelTaken": hostelTaken,
        "inactiveDate": inactiveDate,
        "house": house,
        "studentResidentialType": studentResidentialType,
        "courseBatchName": courseBatchName,
        "hostelId": hostelId,
        "hostelName": hostelName,
        "addedBy": addedBy,
        "loginStatus": loginStatus,
      };
}

class Subject {
  final int? groupId;
  final String code;
  final int? batchId;
  final dynamic groupName;
  final dynamic subject;
  final int? subjectGroupType;
  final int? id;
  final int? subjectGroupId;
  final int? subSubjectId;
  final String name;
  final bool isAdditionalSubject;
  final bool isTimeTableSubject;
  final int? totalExtraLeactureForSubject;
  final int? presentInExtraLeactureForSubject;
  final int? absentInExtraLeactureForSubject;
  final int? totalLeactures;
  final int? presentLeactures;
  final int? otherAttendance;
  final int? absentLeactures;
  final int? averagePresent;
  final int? averageTotal;
  final double percentageAttendance;
  final dynamic subjectMasterId;
  final int? actualSubjectId;
  final int? subjectType;
  final dynamic conversionMark;
  final bool isSubjectSeleted;
  final int? sequence;
  final int? subjectMappingId;
  final dynamic courseContent;
  final bool isAttendaceFilled;
  final bool isExamDateSheetCreated;
  final bool isSubjectTeacher;

  Subject({
    required this.groupId,
    required this.code,
    required this.batchId,
    required this.groupName,
    required this.subject,
    required this.subjectGroupType,
    required this.id,
    required this.subjectGroupId,
    required this.subSubjectId,
    required this.name,
    required this.isAdditionalSubject,
    required this.isTimeTableSubject,
    required this.totalExtraLeactureForSubject,
    required this.presentInExtraLeactureForSubject,
    required this.absentInExtraLeactureForSubject,
    required this.totalLeactures,
    required this.presentLeactures,
    required this.otherAttendance,
    required this.absentLeactures,
    required this.averagePresent,
    required this.averageTotal,
    required this.percentageAttendance,
    required this.subjectMasterId,
    required this.actualSubjectId,
    required this.subjectType,
    required this.conversionMark,
    required this.isSubjectSeleted,
    required this.sequence,
    required this.subjectMappingId,
    required this.courseContent,
    required this.isAttendaceFilled,
    required this.isExamDateSheetCreated,
    required this.isSubjectTeacher,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        groupId: json["groupId"],
        code: json["code"],
        batchId: json["batchId"],
        groupName: json["groupName"],
        subject: json["subject"],
        subjectGroupType: json["subjectGroupType"],
        id: json["id"],
        subjectGroupId: json["subjectGroupId"],
        subSubjectId: json["subSubjectId"],
        name: json["name"],
        isAdditionalSubject: json["isAdditionalSubject"],
        isTimeTableSubject: json["isTimeTableSubject"],
        totalExtraLeactureForSubject: json["totalExtraLeactureForSubject"],
        presentInExtraLeactureForSubject:
            json["presentInExtraLeactureForSubject"],
        absentInExtraLeactureForSubject:
            json["absentInExtraLeactureForSubject"],
        totalLeactures: json["totalLeactures"],
        presentLeactures: json["presentLeactures"],
        otherAttendance: json["otherAttendance"],
        absentLeactures: json["absentLeactures"],
        averagePresent: json["averagePresent"],
        averageTotal: json["averageTotal"],
        percentageAttendance: json["percentageAttendance"].toDouble(),
        subjectMasterId: json["subjectMasterId"],
        actualSubjectId: json["actualSubjectId"],
        subjectType: json["subjectType"],
        conversionMark: json["conversionMark"],
        isSubjectSeleted: json["isSubjectSeleted"],
        sequence: json["sequence"],
        subjectMappingId: json["subjectMappingId"],
        courseContent: json["courseContent"],
        isAttendaceFilled: json["isAttendaceFilled"],
        isExamDateSheetCreated: json["isExamDateSheetCreated"],
        isSubjectTeacher: json["isSubjectTeacher"],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "code": code,
        "batchId": batchId,
        "groupName": groupName,
        "subject": subject,
        "subjectGroupType": subjectGroupType,
        "id": id,
        "subjectGroupId": subjectGroupId,
        "subSubjectId": subSubjectId,
        "name": name,
        "isAdditionalSubject": isAdditionalSubject,
        "isTimeTableSubject": isTimeTableSubject,
        "totalExtraLeactureForSubject": totalExtraLeactureForSubject,
        "presentInExtraLeactureForSubject": presentInExtraLeactureForSubject,
        "absentInExtraLeactureForSubject": absentInExtraLeactureForSubject,
        "totalLeactures": totalLeactures,
        "presentLeactures": presentLeactures,
        "otherAttendance": otherAttendance,
        "absentLeactures": absentLeactures,
        "averagePresent": averagePresent,
        "averageTotal": averageTotal,
        "percentageAttendance": percentageAttendance,
        "subjectMasterId": subjectMasterId,
        "actualSubjectId": actualSubjectId,
        "subjectType": subjectType,
        "conversionMark": conversionMark,
        "isSubjectSeleted": isSubjectSeleted,
        "sequence": sequence,
        "subjectMappingId": subjectMappingId,
        "courseContent": courseContent,
        "isAttendaceFilled": isAttendaceFilled,
        "isExamDateSheetCreated": isExamDateSheetCreated,
        "isSubjectTeacher": isSubjectTeacher,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
