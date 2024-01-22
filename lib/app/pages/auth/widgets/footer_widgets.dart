import 'package:colorword_new/core/extensions/string_extension.dart';
import 'package:colorword_new/core/init/constants.dart';
import 'package:colorword_new/core/init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterWidgets extends StatelessWidget {
  const FooterWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 40.0, top: 10),
          child: Divider(
            height: 1,
            color: Colors.grey,
            thickness: 0.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: SizedBox(
            height: 50,
            width: 200,
            child: Material(
              borderRadius: AllBorderRadius.mediumBorderRadius(),
              color: Colors.white,
              child: InkWell(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Image(image: AssetImage(AppConstants.googleIcon), height: 28),
                    ),
                    Text(
                      LocaleKeys.login_signWithGoogle.locale,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(LocaleKeys.login_dontHaveAccount.locale,
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w600, color: Colors.white54, fontSize: 18)),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: AllBorderRadius.mediumBorderRadius(), color: Colors.white12),
                child: TextButton(
                    onPressed: () {},
                    child: Text(LocaleKeys.login_signIn.locale,
                        style: GoogleFonts.roboto(color: Colors.white54, fontSize: 20, fontWeight: FontWeight.w700))),
              )
            ],
          ),
        )
      ],
    );
  }
}
