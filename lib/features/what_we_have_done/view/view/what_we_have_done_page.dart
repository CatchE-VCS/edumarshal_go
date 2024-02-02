import 'package:auto_route/auto_route.dart';
import 'package:edumarshal/core/theme/theme_controller.dart';

import 'package:edumarshal/features/what_we_have_done/view/contoller/wwhd_repository.dart';
import 'package:edumarshal/features/widgets/Glass.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

    final color = currentTheme == ThemeMode.dark
        ? Colors.white
        : currentTheme == ThemeMode.light
            ? Color.fromARGB(255, 0, 0, 0)
            : isDarkMode
                ? Color.fromARGB(255, 255, 255, 255)
                : const Color.fromARGB(255, 0, 0, 0);

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
        child: Stack(children: [
          ref.watch(overallDataStatsPod).when(
            data: (data) {
              if (kDebugMode) {
                print(data);
              }
              return SizedBox(
                  height: 1000,
                  child: Lottie.network(
                      'https://lottie.host/559ca181-83df-427b-8ea7-49d2636f9128/WDGZpR5J3c.json'));
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
                  child: Text('Loading'),
                ),
              );
            },
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height + 100,
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
                        return Padding(
                          padding: const EdgeInsets.only(top: 30, left: 10),
                          child: Glass(
                            height: 200,
                            width: 400,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Overall Stats for all users',
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total data delivered:',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                    Text(
                                      '${double.parse(data["compressedDataKiloBytes"].toString()).toStringAsFixed(2)} KB',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Data saved:',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                    Text(
                                      '${double.parse((data["actualDataKiloBytes"] - data["compressedDataKiloBytes"]).toString()).toStringAsFixed(2)} KB',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Number of requests:',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                    Text(
                                      data["numberOfRequests"].toString(),
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                            child: Text('Loading'),
                          ),
                        );
                      },
                    ),
                    ref.watch(individualDataStatsPod).when(
                      data: (data) {
                        return Padding(
                          padding: EdgeInsets.only(top: 30, left: 10),
                          child: Glass(
                            height: 200,
                            width: 400,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Stats',
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total data delivered:',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                    Text(
                                      '${double.parse(data["compressedDataKiloBytes"].toString()).toStringAsFixed(2)} KB',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Data saved:',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                    Text(
                                      '${double.parse((data["actualDataKiloBytes"] - data["compressedDataKiloBytes"]).toString()).toStringAsFixed(2)} KB',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Number of requests:',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                    Text(
                                      data["numberOfRequests"].toString(),
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
