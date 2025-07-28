import 'package:flutter/material.dart';
import 'dart:async';
import 'package:iconsax/iconsax.dart';

class LiveChatPage extends StatefulWidget {
  const LiveChatPage({super.key});

  @override
  State<LiveChatPage> createState() => _LiveChatPageState();
}

class _LiveChatPageState extends State<LiveChatPage> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isTyping = false;

  final List<String> quickQuestions = [
    'How to apply for a loan?',
    'What are the interest rates?',
    'Can I make a partial payment?',
    'How to check my loan status?',
    'Where can I contact support?',
  ];

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      messages.add({
        "sender": "user",
        "text": message,
        "time": DateTime.now(),
      });
      isTyping = true;
    });

    _controller.clear();
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 1), () {
      final reply = _getAutoReply(message);
      setState(() {
        messages.add({
          "sender": "support",
          "text": reply,
          "time": DateTime.now(),
        });
        isTyping = false;
      });
      _scrollToBottom();
    });
  }

  String _getAutoReply(String message) {
    final lower = message.toLowerCase();
    if (lower.contains("loan") && lower.contains("apply")) {
      return "To apply for a loan, go to the Loan page and fill out the application form.";
    } else if (lower.contains("interest")) {
      return "Our interest rates vary from 3% to 5% depending on the loan type.";
    } else if (lower.contains("partial")) {
      return "Yes, we support partial loan payments!";
    } else if (lower.contains("status")) {
      return "You can check your loan status in the Loan Payment section.";
    } else if (lower.contains("contact")) {
      return "You can reach us through this chat or via email at support@gblcdc.coop.";
    } else {
      return "Thank you for your question! Our support will get back to you shortly.";
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isUser) {
    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isUser)
          const CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/images/logocoop.png'),
          ),
        if (!isUser) const SizedBox(width: 8),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isUser ? Colors.green.shade400 : Colors.grey.shade100,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isUser ? 18 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 18),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message["text"],
                  style: TextStyle(
                    color: isUser ? Colors.white : Colors.black87,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(message["time"]),
                  style: TextStyle(
                    color: isUser ? Colors.white70 : Colors.grey.shade500,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isUser) const SizedBox(width: 8),
        if (isUser)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/2x2.jpg'),
            ),
          ),
      ],
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    final hour = time.hour.toString().padLeft(2, '0');
    final min = time.minute.toString().padLeft(2, '0');
    return "$hour:$min";
  }

  Widget _buildTypingIndicator() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage('assets/images/logocoop.png'),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.green.shade100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 2),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 2),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickQuestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text("Quick Questions:",
              style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: quickQuestions.map((question) {
            return ActionChip(
              label: Text(question, style: const TextStyle(fontSize: 14)),
              backgroundColor: Colors.green.shade50,
              side: BorderSide(color: Colors.green.shade200),
              onPressed: () => _sendMessage(question),
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("GBLDC Live Chat Support",
            style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              controller: _scrollController,
              itemCount: messages.length + 2,
              itemBuilder: (context, index) {
                if (index < messages.length) {
                  final message = messages[index];
                  final isUser = message["sender"] == "user";
                  return _buildMessageBubble(message, isUser);
                } else if (index == messages.length && isTyping) {
                  return _buildTypingIndicator();
                } else if (index == messages.length + 1) {
                  return _buildQuickQuestions();
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.send,
                        onSubmitted: _sendMessage,
                        decoration: InputDecoration(
                          hintText: "Type your message...",
                          prefixIcon:
                              const Icon(Iconsax.message, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade400,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Iconsax.send_2,
                            color: Colors.white, size: 28),
                        onPressed: () => _sendMessage(_controller.text),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
