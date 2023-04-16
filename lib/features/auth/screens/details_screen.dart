import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/common/widgets/outline_textfield.dart';
import '../../../theme/palette.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  final String name;
  final String email;
  final String dob;
  const DetailsScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.dob,
  }) : super(key: key);

  @override
  ConsumerState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _reenterController;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();

    _passwordController = TextEditingController();
    _reenterController = TextEditingController();
  }


  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
    _reenterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/twitter-logo.svg',
          colorFilter: const ColorFilter.mode(
            Palette.blueColor,
            BlendMode.srcIn,
          ),
          fit: BoxFit.scaleDown,
          width: 35,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create your account',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      OutlinedTextField(
                        label: 'Password',
                        function: () {},
                        controller: _passwordController,
                        obscured: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      OutlinedTextField(
                        label: 'Confirm password',
                        function: () {},
                        controller: _reenterController,
                        obscured: true,
                        validate: (value){
                          if(value != _passwordController.text){
                            return 'Please ensure both passwords match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: TextButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('yo')));
                              }
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                              backgroundColor: Palette.blueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
