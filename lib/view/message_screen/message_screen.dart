import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/chat_controller/chat_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/view/message_screen/chat_screen/chat_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final ChatController chatController = Get.put(ChatController());
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
                MainText(
                  text: 'Messages',
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 20..w),
              ],
            ),
            SizedBox(height: 25..h),
        StreamBuilder<List<Map<String, dynamic>>>(
          stream: chatController.getChattedUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final users = snapshot.data ?? [];

            return ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to the chat screen
                    Get.to(() => ChatScreen(userId: user['chatId'], userName: '',));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                          bottom: BorderSide(
                            color: AppColor.black.withOpacity(.1),
                          )
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                  text: user['userId'],
                                  fontSize: 16..sp,
                                ),
                                SubText(
                                  text: user['lastMessage'],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SubText(
                              text: '23 min',
                              fontWeight: FontWeight.w700,
                            ),
                            Container(
                              width: 20..w,
                              height: 20..h,
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text12(
                                  text: '1',
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        )
          ],
        ),
      ),
    );
  }
}
