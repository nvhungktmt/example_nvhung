import 'package:chat_gpt_app/chart_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:async';
import 'chat_provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final StreamController<String> _streamController = StreamController<String>();
  final Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat GPT')),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                return ListView.builder(
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messages[index];
                    return ListTile(
                      title: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: message.isUser ? Colors.blue[100] : Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MarkdownBody(data: message.message),
                      ),
                      subtitle: message.isUser ? Text('User', textAlign: TextAlign.right) : Text('GPT', textAlign: TextAlign.left),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final message = ChatMessage(
                      message: _controller.text,
                      isUser: true,
                    );
                    context.read<ChatProvider>().addMessage(message);

                    // Gửi yêu cầu tới API GPT
                    _sendToGpt(_controller.text, context);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
          StreamBuilder<String>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final message = ChatMessage(
                  message: snapshot.data!,
                  isUser: false,
                );
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  context.read<ChatProvider>().addMessage(message);
                });
                return Container(); // Trả về một container trống
              }
              return Container(); // Trả về một container trống khi không có dữ liệu
            },
          ),
        ],
      ),
    );
  }

  void _sendToGpt(String text, BuildContext context) async {
    final options = Options(
      headers: {
        'Content-Type': 'application/text',
        'Authorization':
            'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik1UaEVOVUpHTkVNMVFURTRNMEZCTWpkQ05UZzVNRFUxUlRVd1FVSkRNRU13UmtGRVFrRXpSZyJ9.eyJwd2RfYXV0aF90aW1lIjoxNzIxOTIxODA0NDM3LCJzZXNzaW9uX2lkIjoiXzJfOHBTdk05c1FrQlZDczE2cWhQdEp6eVdUTDNKQ3QiLCJodHRwczovL2FwaS5vcGVuYWkuY29tL3Byb2ZpbGUiOnsiZW1haWwiOiJudmh1bmd0ZXN0MUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZX0sImh0dHBzOi8vYXBpLm9wZW5haS5jb20vYXV0aCI6eyJwb2lkIjoib3JnLWZraGY5T2tMeHV3S2NXWUdueU9PN0NJRSIsInVzZXJfaWQiOiJ1c2VyLW9TNkM3cHF0SzZmMUIyU1RJb1BCemttRCJ9LCJpc3MiOiJodHRwczovL2F1dGgwLm9wZW5haS5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMDA1NjA2MzY3MzExMzIwNTcyOTQiLCJhdWQiOlsiaHR0cHM6Ly9hcGkub3BlbmFpLmNvbS92MSIsImh0dHBzOi8vb3BlbmFpLm9wZW5haS5hdXRoMGFwcC5jb20vdXNlcmluZm8iXSwiaWF0IjoxNzIxOTIxODA3LCJleHAiOjE3MjI3ODU4MDcsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwgbW9kZWwucmVhZCBtb2RlbC5yZXF1ZXN0IG9yZ2FuaXphdGlvbi5yZWFkIG9yZ2FuaXphdGlvbi53cml0ZSBvZmZsaW5lX2FjY2VzcyIsImF6cCI6IlRkSkljYmUxNldvVEh0Tjk1bnl5d2g1RTR5T282SXRHIn0.2wGCYC-daF1NXiW6STuTg2RzHPIcGpsLx3IilKNwfpyvxh6iD1-NUxBVIEPgqAaTNW6igljXoB44KBUmoGAT9GMftW6Uw2ctiIRASuK8yonITvrgLKfJT_QcpXh1HFPWvf76AeVumW2fIPQV6T7Vqidb514ms2zETOm-1_DqDWVEuYYgq23yi8NyguDM7fSLPGrmPnfSDhMWzFaghhj_BBFTXZx0N-wsmQftmkNqSspgn_ufOJw6ZA0K4e0gp5VYktTAwfHWBOWjboJl_nT0c8hC_C1P90F_gEiiAuDv_ZDkdviDagvdrYXm3WKRq9fml_AEXIoROar6SVDy0u0slg'
      },
      responseType: ResponseType.stream,
    );

    try {
      final response = await _dio.post(
        'https://chatgpt.com/backend-api/conversation',
        options: options,
        data: {
          "action": "variant",
          "messages": [
            {
              "id": "aaa205ec-48d4-4493-b18d-8b923404448e",
              "author": {"role": "user"},
              "content": {
                "content_type": "text",
                "parts": ["sử dụng dio"]
              },
              "metadata": {}
            }
          ],
          "conversation_id": "7f490460-0040-4721-ac84-e0d0370960dc",
          "parent_message_id": "ee34ff7f-24db-4484-ad79-31e695e76ab2",
          "model": "gpt-4o",
          "timezone_offset_min": -420,
          "variant_purpose": "comparison_implicit",
          "history_and_training_disabled": false,
          "conversation_mode": {"kind": "primary_assistant"},
          "force_paragen": false,
          "force_paragen_model_slug": "",
          "force_nulligen": false,
          "force_rate_limit": false,
          "reset_rate_limits": false,
          "websocket_request_id": "5f4b1e95-a51b-4bd2-a074-5d1d9ab22422",
          "force_use_sse": true,
          "conversation_origin": null
        },
      );

      response.data.stream.transform(utf8.decoder).listen((data) {
        final jsonResponse = jsonDecode(data);
        if (jsonResponse['choices'] != null && jsonResponse['choices'].isNotEmpty) {
          final gptMessage = jsonResponse['choices'][0]['message']['content'];
          _streamController.add(gptMessage);
        }
      });
    } catch (e) {
      print('Failed to connect to the API: $e');
    }
  }
}
