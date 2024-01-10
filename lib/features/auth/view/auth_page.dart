import 'package:auto_route/auto_route.dart';
import 'package:edumarshal/features/widgets/custom_text_form_field.dart';
import 'package:edumarshal/features/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/router/router.gr.dart';
import '../auth.dart';

@RoutePage(
  deferredLoading: true,
)
class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);
  static final formKey = GlobalKey<FormState>();

  static TextEditingController usernameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static Function simpleSnackBar = SnackBarUtil().simpleSnackBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool obscureText = ref.watch(passwordVisibilityPod);
    bool loading = ref.watch(authLoadingPod);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          reverse: true,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      height: 254,
                      width: 350,
                      child: Lottie.network(
                          'https://lottie.host/e812138e-b6b4-4c4c-b187-b3b402574740/3qniRfkxZa.json'),
                    ),
                    CustomTextFormField(
                      controller: usernameController,
                      autofillHints: const [AutofillHints.username],
                      inputType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your Edumarshal username',
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.alternate_email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      autofillHints: const [AutofillHints.password],
                      inputType: TextInputType.visiblePassword,
                      obscure: obscureText,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: obscureText
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined),
                          onPressed: ref
                              .read(passwordVisibilityPod.notifier)
                              .togglePasswordVisibility,
                        ),
                      ),
                      validator: (_) => _ != null && _.isNotEmpty
                          ? null
                          : 'Please enter your password',
                    ),
                    const SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         // Unfocus textfield before pushing route
                    //         FocusManager.instance.primaryFocus?.unfocus();
                    //         TextEditingController admissionController =
                    //             TextEditingController();
                    //
                    //         showDialog(
                    //           context: context,
                    //           builder: (context) => AlertDialog(
                    //             title: const Text('Reset Password'),
                    //             content: Column(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 SizedBox(
                    //                   height: 60,
                    //                   width: 300,
                    //                   child: TextFormField(
                    //                     controller: admissionController,
                    //                     keyboardType: TextInputType.text,
                    //                     decoration: const InputDecoration(
                    //                       border: OutlineInputBorder(),
                    //                       hintText: 'Admission No.',
                    //                       labelText: 'Admission No.',
                    //                     ),
                    //                     style: const TextStyle(
                    //                       fontSize: 18,
                    //                     ),
                    //                     validator: (value) {
                    //                       if (value == null || value.isEmpty) {
                    //                         return 'Please enter your Username';
                    //                       }
                    //                       return null;
                    //                     },
                    //                   ),
                    //                 ),
                    //                 DatePickerDialog(
                    //                   confirmText: 'OK',
                    //                   firstDate: DateTime(1900),
                    //                   lastDate: DateTime.now(),
                    //                   initialDate: DateTime.now(),
                    //                 )
                    //               ],
                    //             ),
                    //             actions: [
                    //               TextButton(
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: const Text('OK'),
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //       child: const Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 8.0),
                    //         child: Text(
                    //           'Forgot password?',
                    //           style: TextStyle(
                    //             fontSize: 15,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: MediaQuery.of(context).size.height / 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        extendedIconLabelSpacing: 20,
        isExtended: true,
        onPressed: loading
            ? null
            : () {
                if (formKey.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();
// Validate returns true if the form is valid, or false otherwise.
                  ref.read(authLoadingPod.notifier).startLoading();

// If the form is valid, display a snack-bar. In the real world,
// you'd often call a server or save the information in a database.
                  simpleSnackBar(context, 'Logging you in....');

                  ref
                      .read(authRepositoryProvider)
                      .login(
                        usernameController.text.trim(),
                        passwordController.text.trim(),
                      )
                      .then((value) {
                    if (value == null) {
                      simpleSnackBar(context, 'Invalid credentials');
                      Future.delayed(const Duration(seconds: 3), () {
                        ref.read(authLoadingPod.notifier).stopLoading();
                      });
                      return null;
                    }
                    simpleSnackBar(context, 'Logged in successfully');
                    usernameController.text = '';
                    passwordController.text = '';
                    usernameController.clear();
                    passwordController.clear();
                    formKey.currentState!.reset();

                    ref.read(authLoadingPod.notifier).stopLoading();

                    context.router
                        .pushAndPopUntil(HiddenDrawerRoute(accessToken: value),
                            predicate: (Route<dynamic> route) {
                      return false;
                    });
                  }).catchError((e) {
                    simpleSnackBar(context, e.toString());
                    Future.delayed(const Duration(seconds: 3), () {
                      ref.read(authLoadingPod.notifier).stopLoading();
                    });
                    return null;
                  });
                }
              },
        label:
            loading ? const CircularProgressIndicator() : const Text('Login'),
        icon: loading ? null : const Icon(Icons.login),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
