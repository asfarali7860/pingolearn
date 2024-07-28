import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingolearn/utils/app_sizes.dart';
import 'package:pingolearn/utils/colors.dart';
import 'package:pingolearn/view/screen/home/homescreen_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  late HomeScreenViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _viewModel = context.read<HomeScreenViewModel>();
      _viewModel.fetchNewsData();
    });
  }
  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<HomeScreenViewModel>();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Text(
          "MyNews",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: kWhite,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: kWhite,
              ),
              gapW10,
              Text(
                "IN",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: kWhite,
                  fontWeight: FontWeight.bold
                ),
              ),
              gapW16
            ],
          )
        ],
      ),
      body: _viewModel.isLoading ?
      const Center(
        child: CircularProgressIndicator(),
      )
      : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top Headlines",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: kBlack,
                fontWeight: FontWeight.bold
              ),
            ),
            gapH16,
            Expanded(
              child: ListView.separated(
                itemCount: _viewModel.articleList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 6.0, top: 14, bottom: 14),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _viewModel.articleList[index].source?.name ?? '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: kBlack,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                gapH8,
                                Text(
                                   _viewModel.articleList[index].title ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: kBlack,
                                  ),
                                ),
                                gapH8,
                                Text(
                                  "10 min ago",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: kGrey,
                                    fontStyle: FontStyle.italic
                                  ),
                                ),
                              ],
                            ),
                          ),
                          gapW12,
                          Flexible(
                            flex: 1,
                            child: Image.asset('assets/images/news.png'),
                          )
                        ],
                      ),
                    )
                  );
                },
                separatorBuilder: (context, index) {
                  return gapH16;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}