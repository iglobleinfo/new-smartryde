import 'package:flutter/material.dart';
import 'package:smart_ryde/app/core/values/dimens.dart';
import 'package:smart_ryde/app/core/values/text_styles.dart';
import 'package:smart_ryde/app/core/widgets/text_view.dart';
import 'package:smart_ryde/app/modules/home_booking/models/district_model.dart';

import '../../../../export.dart';

class DestinyBottomsheet extends StatelessWidget {
  const DestinyBottomsheet({
    super.key,
    required this.list,
    required this.selectedDistrict,
    required this.selectedDistrictId,
  });
  final List<DistrictList> list;
  final Function(String) selectedDistrict;
  final Function(int) selectedDistrictId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: 400,
      child: Column(
        children: [
          SizedBox(
            height: margin_10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextView(
                  text: 'Select An Option',
                  textStyle: textStyleBodyLarge(context).copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: TextView(
                    textAlign: TextAlign.center,
                    text: 'Close',
                    textStyle: textStyleBodyLarge(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              height: 0.5,
              color: Colors.grey.shade200,
            ),
          ),
          SizedBox(
            height: 11,
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 20),
              itemBuilder: (BuildContext context, int index) {
                DistrictList listData = list[index];
                return GestureDetector(
                  onTap: () {
                    selectedDistrict.call(listData.nameEng ?? '');
                    selectedDistrictId.call(listData.districtId??0);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextView(
                      text: listData.nameEng ?? '',
                      textAlign: TextAlign.start,
                      textStyle: textStyleBodyMedium(context).copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Divider(
                    height: 0.5,
                    color: Colors.grey.shade200,
                  ),
                );
              },
              itemCount: list.length,
            ),
          )
        ],
      ),
    );
  }
}
