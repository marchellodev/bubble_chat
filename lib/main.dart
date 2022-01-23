
import 'package:bubble_chat/chat.dart';
import 'package:bubble_chat/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bubble Chat',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // side: const BorderSide(width: 2, color: Colors.green),
                ),
                onPressed: !loading
                    ? () async {
                        setState(() {
                          loading = true;
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const ChatPage('2213')));
                        return;
                        showLoadingDialog(context);

                        try {
                          final res =
                              await http.get(Uri.parse('https://hack22.code.edu.eu.org/api/v1/rooms'));
                          if (res.statusCode == 200) {
                            // final id = jsonDecode(res.body)['id'] as String;
                            const id = '123';
                            Navigator.pop(context);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const ChatPage(id)));
                          } else {
                            Navigator.pop(context);
                            showErrorDialog(context);
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          showErrorDialog(context);
                        }
                        setState(() {
                          loading = false;
                        });
                      }
                    : null,
                child: SizedBox(
                    height: 90,
                    width: 300,
                    child: Center(
                      child: Text(
                        '🚀 Start a conversation',
                        style: GoogleFonts.montserrat(
                            fontSize: 16, color: Colors.black),
                      ),
                    ))),
            const SizedBox(height: 12),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // side: const BorderSide(width: 2, color: Colors.green),
                ),
                onPressed: null,
                child: SizedBox(
                    height: 60,
                    width: 300,
                    child: Center(
                      child: Text(
                        '📜 History (soon)',
                        style: GoogleFonts.montserrat(fontSize: 16),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
