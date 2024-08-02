import 'package:country_code_picker/country_code_picker.dart';
import 'package:sixam_mart_delivery/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart_delivery/features/language/controllers/language_controller.dart';
import 'package:sixam_mart_delivery/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart_delivery/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart_delivery/helper/custom_validator_helper.dart';
import 'package:sixam_mart_delivery/helper/route_helper.dart';
import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/images.dart';
import 'package:sixam_mart_delivery/util/styles.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_button_widget.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_snackbar_widget.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  final FocusNode _cpfFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Center(
            child: SizedBox(
              width: 1170,
              child: GetBuilder<AuthController>(builder: (authController) {

                return Column(children: [

                  Image.asset(Images.logo, width: 200),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                  Text('sign_in'.tr.toUpperCase(), style: robotoBlack.copyWith(fontSize: 30)),
                  const SizedBox(height: 50),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      color: Theme.of(context).cardColor,
                      boxShadow: Get.isDarkMode ? null : [BoxShadow(color: Colors.grey[200]!, spreadRadius: 1, blurRadius: 5)],
                    ),
                    child: Column(children: [

                      CustomTextFieldWidget(
                        hintText: 'cpf'.tr,
                        controller: _cpfController,
                        focusNode: _cpfFocus,
                        nextFocus: _passwordFocus,
                        inputType: TextInputType.number,
                        divider: true,
                        isPhone: false,
                        border: false,
                      ),

                      CustomTextFieldWidget(
                        hintText: 'password'.tr,
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.visiblePassword,
                        prefixIcon: Icons.lock,
                        isPassword: true,
                        border: false,
                        onSubmit: (text) => null,
                      ),

                    ]),
                  ),
                  const SizedBox(height: 10),

                  Row(children: [
                    Expanded(
                      child: ListTile(
                        onTap: () => authController.toggleRememberMe(),
                        leading: Checkbox(
                          activeColor: Theme.of(context).primaryColor,
                          value: authController.isActiveRememberMe,
                          onChanged: (bool? isChecked) => authController.toggleRememberMe(),
                        ),
                        title: Text('remember_me'.tr),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        horizontalTitleGap: 0,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(RouteHelper.getForgotPassRoute()),
                      child: Text('${'forgot_password'.tr}?'),
                    ),
                  ]),
                  const SizedBox(height: 50),

                  !authController.isLoading ? CustomButtonWidget(
                    buttonText: 'sign_in'.tr,
                    onPressed: () => _login(authController, _cpfController, _passwordController, context),
                  ) : const Center(child: CircularProgressIndicator()),
                  SizedBox(height: Get.find<SplashController>().configModel!.toggleDmRegistration! ? Dimensions.paddingSizeSmall : 0),

                  Get.find<SplashController>().configModel!.toggleDmRegistration! ? TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(1, 40),
                    ),
                    onPressed: () {
                      Get.toNamed(RouteHelper.getDeliverymanRegistrationRoute());
                    },
                    child: RichText(text: TextSpan(children: [
                      TextSpan(text: '${'join_as_a'.tr} ', style: robotoRegular.copyWith(color: Theme.of(context).disabledColor)),
                      TextSpan(text: 'delivery_man'.tr, style: robotoMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color)),
                    ])),
                  ) : const SizedBox(),

                ]);
              }),
            ),
          ),
        ),
      )),
    );
  }

  void _login(AuthController authController, TextEditingController cpfText, TextEditingController passText, BuildContext context) async {
    String cpf = cpfText.text.trim();
    String password = passText.text.trim();

    if (cpf.isEmpty) {
      showCustomSnackBar('enter_cpf'.tr);
    //}else if (!phoneValid.isValid) {
      //showCustomSnackBar('invalid_phone_number'.tr);
    }else if (password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    }else if (password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    }else {
      /*authController.login(numberWithCountryCode, password).then((status) async {
        if (status.isSuccess) {
          if (authController.isActiveRememberMe) {
            authController.saveUserNumberAndPassword(phone, password, countryCode);
          } else {
            authController.clearUserNumberAndPassword();
          }
          await Get.find<ProfileController>().getProfile();
          Get.offAllNamed(RouteHelper.getInitialRoute());
        }else {
          showCustomSnackBar(status.message);
        }
      });*/
    }
  }
}
