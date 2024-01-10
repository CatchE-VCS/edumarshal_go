import 'package:auto_route/auto_route.dart';
import 'package:edumarshal/controllers/auth.dart';
import 'package:edumarshal/core/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../utils/snackbar.dart';

@RoutePage(
  deferredLoading: true,
)
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _loading = false;
  String username = '';
  String password = '';

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(),
        elevation: 20,
        centerTitle: true,
        title: Text(
          'Edumarshal App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.roboto().fontFamily,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.88,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
            vertical: MediaQuery.of(context).size.height * 0.03,
          ),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                    ),
                  ),
                  SizedBox(
                    height: 290,
                    width: 400,
                    child: Lottie.network(
                        'https://lottie.host/e812138e-b6b4-4c4c-b187-b3b402574740/3qniRfkxZa.json'),
                  ),
                  TextFormField(
                    autofillHints: const [AutofillHints.username],
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Edumarshal username',
                      labelText: 'Username',
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Username';
                      }
                      username = value;
                      return null;
                    },
                  ),
                  TextFormField(
                    autofillHints: const [AutofillHints.password],
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: _obscureText
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      password = value;
                      return null;
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 136, 211, 245),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.5,
                          MediaQuery.of(context).size.height * 0.08),
                      shape: const StadiumBorder(),
                      visualDensity: VisualDensity.compact,
                      alignment: Alignment.center,
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        SnackBarUtil()
                            .simpleSnackBar(context, 'Logging you in....');
                        String? accessToken =
                            await Controller().login(username, password);
                        if (!mounted) return;
                        SnackBarUtil()
                            .simpleSnackBar(context, 'Logged in successfully');
                        _formKey.currentState!.reset();
                        context.router.replace(
                            HiddenDrawerRoute(accessToken: accessToken!));
                      }
                      setState(() {
                        _loading = false;
                      });
                    },
                    child: _loading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
