import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:labours_konnect/constants/utils.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/models/addservices_model/addservices_model.dart';
import 'package:labours_konnect/view/auth_screens/enable_location/enable_location.dart';
import 'package:labours_konnect/view/auth_screens/signin_screen/signin_screen.dart';
import 'package:labours_konnect/view/auth_screens/user_details/user_details.dart';
import 'package:labours_konnect/view/auth_screens/verify_account/verify_account.dart';
import 'package:labours_konnect/view/bottom_navigator/bottom_navigator.dart';
import 'package:labours_konnect/view/vendor/vendor_bottom_navigator/vendor_bottom_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {

  RxInt remainingTime = 119.obs;  // For countdown timer
  RxBool canResendCode = false.obs;
  Timer? _countdownTimer;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  //User Details
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cnPassword = TextEditingController();
  TextEditingController emailLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();

  Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    super.onInit();
    loadSwitchState();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  //Email show text in verify screen
  String maskEmail(String email) {
    if (email.length <= 14) {
      return email;
    }
    String start = email.substring(0, 3); // First 3 characters
    String end = email.substring(email.length - 10); // Last 11 characters
    return '$start****$end';
  }


  void startCountdown() {
    remainingTime.value = 119;  // Reset to 60 seconds
    canResendCode.value = false;

    _countdownTimer?.cancel();  // Cancel previous timer if any
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        canResendCode.value = true;  // Enable "Resend Code" after 60 seconds
        _countdownTimer?.cancel();
      }
    });
  }

  void stopCountdown() {
    _countdownTimer?.cancel();
  }

  //Create account and Send Email Otp

  Future<void> EmailController() async {
    String emailPattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = RegExp(emailPattern);

    if (emailController.text.isEmpty) {
      showSnackBar(title: 'Please Enter Your Email');
    }
    else if (!regExp.hasMatch(emailController.text)) {
      showSnackBar(title: 'Please Enter a Valid Email Address');
    }
    else {
      EmailOTP.config(
        appEmail: 'labourskonnect@gmail.com',
        appName: 'Labours Konnect',
        emailTheme: EmailTheme.v5,
        otpType: OTPType.numeric,
        otpLength: 4,
        expiry: 120000,
      );
      isLoading = true;
      update();

      bool isOTPSent = await EmailOTP.sendOTP(email: emailController.text);

      isLoading = false;
      update();

      if (isOTPSent) {
        SuccessSnackBar('Success','OTP has been sent to your Email',);
        startCountdown();
        Get.to(VerifyAccount());
      } else {
        ErrorSnackBar('Error','Failed to send OTP. Please try again.',);
      }
    }
  }

  //Otp Controller

  Future<void> OtpController() async {
    isLoading = true;
    update();
    await Future.delayed(Duration(seconds: 3));
    bool checkOTP = await EmailOTP.verifyOTP(otp: otpController.text);
    isLoading = false;
    update();
    if(checkOTP){
      stopCountdown();
      SuccessSnackBar('Success','Your account is Successfully Created.');
      Get.to(UserDetails());
      otpController.clear();
    }
    else{
      ErrorSnackBar('Error', 'Please Enter Correct OTP');
    }
  }
  Future<void> resendOTP() async {
    if (canResendCode.value) {
      otpController.clear();
      await EmailController();  // Resend OTP email
      canResendCode.value = false;  // Disable resend button after resending
    }
  }

  //User Details

  Future<void> userDetails()async {
    if (firstName.text.isEmpty) {
      showSnackBar(title: 'Please Enter Your First Name');
    }
    else if (lastName.text.isEmpty) {
      showSnackBar(title: 'Please Enter Your Last Name');
    }
    else if (password.text.isEmpty) {
      showSnackBar(title: 'Please Enter a Password');
    }
    else if (cnPassword.text.isEmpty) {
      showSnackBar(title: 'Please Enter a Confirm Password');
    }
    else if (password.text != cnPassword.text) {
      showSnackBar(title: 'Passwords do not match');
    }
    else {
      try {
        isLoading = true;
        update();

        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: password.text.trim(),
        );
        isLoading = false;
        update();
        SuccessSnackBar('Success', 'User registered successfully');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('enableLocation', true);
        Get.off(EnableLocation());

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'First Name': firstName.text.trim(),
          'Last Name': lastName.text.trim(),
          'Email': emailController.text.trim(),

        });
        firstName.clear();
        lastName.clear();
        password.clear();
        cnPassword.clear();
        emailController.clear();
      } on FirebaseAuthException catch (e) {
        ErrorSnackBar('Error', e.message ?? 'An error occurred');
        isLoading = false;
        update();
      }
    }
  }


  Future<void> signInWithEmailPassword() async {
    String emailPattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = RegExp(emailPattern);

    if (emailLogin.text.isEmpty && passwordLogin.text.isEmpty) {
      showSnackBar(title: 'Email and Password are required');
    }
    else if (emailLogin.text.isEmpty) {
      showSnackBar(title: 'Please Enter Your Email');
    }
    else if (!regExp.hasMatch(emailLogin.text)) {
      showSnackBar(title: 'Please Enter a Valid Email Address');
    }
    else if (passwordLogin.text.isEmpty){
      showSnackBar(title: 'Please Enter a Password');
    }
    else{
      try {
        isLoading = true;
        update();

        await _auth.signInWithEmailAndPassword(
          email: emailLogin.text.trim(),
          password: passwordLogin.text.trim(),
        );

        await fetchAndStoreUserData();
        isLoading = false;
        update();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        SuccessSnackBar('Success', 'Logged in successfully');
        Get.offAll(BottomNavigator());
        emailLogin.clear();
        passwordLogin.clear();
      } on FirebaseAuthException catch (e) {
        ErrorSnackBar('Error', e.message ?? 'Login failed');
        isLoading = false;
        update();
      }
    }
  }

  // Function to fetch and store user data
  var email = ''.obs;
  var fullName = ''.obs;
  Future<void> fetchAndStoreUserData() async {
    try {

      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          email.value = userDoc['Email'];
          fullName.value = '${userDoc['First Name']} ${userDoc['Last Name']}';
        } else {
          ErrorSnackBar('Error', 'User data not found');
        }
      } else {
        ErrorSnackBar('Error', 'User not logged in');
      }
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to fetch user data: $e');
    }
  }

  //Update User Name
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  Future<void> updateUserName() async {
    try {
      if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
        ErrorSnackBar('Error', 'First Name and Last Name cannot be empty');
        return;
      }

      User? user = _auth.currentUser;
      if (user != null) {
        isLoading = true;
        update();

        await _firestore.collection('users').doc(user.uid).update({
          'First Name': firstNameController.text,
          'Last Name': lastNameController.text,
        });

        await user.updateProfile(
            displayName: '${firstNameController.text} ${lastNameController.text}',
        );
        fullName.value = '${firstNameController.text} ${lastNameController.text}';
        isLoading = false;
        update();

        SuccessSnackBar('Success', 'Name updated successfully');
      } else {
        ErrorSnackBar('Error', 'No user is currently logged in');
      }
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to update name: $e');
      isLoading = false;
      update();
    }
  }

  //Change Password
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> changePassword() async {
    if (newPasswordController.text.isEmpty) {
      ErrorSnackBar('Error', 'Please enter your new password');
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      ErrorSnackBar('Error', 'Please confirm your new password');
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      ErrorSnackBar('Error', 'Passwords do not match');
      return;
    }

    try {
      User? user = _auth.currentUser;
      if (user != null) {
        isLoading = true;
        update();
        await user.updatePassword(newPasswordController.text);

        isLoading = false;
        update();

        SuccessSnackBar('Success', 'Password updated successfully');
        newPasswordController.clear();
        confirmPasswordController.clear();

      } else {
        ErrorSnackBar('Error', 'No user is currently logged in');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        ErrorSnackBar('Error', 'Please re-login to update your password.');
      } else {
        ErrorSnackBar('Error', 'Failed to update password: ${e.message}');
      }
      isLoading = false;
      update();
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to update password: $e');
      isLoading = false;
      update();
    }
  }


  //SignIn with Google

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('google').doc(user.uid).set({
          'Id': user.uid,
          'Name': user.displayName,
          'Email': user.email,
          'PhotoURL': user.photoURL,
        });
      }

      return user;
    } catch (e) {
      print('Error during sign-in: $e');
      return null;
    }
  }




  //SignIn with Facebook

  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status != LoginStatus.success) {
        return null;
      }

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.tokenString);

      final UserCredential userCredential = await _auth.signInWithCredential(facebookAuthCredential);
      final User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('Facebook ').doc(user.uid).set({
          'Id': user.uid,
          'Name': user.displayName,
          'Email': user.email,
          'PhotoURL': user.photoURL,
        });
      }

      return user;
    } catch (e) {
      print('Error during sign-in: $e');
      return null;
    }
  }

  Future<bool> checkLoginStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      User? user = FirebaseAuth.instance.currentUser;

      if (isLoggedIn && user != null) {
        await fetchAndStoreUserData();
        update();
        return true; // User logged in hai
      } else {
        return false; // User logged in nahi hai
      }
    } catch (e) {
      print("Error in checkLoginStatus: $e");
      return false; // Error aane par bhi false return karein
    }
  }


  void resetUserData() {
    email.value = '';
    fullName.value = '';
  }


  //Vendor & Customer
  var isProfessionalMode = false.obs;


  Future<void> saveSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_professional_mode', value);
    isProfessionalMode.value = value;
  }

  Future<void> loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    isProfessionalMode.value = prefs.getBool('is_professional_mode') ?? false;
  }
  Future<void> resetToggleState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_professional_mode', false); // Toggle state reset karein
    isProfessionalMode.value = false; // Observable variable reset karein
  }

  // Toggle the switch and handle navigation
  void toggleSwitch(bool value, BuildContext context) {
    isProfessionalMode.value = value;
    saveSwitchState(value);
    if (value) {
      Future.delayed(Duration(milliseconds: 300), () {
        navigateToNextScreen(context, VendorBottomNavigator());
      }
      );
    } else {
      Future.delayed(Duration(milliseconds: 300), () {
        navigateToNextScreen(context, BottomNavigator());
      }
      );
    }
  }



  Future<void> SignOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      await resetToggleState();
      await _auth.signOut();
      await _googleSignIn.signOut();
      //await FacebookAuth.instance.logOut();
      resetUserData();
      Get.offAll(SignInScreen());
      SuccessSnackBar('Success', 'Logged out successfully');
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to log out: $e');
    }
  }

  //Delete Account
  Future<void> deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();
        await user.delete();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('isLoggedIn');

        Get.offAll(SignInScreen());
        SuccessSnackBar('Success', 'Account deleted successfully');
      } else {
        ErrorSnackBar('Error', 'No user is currently logged in');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        ErrorSnackBar('Error', 'Please re-login to delete your account.');
      } else {
        ErrorSnackBar('Error', 'Failed to delete account: ${e.message}');
      }
    } catch (e) {
      ErrorSnackBar('Error', 'Failed to delete account: $e');
    }
  }



  //selected category
  RxString selectedCategory = 'Choose Category'.obs;
  void updateSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  //Add Services
  final TextEditingController serviceTitle = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  late  TextEditingController locationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  RxString imagePath = ''.obs;

  Future<void> addService() async {
    if (serviceTitle.text.isEmpty) {
      showSnackBar(title: 'Please select an image');
    }else if (selectedCategory.value == 'Choose Category') {
      showSnackBar(title: 'Please Enter Category');
    } else if (cityController.text.isEmpty) {
      showSnackBar(title: 'Please Enter City');
    } else if (locationController.text.isEmpty) {
      showSnackBar(title: 'Please Enter Location');
    } else if (experienceController.text.isEmpty) {
      showSnackBar(title: 'Please Enter Experience');
    } else if (priceController.text.isEmpty) {
      showSnackBar(title: 'Please Enter Price');
    } else if (descriptionController.text.isEmpty) {
      showSnackBar(title: 'Please Enter Description');
    } else {
      try {
        isLoading = true;
        update();

        final serviceData = AddServicesModel(
            userId: _auth.currentUser?.uid ?? '',
            imageUrl: "",
            serviceTitle: serviceTitle.text.trim(),
            category: selectedCategory.value,
            city: cityController.text.trim(),
            location: locationController.text.trim(),
            experience: experienceController.text.trim(),
            price: priceController.text.trim(),
            description: descriptionController.text.trim(),
            timestamp: DateTime.now(),
        );
        await _firestore.collection('services').add(serviceData.toMap());
        isLoading = false;
        update();

        SuccessSnackBar('Success', 'Service added successfully');

        serviceTitle.clear();
        selectedCategory.value = 'Choose Category';
        cityController.clear();
        locationController.clear();
        experienceController.clear();
        priceController.clear();
        descriptionController.clear();
      } catch (e) {
        ErrorSnackBar('Error', 'Failed to add service: $e');
        isLoading = false;
        update();
      }
    }
  }

  //Fetch AddServices Data
  Future<List<AddServicesModel>> fetchServicesForUser() async {
    try {

      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }
      final querySnapshot = await _firestore
          .collection('services')
          .where('userId', isEqualTo: user.uid)
          .get();

      return querySnapshot.docs.map((doc) {
        return AddServicesModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      ErrorSnackBar('Error','Error fetching services for user: $e');
      rethrow;
    }
  }

  //Fetch Services by Category

  Future<List<AddServicesModel>> fetchServicesByCategory(String categoryValue) async {
    try {
      //print('Fetching services for category: $categoryValue');
      final querySnapshot = await _firestore.collection('services')
          .where('category', isEqualTo: categoryValue).get();
      print('Number of services found: ${querySnapshot.docs.length}');
      return querySnapshot.docs.map((doc) {
        print('Service Data: ${doc.data()}');
        return AddServicesModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      print('Error fetching services: $e');
      ErrorSnackBar('Error', 'Failed to fetch services: $e');
      rethrow;
    }
  }


// Upload Image to Firebase Storage
  Future<String> _uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = FirebaseStorage.instance.ref().child('service_images/$fileName');
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }
}