import 'package:smart_ryde/app/modules/home_booking/bottomsheets/destiny_bottomsheet.dart';
import 'package:smart_ryde/app/modules/home_booking/bottomsheets/region_bottomsheet.dart';
import 'package:smart_ryde/app/modules/home_booking/bottomsheets/stop_bottomsheet.dart';

import '../../../../../../export.dart';
import '../controller/home_destination_controller.dart';

class HomeDestinyScreen extends GetView<HomeDestinyController> {
  final formGlobalKey = GlobalKey<FormState>();

  HomeDestinyScreen(
      {super.key, required this.matchId, required this.pickUpName});

  final String matchId;
  final String pickUpName;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeDestinyController>(
      init: HomeDestinyController(),
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: controller.pickUp1StopId != null
              ? MaterialButtonWidget(
                  minWidth: Get.width,
                  buttonText: 'Search for suitable bus'.toUpperCase(),
                  onPressed: () {
                    if (matchId == controller.pickUp1StopId.toString()) {
                      toast(
                          'Pickup stop and Destination stop cannot be the same');
                    } else {
                      if (PreferenceManger().getStatusUserLogin() ?? false) {
                        Get.toNamed(AppRoutes.busList, arguments: {
                          'fromId': int.parse(matchId),
                          'toId': controller.pickUp1StopId,
                          'fromName': pickUpName,
                          'toName': controller.stop1Controller.text,
                        });
                      } else {
                        Get.toNamed(AppRoutes.logIn);
                      }
                    }
                  },
                )
              : SizedBox(),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 20),
                child: TextView(
                  text: stringSelectDestination.tr,
                  textStyle: textStyleLabelSmall(context).copyWith(
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              pickUpForm(context: context)
            ],
          ),
        );
      },
    );
  }

  Widget pickUpForm({
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: margin_12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: margin_30,
          ),
          Container(
            child: Form(
              key: formGlobalKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    textColor: Colors.grey,
                    hint: 'Select Your Destiny',
                    hintStyle: textStyleBodyMedium(context).copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 17),
                    readOnly: true,
                    onTap: () {
                      Get.bottomSheet(
                        DestinyBottomsheet(
                          list: controller.districtList,
                          selectedDistrict: (district) {
                            controller.destiny1Controller.text = district;
                            Get.back();
                          },
                          selectedDistrictId: (districtId) {
                            controller.pickUp1DistrictId = districtId;
                            controller.pickUp1RegionId = null;
                            controller.region1Controller.clear();
                            controller.stop1Controller.clear();
                            controller.hitGetRegion();
                            controller.update();
                          },
                        ),
                      );
                    },
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey,
                    ),
                    textController: controller.destiny1Controller,
                    shadow: true,
                    validate: (String? value) {
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  controller.pickUp1DistrictId != null
                      ? TextFieldWidget(
                          textColor: Colors.grey,
                          hint: 'Select Your Area',
                          hintStyle: textStyleBodyMedium(context).copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 17),
                          readOnly: true,
                          onTap: () {
                            Get.bottomSheet(
                              RegionBottomsheet(
                                list: controller.regionList,
                                selectedRegion: (region) {
                                  controller.region1Controller.text = region;
                                  Get.back();
                                },
                                selectedRegionId: (regionId) {
                                  controller.pickUp1RegionId = regionId;
                                  controller.stop1Controller.clear();
                                  controller.pickUp1StopId = null;
                                  controller.hitGetStop();
                                  controller.update();
                                },
                              ),
                            );
                          },
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey,
                          ),
                          textController: controller.region1Controller,
                          shadow: true,
                          validate: (String? value) {
                            return null;
                          },
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  controller.pickUp1RegionId != null
                      ? TextFieldWidget(
                          textColor: Colors.grey,
                          hint: 'Select Your Stop',
                          hintStyle: textStyleBodyMedium(context).copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 17),
                          readOnly: true,
                          onTap: () {
                            Get.bottomSheet(
                              StopBottomsheet(
                                list: controller.stopList,
                                selectedStop: (stop) {
                                  controller.stop1Controller.text = stop;
                                  Get.back();
                                },
                                selectedStopId: (stopId) {
                                  controller.pickUp1StopId = stopId;
                                  controller.update();
                                },
                              ),
                            );
                          },
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey,
                          ),
                          textController: controller.stop1Controller,
                          shadow: true,
                          validate: (String? value) {
                            return null;
                          },
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ).marginOnly(bottom: margin_30),
          ),
        ],
      ),
    );
  }
}
