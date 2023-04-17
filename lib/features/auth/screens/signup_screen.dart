import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';
import 'package:twitter_clone/core/common/widgets/outline_textfield.dart';
import 'package:twitter_clone/theme/palette.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _emailController;
  late TextEditingController _dateController;
  final _formKey = GlobalKey<FormState>();

  Future<void> showDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950, 1, 1),
      lastDate: DateTime(2100, 1, 1),
    );
    if (pickedDate != null) {
      _dateController.text = DateFormat('dd MMMM yyyy').format(pickedDate);
    }
  }

  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController();
    _emailController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
  }

  void navigateToDetailsScreen(BuildContext context) {
    if (_firstNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _dateController.text.isNotEmpty) {
      if(_formKey.currentState!.validate()){
        Routemaster.of(context).push(
            '/details-screen/${_firstNameController.text.trim()}/${_emailController.text.trim()}/${_dateController.text.trim()}');
      }
    }
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
          padding: const EdgeInsets.all(16.0),
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
                        label: 'First name',
                        function: () {},
                        validate: (value) {
                          if (value!.length < 4) {
                            return 'Please enter your full name';
                          }
                        },
                        controller: _firstNameController,
                        maxChar: 25,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OutlinedTextField(
                        label: 'Email address',
                        function: () {},
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      OutlinedTextField(
                        label: 'Date of birth',
                        function: () {
                          showDate(context);
                        },
                        readOnly: true,
                        controller: _dateController,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5.5,
                ),
                const Divider(
                  thickness: 1.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: TextButton(
                      onPressed: ()=>navigateToDetailsScreen(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        backgroundColor: Palette.blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: const Text(
                        'Next',
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
          ),
        ),
      ),
    );
  }
}
