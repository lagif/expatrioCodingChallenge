import 'package:coding_challenge/shared/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserTaxInfoScreen extends StatefulWidget {
  const UserTaxInfoScreen({super.key});

  @override
  State<UserTaxInfoScreen> createState() => _UserTaxInfoScreenState();
}

class _UserTaxInfoScreenState extends State<UserTaxInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/CryingGirl.svg',
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Uh-Oh",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "We need your tax data in order"
                          " for you to access your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                          maxLines: 4,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    _openTaxDataForm(context);
                  },
                  child: const Text('UPDATE YOUR TAX DATA'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _openTaxDataForm(BuildContext context) {
    AppBottomSheet.show(
      context: context,
      child: const SizedBox(height: 100),
    );
  }
}
