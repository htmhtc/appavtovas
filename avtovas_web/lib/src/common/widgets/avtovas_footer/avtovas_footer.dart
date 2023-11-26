// ignore_for_file: implementation_imports

import 'package:avtovas_web/src/common/constants/app_dimensions.dart';
import 'package:avtovas_web/src/common/navigation/app_router.dart';
import 'package:avtovas_web/src/common/navigation/configurations.dart';
import 'package:common/avtovas_common.dart';
import 'package:common/avtovas_navigation.dart';
import 'package:common/src/utils/constants/images_assets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AvtovasFooter extends StatelessWidget {
  final bool smartLayout;

  const AvtovasFooter({
    required this.smartLayout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!smartLayout)
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.extraLarge,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _FooterHelp(),
                _FooterDocuments(),
                _FooterMobileApp(),
              ],
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.large,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const _FooterHelp(),
                const _FooterDocuments(),
                const _FooterMobileApp(),
              ].insertBetween(
                const SizedBox(
                  height: AppDimensions.large,
                ),
              ),
            ),
          ),
        _CopyrightCookiesWidget(
          isSmart: smartLayout,
        ),
      ].insertBetween(
        const SizedBox(height: AppDimensions.extraLarge),
      ),
    );
  }
}

class _FooterHelp extends StatelessWidget {
  const _FooterHelp();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _FooterTitle(title: context.locale.help),
        // TODO(dev): Add localization
        GestureDetector(
          onTap: () {
            AppRouter.appRouter.navigateTo(
              CustomRoute(
                RouteType.navigateTo,
                avtovasContactsConfig(),
              ),
            );
          },
          child: const _FooterSubtitle(
            subtitle: 'Позвонить или задать вопрос',
          ),
        ),
        GestureDetector(
          onTap: () {
            AppRouter.appRouter.navigateTo(
              CustomRoute(
                RouteType.navigateTo,
                referenceInfoConfig(),
              ),
            );
          },
          child: _FooterSubtitle(subtitle: context.locale.directoryInfo),
        ),
        GestureDetector(
          onTap: () {
            AppRouter.appRouter.navigateTo(
              CustomRoute(
                RouteType.navigateTo,
                busStationContactsConfig(),
              ),
            );
          },
          child: _FooterSubtitle(subtitle: context.locale.contacts),
        ),
      ].insertBetween(
        const SizedBox(height: AppDimensions.medium),
      ),
    );
  }
}

class _FooterDocuments extends StatelessWidget {
  const _FooterDocuments();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // TODO(dev): Add localization
        const _FooterTitle(title: 'Документы'),
        GestureDetector(
          onTap: () {
            AppRouter.appRouter.navigateTo(
              CustomRoute(
                RouteType.navigateTo,
                privacyPolicyConfig(),
              ),
            );
          },
          child: _FooterSubtitle(subtitle: context.locale.privacyPolicy),
        ),
        GestureDetector(
          onTap: () {
            AppRouter.appRouter.navigateTo(
              CustomRoute(
                RouteType.navigateTo,
                consentProcessingConfig(),
              ),
            );
          },
          child: _FooterSubtitle(
            subtitle: context.locale.personalDataProcessingText
                .capitalizeFirstLetter(),
          ),
        ),
        GestureDetector(
          onTap: () {
            AppRouter.appRouter.navigateTo(
              CustomRoute(
                RouteType.navigateTo,
                termsOfUseConfig(),
              ),
            );
          },
          child: _FooterSubtitle(
            subtitle: context.locale.termsOfUse,
          ),
        ),
      ].insertBetween(
        const SizedBox(height: AppDimensions.medium),
      ),
    );
  }
}

class _FooterMobileApp extends StatelessWidget {
  const _FooterMobileApp();

  @override
  Widget build(BuildContext context) {
    final url = Uri.parse('https://www.youtube.com/');

    Future<void> launchYoutube() async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODO(dev): Add localization
        const _FooterTitle(title: 'Мобильное приложение'),
        Row(
          children: [
            GestureDetector(
              onTap: launchYoutube,
              child: Image.asset(ImagesAssets.googlePlay),
            ),
            const SizedBox(width: CommonDimensions.medium),
            GestureDetector(
              onTap: launchYoutube,
              child: Image.asset(ImagesAssets.appStore),
            ),
          ],
        ),
      ].insertBetween(
        const SizedBox(height: CommonDimensions.large),
      ),
    );
  }
}

class _FooterTitle extends StatelessWidget {
  final String title;

  const _FooterTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.themeData.textTheme.displaySmall?.copyWith(
        fontWeight: CommonFonts.weightRegular,
        fontSize: CommonFonts.appBarFontSize,
        color: context.theme.fivefoldTextColor,
        height: CommonFonts.sizeFactorLarge,
      ),
    );
  }
}

class _FooterSubtitle extends StatelessWidget {
  final String subtitle;

  const _FooterSubtitle({required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: context.themeData.textTheme.headlineMedium?.copyWith(
        fontWeight: CommonFonts.weightRegular,
        color: context.theme.defaultIconColor,
        height: CommonFonts.sizeFactorLarge,
      ),
    );
  }
}

class _CopyrightCookiesWidget extends StatelessWidget {
  final bool isSmart;

  const _CopyrightCookiesWidget({required this.isSmart});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _CopyrightCookiesText(
          text: context.locale.cookies,
          isSmart: isSmart,
        ),
        const Divider(),
        _CopyrightCookiesText(
          text: context.locale.copyright,
          isSmart: isSmart,
        ),
        const SizedBox(height: AppDimensions.medium),
      ].insertBetween(
        const SizedBox(height: AppDimensions.medium),
      ),
    );
  }
}

class _CopyrightCookiesText extends StatelessWidget {
  final String text;
  final bool isSmart;

  const _CopyrightCookiesText({
    required this.isSmart,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
      child: Text(
        text,
        style: context.themeData.textTheme.titleMedium?.copyWith(
          fontWeight: CommonFonts.weightMedium,
          color: context.theme.fivefoldTextColor,
        ),
      ),
    );
  }
}
