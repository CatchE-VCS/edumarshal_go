import 'package:dio/dio.dart';
import 'package:edumarshal/bootstrap.dart';
import 'package:edumarshal/shared/api_client/dio/bad_certificate_fixer.dart';
import 'package:edumarshal/shared/api_client/dio/default_api_interceptor.dart';
import 'package:edumarshal/shared/api_client/dio/default_time_response_interceptor.dart';
import 'package:edumarshal/shared/api_client/dio/form_data_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

///This provider dioClient with interceptors(TimeResponseInterceptor,FormDataInterceptor,TalkerDioLogger,DefaultAPIInterceptor)
///with fixing bad certificate.
final dioProvider = Provider.autoDispose<Dio>(
  (ref) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 45),
        receiveTimeout: const Duration(minutes: 3),
      ),
    );
    dio.options.baseUrl = 'https://api.edumarshal.aeronex.one/api/v1/';
    if (kDebugMode) {
      dio.interceptors.add(TimeResponseInterceptor());
      dio.interceptors.add(FormDataInterceptor());
      dio.interceptors.add(
        TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
          ),
        ),
      );
    }

    dio.interceptors.addAll([
      DefaultAPIInterceptor(dio: dio),
      // RetryInterceptor(
      //   dio: dio,
      //   logPrint: talker.log, // specify log function (optional)
      //   // retry count (optional)
      //   retries: 2,
      //   retryDelays: [
      //     const Duration(seconds: 2),
      //     const Duration(seconds: 4),
      //     const Duration(seconds: 6),
      //   ],
      //   retryEvaluator: (error, i) {
      //     // only retry on DioError
      //     if (error.error is SocketException) {
      //       // only retry on timeout error
      //       return true;
      //     } else {
      //       // coverage:ignore-line
      //       return false;
      //     }
      //   },
      // ),
    ]);
    fixBadCertificate(dio: dio);
    return dio;
  },
  name: 'dioProvider',
);
