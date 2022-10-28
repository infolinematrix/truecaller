import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  final LocalAuthentication auth = LocalAuthentication();

  String authorized = 'Not Authorized';
  bool isAuthorised = false;
  bool isAuthenticating = false;
  bool canCheckBiometrics = false;
  List<BiometricType> availableBiometrics = [];

  //--Authenticate
  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      isAuthenticating = true;
      authorized = 'Authenticating';

      // try {
      //   canCheckBiometrics = await auth.canCheckBiometrics;
      // } catch (e) {
      //   print("error biome trics $e");
      // }
      // print("biometric is available: $canCheckBiometrics");

      // try {
      //   availableBiometrics = await auth.getAvailableBiometrics();
      // } catch (e) {
      //   print("error enumerate biometrics $e");
      // }

      // print("following biometrics are available");
      // if (availableBiometrics.isNotEmpty) {
      //   for (var ab in availableBiometrics) {
      //     print("\ttech: $ab");
      //   }
      // } else {
      //   print("no biometrics are available");
      // }

      try {
        await auth.isDeviceSupported().then((value) async {
          if (value == true) {
            authenticated = await auth
                .authenticate(
                    localizedReason: 'Touch your finger on the sensor to login',
                    authMessages: [],
                    options: const AuthenticationOptions(
                        biometricOnly: true, stickyAuth: true))
                .then((value) => value);

            return authenticated;
          }
        });
      } catch (e) {
        print("error using biometric auth: $e");
        isAuthenticating = false;
        authorized = "Error - ${e.toString()}";

        return;
      }

      isAuthenticating = false;
    } on PlatformException catch (e) {
      print(e);

      isAuthenticating = false;
      authorized = "Error - ${e.message}";

      return;
    }

    // authorized = authenticated ? 'Authorized' : 'Not Authorized';
    authorized = authenticated ? 'Authorized' : 'Not Authorized';

    isAuthorised = authenticated;
  }

  //-Can Authneticate
  void cancelAuthentication() async {
    await auth.stopAuthentication();
    isAuthenticating = false;
  }
}
