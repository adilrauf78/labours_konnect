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
  void initState() {
    super.initState();
    final chatController = Get.find<ChatController>();
    // Mark user as online when the app is opened
    chatController.updateUserStatus(chatController.currentUserId, true);

  }

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainText(
                  text: 'Messages',
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: 25..h),
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
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
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      final timestamp = (user['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now();
                      final timeAgo = DateFormat('hh:mm a').format(timestamp);
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ChatScreen(
                            userId: user['userId'],
                            userName: user['userName'],
                            chatId: chatController.generateChatId(chatController.currentUserId, user['userId']),
                          ));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                color: AppColor.black.withOpacity(.1),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  StreamBuilder<Map<String, dynamic>>(
                                    stream: chatController.Online(user['userId']),
                                    builder: (context, statusSnapshot) {
                                      if (statusSnapshot.connectionState == ConnectionState.waiting) {
                                      }
                                      if (statusSnapshot.hasError) {
                                        return Text("Error: ${statusSnapshot.error}");
                                      }
                                      final isOnline = statusSnapshot.data?['status'] == 'online';
                                      return Stack(
                                        children: [
                                          Container(
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColor.white,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(50.r),
                                              child: user['profilePicture'].isNotEmpty
                                                  ? Image.network(
                                                user['profilePicture'],
                                                fit: BoxFit.cover,
                                              )
                                                  : Image.asset(
                                                '${imagePath}image.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          if (isOnline)
                                            Positioned(
                                              right: 0,
                                              bottom: 0,
                                              child: Container(
                                                width: 12.w,
                                                height: 12.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: AppColor.white,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(width: 15..w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MainText(
                                        text: user['userName'],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16..sp,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*.4,
                                        child: Text(
                                           user['lastMessage'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColor.k0xFF818080,
                                            fontSize: 14..sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SubText(
                                    text: timeAgo, // Display formatted timestamp
                                    fontWeight: FontWeight.w400,
                                  ),
                                  if ((user['unreadCount'] ?? 0) > 0) // Handle null values
                                    Container(
                                      width: 20..w,
                                      height: 20..h,
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text12(
                                          text: (user['unreadCount'] ?? 0) > 9 ? '9+' : (user['unreadCount'] ?? 0).toString(), // Handle null values
                                          color: AppColor.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
