import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import '../../../app/di.dart';
import '../../../app/resources/routes_manger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../on_boarding_view_model/on_boarding_view_model_getx.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  PViewState createState() => PViewState();
}

class PViewState extends State<OnBoardingView> {
  final boardController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<OnBoardingController>(
      builder: (data) {
        return _getContent(data.pageViewData);
      },
    );
  }

  Widget _getContent(List pageViewData) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Expanded(
                  child: PageView(
                    allowImplicitScrolling: true,
                    controller: boardController,
                    children: pageViewData
                        .map((item) => Center(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.ap20),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          item.title,
                                          style: context.textTheme.displayLarge,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SvgPicture.asset(
                                          item.urlImage,
                                          height: .45.sh,
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .90,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            item.description,
                                            style:
                                                context.textTheme.titleLarge!,
                                            textAlign: TextAlign.center,
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: const Alignment(0, .95),
            child: RSizedBox(
              width: MediaQuery.of(context).size.width / 2.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RPadding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: buildIndicator(
                        boardController: boardController,
                        count: pageViewData.length),
                  ),
                  RPadding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            initLoginModel();
                            Get.toNamed(Routes.loginRoute,
                                arguments: {'canBack': true});
                          },
                          child: Text(
                            AppStrings.login,
                            style: context.textTheme.labelMedium,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 1,
                          height: AppSpacing.ap12,
                          color: Colors.black,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            initRegisterModel();

                            Get.toNamed(Routes.registerRoute);
                          },
                          child: Text(
                            AppStrings.registerTitle,
                            style: context.textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await initHomeModel();
                      Get.offAllNamed(Routes.homeRoute);
                    },
                    child: Text(
                      AppStrings.skip,
                      style: context.textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SmoothPageIndicator buildIndicator(
      {required PageController boardController,
      required int count,
      dynamic indicatorEffect}) {
    return SmoothPageIndicator(
      controller: boardController,
      effect: indicatorEffect ??
          WormEffect(
            dotColor: Colors.grey,
            activeDotColor: ColorManager.primaryColor,
            dotHeight: AppSpacing.ap12.w,
            dotWidth: AppSpacing.ap12.w,
            spacing: AppSpacing.ap12.r,
          ),
      count: count,
    );
  }
}
