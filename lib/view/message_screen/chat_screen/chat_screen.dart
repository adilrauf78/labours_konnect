import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/controller/chat_controller/chat_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/chat_model/chat_model.dart';


class ChatScreen extends StatefulWidget {
  final String userName;
  final String userId;
  const ChatScreen({super.key,required this.userName, required this.userId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());
  String get senderId => chatController.currentUserId;

  // Get the receiver ID (service user's ID)
  String get receiverId => widget.userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 55..h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    navigateBackWithAnimation(context);
                  },
                  child: Icon(Icons.arrow_back_ios,
                    color: AppColor.black,
                    size: 18,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 50..w,
                      height: 50..h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.white
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50..r),
                        child: Image.asset('${imagePath}image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 15..w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainText(
                          text: widget.userName,
                          fontWeight: FontWeight.w500,
                        ),
                        SubText(
                          text: 'Typing..',
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 20..w),
              ],
            ),
            SizedBox(height: 25..h),
            Expanded(
              child: StreamBuilder<List<ChatModel>>(
                stream: chatController.getMessages(senderId, receiverId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final messages = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSender = message.senderId == senderId;
                      return Align(
                        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isSender ? AppColor.primaryColor : Colors.grey,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            message.message,
                            style: TextStyle(
                              color: isSender ? AppColor.white : AppColor.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height:20),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 45
                      ..h,
                    child: TextField(
                      controller: chatController.messageController,
                      cursorColor: AppColor.black.withOpacity(.5),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10
                                ..r),
                              borderSide: BorderSide(
                                color: Color(0xFFEEEEEE),
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10
                                ..r),
                              borderSide: BorderSide(
                                color: Color(0xFFEEEEEE),
                              )
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          fillColor: AppColor.white,
                          filled: true,
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(
                            color: AppColor.black.withOpacity(.3),
                            fontSize: 15
                              ..sp,
                            fontWeight: FontWeight.w400,
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10..w),
                InkWell(
                  onTap: (){
                    chatController.sendMessage(receiverId: receiverId, message: chatController.messageController.text.trim());
                  },
                  child: Container(
                    width: 40..w,
                    height: 40..h,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Icon(Icons.send, color: AppColor.white,size: 20,)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20..h),
          ],
        ),
        ),
    );
  }
}
