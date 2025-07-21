import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:the_library/models/user_model.dart';
import 'package:the_library/screens/auth_screen/signup_screen.dart';
import 'package:the_library/screens/home_screen/home_screen.dart';
import 'package:the_library/utils/application_controller.dart';
import 'package:the_library/utils/auth/database_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => SignupScreen(), transition: Transition.cupertino);
    } else {
      await ApplicationController.instance.updateUsers();
      ApplicationController.instance.loggedInUser = await DatabaseRepository
          .instance
          .getUserInfo(user.uid)
          .whenComplete(() async {
        await ApplicationController.instance.updateUserTransactions(user.uid);
      });
      Get.offAll(() => HomeScreen(), transition: Transition.cupertino);
    }
  }

  Future createUserWithEmailAndPassword(String email, String password,
      String firstName, String lastName, String phoneNo, bool isMale) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseUser.value != null) {
        final user = UserModel(
            uid: firebaseUser.value!.uid,
            email: email,
            phoneNo: phoneNo,
            firstName: firstName,
            lastName: lastName,
            isLibrarian: false,
            isMale: isMale);
        await DatabaseRepository.instance
            .createUser(user)
            .whenComplete(() async {
          await ApplicationController.instance.updateUsers();
          ApplicationController.instance.loggedInUser = await DatabaseRepository
              .instance
              .getUserInfo(user.uid)
              .whenComplete(() async {
            await ApplicationController.instance
                .updateUserTransactions(user.uid);
          });
          Get.offAll(() => HomeScreen(), transition: Transition.cupertino);
        });
      } else {
        Get.offAll(() => SignupScreen(), transition: Transition.cupertino);
        Get.snackbar("Unable to create user", "Please try again.");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Unable to sign up user", "${e.message}");
    } catch (_) {}
  }

  Future loginUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (firebaseUser.value != null) {
        await ApplicationController.instance.updateUsers();
        ApplicationController.instance.loggedInUser = await DatabaseRepository
            .instance
            .getUserInfo(firebaseUser.value!.uid)
            .whenComplete(() async {
          await ApplicationController.instance
              .updateUserTransactions(firebaseUser.value!.uid);
        });
        Get.offAll(() => HomeScreen(), transition: Transition.cupertino);
      } else {
        Get.offAll(() => SignupScreen(), transition: Transition.cupertino);
        Get.snackbar("Unable to login user", "Please try again.");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Unable to login user", "${e.message}");
    } catch (_) {}
  }

  Future logoutUser() async {
    try {
      final appController = Get.find<ApplicationController>();
      appController.loggedInUser = null;
      appController.userActiveTransactions.clear();
      appController.userAllTransactions.clear();
      appController.refresh();
      await _auth.signOut();
      if (firebaseUser.value == null) {
        Get.offAll(() => SignupScreen(), transition: Transition.cupertino);
        Get.snackbar("Success", "Successfully logged out user.");
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (_) {}
  }
}
