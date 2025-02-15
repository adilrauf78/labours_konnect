import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/chat_controller/chat_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/chat_model/chat_model.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
            Expanded(
              child: StreamBuilder<List<ChatModel>>(
                stream: chatController.getMessages(senderId, receiverId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ListTile(
                        title: Text(message.message),
                        subtitle: Text(message.timestamp.toString()),
                      );
                    },
                  );
                },
              ),
            ),
            TextField(
              onSubmitted: (message) {
                final chat = ChatModel(
                  senderId: senderId,
                  receiverId: receiverId,
                  message: message,
                  timestamp: DateTime.now(),
                );
                chatController.sendMessage(chat);
              },
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ],
        ),
        ),
    );
  }
}
