import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labours_konnect/constants/assets_path.dart';
import 'package:labours_konnect/constants/colors.dart';
import 'package:labours_konnect/controller/auh_controller/auth_controller.dart';
import 'package:labours_konnect/controller/chat_controller/chat_controller.dart';
import 'package:labours_konnect/custom_widgets/custom_animation/custom_animation.dart';
import 'package:labours_konnect/custom_widgets/custom_text/custom_text.dart';
import 'package:labours_konnect/models/chat_model/chat_model.dart';


class ChatScreen extends StatefulWidget {
  final String chatId;
  final String userName;
  final String userId;
  const ChatScreen({super.key,required this.userName, required this.userId, required this.chatId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver{
  final ChatController chatController = Get.put(ChatController());
  final ScrollController _scrollController = ScrollController();

  String get senderId => chatController.currentUserId;
  // Get the receiver ID (service user's ID)
  String get receiverId => widget.userId;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      // App is in the background or closed
      chatController.updateTypingStatus(widget.chatId, chatController.currentUserId, false);
    }
  }
  @override
  void initState() {
    super.initState();
    final chatController = Get.find<ChatController>();
      chatController.markMessagesAsSeen(widget.userId);

    final chatId = chatController.generateChatId(chatController.currentUserId, widget.userId);
    chatController.resetUnreadCount(chatId);
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    chatController.updateTypingStatus(widget.chatId, chatController.currentUserId, false);
    super.dispose();
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
                SizedBox(width: 20..w),
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
                    SizedBox(width: 10..w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<Map<String, dynamic>>(
                          stream: chatController.Online(widget.userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                            }
                            if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            }
                            final isOnline = snapshot.data?['status'] == 'online';
                            return Row(
                              children: [
                                MainText(
                                  text: widget.userName,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: isOnline ? Colors.green : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        StreamBuilder<Map<String, dynamic>>(
                          stream: chatController.getTypingStatus(widget.chatId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return SizedBox();
                            }
                            if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            }
                            final typingStatus = snapshot.data ?? {};
                            final isTyping = typingStatus[widget.userId] == true;

                            return isTyping
                                ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              child: Text(
                                "typing...",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            )
                                : SizedBox();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25..h),
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
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
                      controller: _scrollController,
                      shrinkWrap: true,
                      reverse: false,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isSender = message.senderId == senderId;
                        //update seen
                        if (messages.isNotEmpty) {
                          chatController.markMessagesAsSeen(receiverId);
                        }

                        // Scroll to the bottom when new messages arrive
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (_scrollController.hasClients) {
                            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                          }
                        });
                        return Align(
                          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              IntrinsicWidth(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isSender ? AppColor.primaryColor : Colors.grey.withOpacity(.3),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                      bottomLeft: isSender ? Radius.circular(15) : Radius.circular(0),
                                      bottomRight: isSender ? Radius.circular(0) : Radius.circular(12),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message.message,
                                        style: TextStyle(
                                          color: isSender ? AppColor.white : AppColor.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            DateFormat('hh:mm a').format(
                                              message.timestamp ?? DateTime.now(),),
                                            style: TextStyle(
                                              color: isSender ? Colors.white70 : Colors.black54,
                                              fontSize: 8,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          // Display ticks based on message status
                                          if (isSender)
                                            Icon(
                                              message.status == 'seen'
                                                  ? Icons.done_all
                                                  : Icons.done,
                                              size: 12,
                                              color: message.status == 'seen'
                                                  ? Colors.blue
                                                  : Colors.grey,
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
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
                      onChanged: (text) {
                        // Update typing status when user starts typing
                        if (text.isNotEmpty) {
                          chatController.updateTypingStatus(widget.chatId, chatController.currentUserId, true);
                        } else {
                          chatController.updateTypingStatus(widget.chatId, chatController.currentUserId, false);
                        }
                      },
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
                    chatController.updateTypingStatus(widget.chatId, chatController.currentUserId, false);
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
