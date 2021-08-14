import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:phone_auth_getx/screens/home_screen.dart';

class LoginController extends GetxController {
  RxBool isOtpSent = false.obs;
  RxString veriCode = ''.obs;
  RxString smsCode = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isverifyingOtp = false.obs;

  FirebaseAuth _auth = FirebaseAuth.instance;

  phoneLogin(String phoneNumber) {
    _auth.verifyPhoneNumber(
      phoneNumber: '+91 $phoneNumber',
      verificationCompleted: (PhoneAuthCredential authCredential) {
        print("verification completed ${authCredential.smsCode}");
      },
      verificationFailed: (FirebaseAuthException exception) {
        Get.snackbar('Failed', exception.message!);
      },
      codeSent: (String verificationId, int? resendToken) async {
        Get.snackbar('Code sent', 'Code sent');
        isOtpSent(true);
        veriCode('$verificationId');
      },
      codeAutoRetrievalTimeout: (String timeout) {
        return null;
      },
    );
  }

  verifyOtp() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: veriCode.value,
          smsCode: smsCode.value,
        ),
      )
          .then(
        (value) async {
          if (value.user != null) {
            isOtpSent(false);
            isLoading(false);
            isverifyingOtp(false);
            Get.offAll(
              HomePage(),
            );
          }
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}
