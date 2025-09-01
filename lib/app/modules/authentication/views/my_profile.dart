import 'package:smart_ryde/app/core/widgets/custom_back_button.dart';

import '../../../../../export.dart';
import '../controllers/my_profile_controller.dart';

class MyProfileScreen extends GetView<MyProfileController> {
  final formGlobalKey = GlobalKey<FormState>();

  MyProfileScreen({super.key});

  Widget profileHeader(context) {
    return Container(
      height: 160,
      color: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomBackButton(
            title: keyMyProfile.tr,
            onTap: () {
              Get.back();
              Get.find<HomeController>().getData();
            },
          ),
        ],
      ),
    );
  }

  listTile({context, text, icon, onTap}) => InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                text,
                style: textStyleDisplayMedium(context).copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          onTap();
        },
      );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {},
      child: SafeArea(
        child: GetBuilder<MyProfileController>(
            init: MyProfileController(),
            builder: (controller) {
              return Scaffold(
                // appBar: CustomAppBar(appBarTitleText: 'Edit Profile',),
                body: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      width: Get.width,
                      height: Get.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          profileHeader(context),
                          SizedBox(
                            height: 80,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.userData?.name ?? '',
                                    style: textStyleDisplayMedium(context)
                                        .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    controller.userData?.phone ?? '',
                                    style: textStyleDisplayMedium(context)
                                        .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          listTile(
                            context: context,
                            text: keyEditProfileDetails.tr,
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.editProfile,
                              );
                            },
                          ),
                          Divider(
                            color: Colors.grey.shade400,
                          ),
                          listTile(
                            context: context,
                            text: keyLogOut.tr,
                            onTap: () {
                              PreferenceManger().isUserLogin(false);
                              PreferenceManger().clearLoginData();
                              Get.find<HomeController>().getData();
                              Get.back();
                              toast(keyLogoutSuccess.tr);
                            },
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 110,
                      left: 50,
                      right: 50,
                      child: GestureDetector(
                        onTap: () {
                          controller.addProfilePicture(context);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: controller.tempFile != null
                                      ? ClipOval(
                                          child: Image.file(
                                            controller.tempFile!,
                                            fit: BoxFit.fill,
                                            height: 90,
                                            width: 90,
                                          ),
                                        )
                                      : AssetImageWidget(
                                          imageUrl: imageUser,
                                          imageHeight: 90,
                                          imageWidth: 90,
                                          radiusAll: 90,
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 110,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                color: primaryColor,
                                child: Icon(
                                  Icons.mode_edit_outline_outlined,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
