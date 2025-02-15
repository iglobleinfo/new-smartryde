import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_ryde/app/core/values/dimens.dart';
import 'package:smart_ryde/app/core/values/text_styles.dart';
import 'package:smart_ryde/app/core/widgets/text_view.dart';

class BottomPhonePicker extends StatelessWidget {
  const BottomPhonePicker({
    super.key,
    required this.countryCode,
    required this.selectedCountryCode,
  });
  final List<String> countryCode;
  final Function(String) selectedCountryCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: margin_10,
        ),
        TextView(
          text: 'Select Country Code',
          textStyle: textStyleBodyLarge(context),
        ),
        SizedBox(
          height: margin_10,
        ),
        SizedBox(
          height: Get.height * 0.4,
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              String country = countryCode[index];
              return GestureDetector(
                onTap: (){
                  selectedCountryCode.call(country);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextView(
                    text: country,
                    textAlign: TextAlign.start,
                    textStyle: textStyleBodyMedium(context),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 0.5,
                  color: Colors.grey.shade200,
                ),
              );
            },
            itemCount: countryCode.length,
          ),
        )
      ],
    );
  }
}
