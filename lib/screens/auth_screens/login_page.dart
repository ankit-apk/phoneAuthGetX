import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_auth_getx/controllers/login_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';


class PhoneScreen extends StatelessWidget {
  PhoneScreen({Key? key}) : super(key: key);

  final LoginController _loginController =
  Get.put(LoginController(), permanent: true);

  final RxString phoneNumber = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Container(
              height: 100.h,
              width: 100.w,

            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 40.w,
              height: 20.h,

            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              width: 100.w,
              height: 70.h,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 100.0,
                  left: 12,
                  right: 12,
                ),
                child: Obx(
                      () => Column(
                    children: [
                      _loginController.isOtpSent.value == false
                          ? Column(
                        children: [
                          TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (phone) {
                              phoneNumber.value = phone;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.flag_outlined),
                              prefixText: '(+91)',
                              prefixStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .iconTheme
                                        .color!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .iconTheme
                                        .color!),
                              ),
                              labelText: 'Enter Mobile Number',
                              labelStyle: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                              hintText: '98000 0000',
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Container(
                              height: 6.h,
                              width: 40.w,
                              child: ElevatedButton(
                                onPressed: () {
                                  _loginController.phoneLogin(
                                    phoneNumber.toString(),
                                  );
                                  _loginController.isLoading(true);

                                  // Get.to(
                                  //   OtpScreen(),
                                  // );
                                },
                                child: _loginController.isLoading.value ==
                                    false
                                    ? Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.phone),
                                    Text(
                                      'Send OTP',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                                    : CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                    Color(0xfffdc515),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(30, 50),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                          : Column(
                        children: [
                          Text(
                            'ENTER OTP',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          PinCodeTextField(
                            cursorColor: Colors.grey,
                            pinTheme: PinTheme(
                              inactiveFillColor: Colors.grey,
                              activeColor: Colors.grey,
                              activeFillColor: Colors.grey,
                              disabledColor: Colors.grey,
                              inactiveColor: Colors.grey,
                              selectedColor: Colors.grey,
                              errorBorderColor: Colors.grey,
                              selectedFillColor: Colors.grey,
                            ),
                            appContext: (context),
                            length: 6,
                            onChanged: (otp) {
                              _loginController.smsCode.value = otp;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Container(
                              height: 6.h,
                              width: 40.w,
                              child: ElevatedButton(
                                onPressed: () {
                                  _loginController.isverifyingOtp(true);
                                  _loginController.verifyOtp();
                                },
                                child:_loginController.isverifyingOtp.value==false? Text(
                                  'Verify OTP',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ):CircularProgressIndicator(color: Colors.white,),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                    Color(0xfffdc515),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(30, 50),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
