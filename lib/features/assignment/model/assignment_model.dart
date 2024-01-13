// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<AssignmentModel> assignmentModelFromList(List<dynamic> str) =>
    List<AssignmentModel>.from(str.map((x) => AssignmentModel.fromJson(x)));

String assignmentModelToJson(List<AssignmentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssignmentModel {
  int? assignmentId;
  int? organizationId;
  int? userId;
  String? title;
  int? batchId;
  int? subjectId;
  String? content;
  String? blobId;
  DateTime? dueDate;
  bool? isDeleted;
  bool? isBatchWise;
  int? submissionStatus;
  dynamic groupId;
  bool? isGroupWiseAssignment;
  dynamic assignmentUserStatus;
  List<Subject>? subjectList;
  dynamic assignmentUserStatusDto;
  dynamic users;
  DateTime? dateTimeStampIns;
  int? insUserId;
  int? profilePictureId;
  dynamic teacherName;
  Subject? subjectName;
  bool? isCompulsaryStudentAttachment;
  dynamic batchName;
  DateTime? dateTimeStamp;
  dynamic assignmentType;
  int? unreadCount;
  dynamic maxScore;
  dynamic pastDueSubmission;
  bool? restrictSubmission;
  int? assignmentStatus;
  dynamic showAssignmentType;
  int? teacherResponseBlobId;
  dynamic zoomRequestData;
  dynamic zoomResponseData;
  dynamic meetingStartDate;
  dynamic meetingStartTime;
  bool? meetingStatus;
  dynamic remark;
  dynamic subType;
  dynamic meetingId;
  dynamic meetingPassword;
  dynamic studentVideoUrl;
  dynamic teacherVideoUrl;
  dynamic assignmentCreatedDate;
  dynamic assignmentSubmissionDate;
  dynamic studentIds;
  dynamic attachments;
  int? totalSubmissionCount;
  bool? isShowSubmitButton;
  int? convertedSubjectId;
  int? numberOfAttempts;
  dynamic meetingStartDateInString;
  dynamic meetingEndDateInString;
  bool? showJoinButton;
  dynamic errorMessage;
  dynamic zoomStartUrl;
  dynamic zoomAuthorizeToken;
  dynamic assignmentScore;
  dynamic assessmentType;
  int? masterSubjectId;
  bool? isSubmitted;
  DateTime? meetingDate;
  int? assessmentUserMappingId;
  List<dynamic>? blobIdsList;
  SubmittedAssignmentDetails? submittedAssignmentDetails;
  int? submissionId;
  dynamic submissionBlobIdsList;
  dynamic groupName;
  dynamic udf1;
  dynamic udf2;

  AssignmentModel({
    this.assignmentId,
    this.organizationId,
    this.userId,
    this.title,
    this.batchId,
    this.subjectId,
    this.content,
    this.blobId,
    this.dueDate,
    this.isDeleted,
    this.isBatchWise,
    this.submissionStatus,
    this.groupId,
    this.isGroupWiseAssignment,
    this.assignmentUserStatus,
    this.subjectList,
    this.assignmentUserStatusDto,
    this.users,
    this.dateTimeStampIns,
    this.insUserId,
    this.profilePictureId,
    this.teacherName,
    this.subjectName,
    this.isCompulsaryStudentAttachment,
    this.batchName,
    this.dateTimeStamp,
    this.assignmentType,
    this.unreadCount,
    this.maxScore,
    this.pastDueSubmission,
    this.restrictSubmission,
    this.assignmentStatus,
    this.showAssignmentType,
    this.teacherResponseBlobId,
    this.zoomRequestData,
    this.zoomResponseData,
    this.meetingStartDate,
    this.meetingStartTime,
    this.meetingStatus,
    this.remark,
    this.subType,
    this.meetingId,
    this.meetingPassword,
    this.studentVideoUrl,
    this.teacherVideoUrl,
    this.assignmentCreatedDate,
    this.assignmentSubmissionDate,
    this.studentIds,
    this.attachments,
    this.totalSubmissionCount,
    this.isShowSubmitButton,
    this.convertedSubjectId,
    this.numberOfAttempts,
    this.meetingStartDateInString,
    this.meetingEndDateInString,
    this.showJoinButton,
    this.errorMessage,
    this.zoomStartUrl,
    this.zoomAuthorizeToken,
    this.assignmentScore,
    this.assessmentType,
    this.masterSubjectId,
    this.isSubmitted,
    this.meetingDate,
    this.assessmentUserMappingId,
    this.blobIdsList,
    this.submittedAssignmentDetails,
    this.submissionId,
    this.submissionBlobIdsList,
    this.groupName,
    this.udf1,
    this.udf2,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      AssignmentModel(
        assignmentId: json["assignmentId"],
        organizationId: json["organizationId"],
        userId: json["userId"],
        title: json["title"],
        batchId: json["batchId"],
        subjectId: json["subjectId"],
        content: json["content"],
        blobId: json["blobId"],
        dueDate:
            json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
        isDeleted: json["isDeleted"],
        isBatchWise: json["isBatchWise"],
        submissionStatus: json["submissionStatus"],
        groupId: json["groupId"],
        isGroupWiseAssignment: json["isGroupWiseAssignment"],
        assignmentUserStatus: json["assignmentUserStatus"],
        subjectList: json["subjectList"] == null
            ? []
            : List<Subject>.from(
                json["subjectList"]!.map((x) => subjectValues.map[x]!)),
        assignmentUserStatusDto: json["assignmentUserStatusDto"],
        users: json["users"],
        dateTimeStampIns: json["dateTimeStampIns"] == null
            ? null
            : DateTime.parse(json["dateTimeStampIns"]),
        insUserId: json["insUserId"],
        profilePictureId: json["profilePictureId"],
        teacherName: json["teacherName"],
        subjectName: subjectValues.map[json["subjectName"]]!,
        isCompulsaryStudentAttachment: json["isCompulsaryStudentAttachment"],
        batchName: json["batchName"],
        dateTimeStamp: json["dateTimeStamp"] == null
            ? null
            : DateTime.parse(json["dateTimeStamp"]),
        assignmentType: json["assignmentType"],
        unreadCount: json["unreadCount"],
        maxScore: json["maxScore"],
        pastDueSubmission: json["pastDueSubmission"],
        restrictSubmission: json["restrictSubmission"],
        assignmentStatus: json["assignmentStatus"],
        showAssignmentType: json["showAssignmentType"],
        teacherResponseBlobId: json["teacherResponseBlobId"],
        zoomRequestData: json["zoomRequestData"],
        zoomResponseData: json["zoomResponseData"],
        meetingStartDate: json["meetingStartDate"],
        meetingStartTime: json["meetingStartTime"],
        meetingStatus: json["meetingStatus"],
        remark: json["remark"],
        subType: json["subType"],
        meetingId: json["meetingId"],
        meetingPassword: json["meetingPassword"],
        studentVideoUrl: json["studentVideoUrl"],
        teacherVideoUrl: json["teacherVideoUrl"],
        assignmentCreatedDate: json["assignmentCreatedDate"],
        assignmentSubmissionDate: json["assignmentSubmissionDate"],
        studentIds: json["studentIds"],
        attachments: json["attachments"],
        totalSubmissionCount: json["totalSubmissionCount"],
        isShowSubmitButton: json["isShowSubmitButton"],
        convertedSubjectId: json["convertedSubjectId"],
        numberOfAttempts: json["numberOfAttempts"],
        meetingStartDateInString: json["meetingStartDateInString"],
        meetingEndDateInString: json["meetingEndDateInString"],
        showJoinButton: json["showJoinButton"],
        errorMessage: json["errorMessage"],
        zoomStartUrl: json["zoomStartUrl"],
        zoomAuthorizeToken: json["zoomAuthorizeToken"],
        assignmentScore: json["assignmentScore"],
        assessmentType: json["assessmentType"],
        masterSubjectId: json["masterSubjectId"],
        isSubmitted: json["isSubmitted"],
        meetingDate: json["meetingDate"] == null
            ? null
            : DateTime.parse(json["meetingDate"]),
        assessmentUserMappingId: json["assessmentUserMappingId"],
        blobIdsList: json["blobIdsList"] == null
            ? []
            : List<dynamic>.from(json["blobIdsList"]!.map((x) => x)),
        submittedAssignmentDetails: json["submittedAssignmentDetails"] == null
            ? null
            : SubmittedAssignmentDetails.fromJson(
                json["submittedAssignmentDetails"]),
        submissionId: json["submissionId"],
        submissionBlobIdsList: json["submissionBlobIdsList"],
        groupName: json["groupName"],
        udf1: json["udf1"],
        udf2: json["udf2"],
      );

  Map<String, dynamic> toJson() => {
        "assignmentId": assignmentId,
        "organizationId": organizationId,
        "userId": userId,
        "title": title,
        "batchId": batchId,
        "subjectId": subjectId,
        "content": content,
        "blobId": blobId,
        "dueDate": dueDate?.toIso8601String(),
        "isDeleted": isDeleted,
        "isBatchWise": isBatchWise,
        "submissionStatus": submissionStatus,
        "groupId": groupId,
        "isGroupWiseAssignment": isGroupWiseAssignment,
        "assignmentUserStatus": assignmentUserStatus,
        "subjectList": subjectList == null
            ? []
            : List<dynamic>.from(
                subjectList!.map((x) => subjectValues.reverse[x])),
        "assignmentUserStatusDto": assignmentUserStatusDto,
        "users": users,
        "dateTimeStampIns": dateTimeStampIns?.toIso8601String(),
        "insUserId": insUserId,
        "profilePictureId": profilePictureId,
        "teacherName": teacherName,
        "subjectName": subjectValues.reverse[subjectName],
        "isCompulsaryStudentAttachment": isCompulsaryStudentAttachment,
        "batchName": batchName,
        "dateTimeStamp": dateTimeStamp?.toIso8601String(),
        "assignmentType": assignmentType,
        "unreadCount": unreadCount,
        "maxScore": maxScore,
        "pastDueSubmission": pastDueSubmission,
        "restrictSubmission": restrictSubmission,
        "assignmentStatus": assignmentStatus,
        "showAssignmentType": showAssignmentType,
        "teacherResponseBlobId": teacherResponseBlobId,
        "zoomRequestData": zoomRequestData,
        "zoomResponseData": zoomResponseData,
        "meetingStartDate": meetingStartDate,
        "meetingStartTime": meetingStartTime,
        "meetingStatus": meetingStatus,
        "remark": remark,
        "subType": subType,
        "meetingId": meetingId,
        "meetingPassword": meetingPassword,
        "studentVideoUrl": studentVideoUrl,
        "teacherVideoUrl": teacherVideoUrl,
        "assignmentCreatedDate": assignmentCreatedDate,
        "assignmentSubmissionDate": assignmentSubmissionDate,
        "studentIds": studentIds,
        "attachments": attachments,
        "totalSubmissionCount": totalSubmissionCount,
        "isShowSubmitButton": isShowSubmitButton,
        "convertedSubjectId": convertedSubjectId,
        "numberOfAttempts": numberOfAttempts,
        "meetingStartDateInString": meetingStartDateInString,
        "meetingEndDateInString": meetingEndDateInString,
        "showJoinButton": showJoinButton,
        "errorMessage": errorMessage,
        "zoomStartUrl": zoomStartUrl,
        "zoomAuthorizeToken": zoomAuthorizeToken,
        "assignmentScore": assignmentScore,
        "assessmentType": assessmentType,
        "masterSubjectId": masterSubjectId,
        "isSubmitted": isSubmitted,
        "meetingDate": meetingDate?.toIso8601String(),
        "assessmentUserMappingId": assessmentUserMappingId,
        "blobIdsList": blobIdsList == null
            ? []
            : List<dynamic>.from(blobIdsList!.map((x) => x)),
        "submittedAssignmentDetails": submittedAssignmentDetails?.toJson(),
        "submissionId": submissionId,
        "submissionBlobIdsList": submissionBlobIdsList,
        "groupName": groupName,
        "udf1": udf1,
        "udf2": udf2,
      };
}

enum Subject { HOME_WORK }

final subjectValues = EnumValues({"HOME WORK": Subject.HOME_WORK});

class SubmittedAssignmentDetails {
  int? submissionId;
  int? assignmentId;
  int? userId;
  String? textResponse;
  String? blobId;
  dynamic contentType;
  DateTime? submissionDate;
  dynamic admissionNumber;
  dynamic studentName;
  int? submissionStatus;
  int? organizationId;
  dynamic submissionBlobIdsList;

  SubmittedAssignmentDetails({
    this.submissionId,
    this.assignmentId,
    this.userId,
    this.textResponse,
    this.blobId,
    this.contentType,
    this.submissionDate,
    this.admissionNumber,
    this.studentName,
    this.submissionStatus,
    this.organizationId,
    this.submissionBlobIdsList,
  });

  factory SubmittedAssignmentDetails.fromJson(Map<String, dynamic> json) =>
      SubmittedAssignmentDetails(
        submissionId: json["submissionId"],
        assignmentId: json["assignmentId"],
        userId: json["userId"],
        textResponse: json["textResponse"],
        blobId: json["blobId"],
        contentType: json["contentType"],
        submissionDate: json["submissionDate"] == null
            ? null
            : DateTime.parse(json["submissionDate"]),
        admissionNumber: json["admissionNumber"],
        studentName: json["studentName"],
        submissionStatus: json["submissionStatus"],
        organizationId: json["organizationId"],
        submissionBlobIdsList: json["submissionBlobIdsList"],
      );

  Map<String, dynamic> toJson() => {
        "submissionId": submissionId,
        "assignmentId": assignmentId,
        "userId": userId,
        "textResponse": textResponse,
        "blobId": blobId,
        "contentType": contentType,
        "submissionDate": submissionDate?.toIso8601String(),
        "admissionNumber": admissionNumber,
        "studentName": studentName,
        "submissionStatus": submissionStatus,
        "organizationId": organizationId,
        "submissionBlobIdsList": submissionBlobIdsList,
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
