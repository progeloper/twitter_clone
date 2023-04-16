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
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _dateController;

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

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
  }

  void navigateToDetailsScreen(BuildContext context){
    if(_nameController.text.isNotEmpty && _emailController.text.isNotEmpty && _dateController.text.isNotEmpty){
      Routemaster.of(context).push('/details-screen/${_nameController.text.trim()}/${_emailController.text.trim()}/${_dateController.text.trim()}');
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
                Column(
                  children: [
                    OutlinedTextField(
                      label: 'Name',
                      function: () {},
                      controller: _nameController,
                      maxChar: 50,
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
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
