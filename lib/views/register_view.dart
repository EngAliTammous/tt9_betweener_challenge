import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tt9_betweener_challenge/assets.dart';
import 'package:tt9_betweener_challenge/controllers/auth_controller.dart';
import 'package:tt9_betweener_challenge/show_mixin.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import 'package:tt9_betweener_challenge/views/widgets/secondary_button_widget.dart';

import '../../views/widgets/google_button_widget.dart';

class RegisterView extends StatefulWidget {
  static String id = '/registerView';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with Helpers {
  late TextEditingController nameController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController conformationPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    conformationPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    conformationPasswordController.dispose();
    super.dispose();
  }

  bool checkRegister = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                      child: Hero(
                          tag: 'authImage',
                          child: SvgPicture.asset(AssetsData.authImage))),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                      controller: nameController,
                      hint: 'John Doe',
                      label: 'Name',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter name';
                        }
                      }),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                      controller: emailController,
                      hint: 'example@gmail.com',
                      label: 'Email',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter email';
                        }
                      }),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                      controller: passwordController,
                      hint: 'Enter password',
                      label: 'password',
                      password: true,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter password';
                        }
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    controller: conformationPasswordController,
                    hint: 'Enter conformation password',
                    label: 'conformation password',
                    password: true,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter password to conformation';
                      }
                    },
                  ),
                // const Center(child: CircularProgressIndicator()),
                  const SizedBox(
                    height: 24,
                  ),
                  SecondaryButtonWidget(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          showMessage(context, message: 'Registration...');

                          try {
                            await register(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                                conformationPasswordController.text);
                            if (mounted) {
                              Navigator.pop(context);
                            }
                            print('register successfully');
                          } catch (e) {
                          showMessage(context, message: 'Registration failed. Please try again.',error: true);
                          }
                        }
                      },
                      text: 'REGISTER'),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    '-  or  -',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GoogleButtonWidget(onTap: () {}),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
