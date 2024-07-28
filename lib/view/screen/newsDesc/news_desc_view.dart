import 'package:flutter/material.dart';
import 'package:pingolearn/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  final String newsURL;
  final String title;
  const NewsWebView({super.key, required this.newsURL, required this.title});

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late WebViewController controller;
  bool isLoading = true; // Add a state variable to manage the loading state

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   // Prevent navigation to any other URL
          //   if (request.url != widget.newsURL) {
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(Uri.parse(widget.newsURL));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.only(
                left: 7,
                top: 8,
                bottom: 10,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFF3F5F6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: primaryColor,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading) // Show the CircularProgressIndicator if the page is loading
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
