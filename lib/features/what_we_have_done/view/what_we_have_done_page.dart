import 'package:auto_route/auto_route.dart';
import 'package:edumarshal/core/theme/theme_controller.dart';
import 'package:edumarshal/features/what_we_have_done/controller/wwhd_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage(
  deferredLoading: true,
)
class WhatWeHaveDonePage extends ConsumerWidget {
  const WhatWeHaveDonePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var brightness = Theme.of(context).brightness;
    var currentTheme = ref.watch(themecontrollerProvider);
    var isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'What We Have Done',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var a = ref.refresh(overallDataStatsPod);
          var x = ref.refresh(individualDataStatsPod);
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              ref.watch(overallDataStatsPod).when(
                data: (data) {
                  if (kDebugMode) {
                    print(data);
                  }
                  return Container(
                    margin: const EdgeInsets.all(14),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: currentTheme == ThemeMode.dark
                          ? Colors.grey.shade900
                          : currentTheme == ThemeMode.light
                              ? Colors.grey.shade200
                              : isDarkMode
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overall Stats for all users',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total data delivered:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            Text(
                              '${double.parse(data["compressedDataKiloBytes"].toString()).toStringAsFixed(2)} KB',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Data saved:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            Text(
                              '${double.parse((data["actualDataKiloBytes"] - data["compressedDataKiloBytes"]).toString()).toStringAsFixed(2)} KB',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Number of requests:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            Text(
                              data["numberOfRequests"].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                error: (e, s) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Center(
                      child: Text('Error'),
                    ),
                  );
                },
                loading: () {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Center(
                      child: Text('Loading'),
                    ),
                  );
                },
              ),
              ref.watch(individualDataStatsPod).when(
                data: (data) {
                  return Container(
                    margin: const EdgeInsets.all(14),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: currentTheme == ThemeMode.dark
                          ? Colors.grey.shade900
                          : currentTheme == ThemeMode.light
                              ? Colors.grey.shade200
                              : isDarkMode
                                  ? Colors.grey.shade900
                                  : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Stats',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total data delivered:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            Text(
                              '${double.parse(data["compressedDataKiloBytes"].toString()).toStringAsFixed(2)} KB',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Data saved:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            Text(
                              '${double.parse((data["actualDataKiloBytes"] - data["compressedDataKiloBytes"]).toString()).toStringAsFixed(2)} KB',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Number of requests:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            Text(
                              data["numberOfRequests"].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                error: (e, s) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(
                      child: Text('Error'),
                    ),
                  );
                },
                loading: () {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.all(14),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: currentTheme == ThemeMode.dark
                      ? Colors.grey.shade900
                      : currentTheme == ThemeMode.light
                          ? Colors.grey.shade200
                          : isDarkMode
                              ? Colors.grey.shade900
                              : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What We Have Done',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      'We have developed an app that fetches compressed data by routing it through our servers.\n\nThis app can be used by any user save their internet data pack.\n\nThis app can be used by any user who want to access Edumarshal in one click.\n\nThis app is an open source project. Anyone can raise a PR request or issues on GitHub.\n\n This app is developed by a team of 3 members.\n\nThis app consumes less data than the official app.\n\nThis app is developed using Flutter and Dart.\n\nThis app is developed by using the latest technologies.\n\nThis app contains a lot of features that are not present in the official app.\n\nThis app contains ads to support the developers and maintain the servers.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
