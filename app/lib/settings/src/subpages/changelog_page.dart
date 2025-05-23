// Copyright (c) 2022 Sharezone UG (haftungsbeschränkt)
// Licensed under the EUPL-1.2-or-later.
//
// You may obtain a copy of the Licence at:
// https://joinup.ec.europa.eu/software/page/eupl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:sharezone/main/application_bloc.dart';
import 'package:sharezone/changelog/change_view.dart';
import 'package:sharezone/changelog/changelog_bloc.dart';
import 'package:sharezone/changelog/changelog_gateway.dart';
import 'package:sharezone/changelog/changelog_page_view.dart';
import 'package:sharezone/widgets/list_with_bottom_threshold.dart';
import 'package:sharezone_utils/launch_link.dart';
import 'package:sharezone/util/platform_information_manager/get_platform_information_retreiver.dart';
import 'package:platform_check/platform_check.dart';
import 'package:sharezone_widgets/sharezone_widgets.dart';

class ChangelogPage extends StatelessWidget {
  static const String tag = "changelog-page";

  const ChangelogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final api = BlocProvider.of<SharezoneContext>(context).api;
    return BlocProvider<ChangelogBloc>(
      bloc: ChangelogBloc(
        ChangelogGateway(firestore: api.references.firestore),
        getPlatformInformationRetriever(),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Was ist neu?"),
              centerTitle: true,
            ),
            body: const _ChangeList(),
          );
        },
      ),
    );
  }
}

class _ChangeList extends StatelessWidget {
  const _ChangeList();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ChangelogBloc>(context);
    return StreamBuilder<ChangelogPageView>(
      initialData: const ChangelogPageView.placeholder(),
      stream: bloc.changes,
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.hasChanges) {
          return const Center(child: AccentColorCircularProgressIndicator());
        }

        final changeData = snapshot.data!;
        final children = _convertViewsToVersionSectionsWithNoDeviderAtTheBottom(
          changeData.changes,
        );

        return ListWithBottomThreshold(
          padding: const EdgeInsets.all(12),
          loadingIndicator:
              changeData.allChangesLoaded
                  ? Container()
                  : const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Center(
                      child: AccentColorCircularProgressIndicator(),
                    ),
                  ),
          thresholdHeight: 50,
          onThresholdExceeded: () => bloc.loadNext(),
          children: [
            if (!changeData.userHasNewestVersion)
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: UpdatePromptCard(),
              ),
            ...children,
          ],
        );
      },
    );
  }

  List<Widget> _convertViewsToVersionSectionsWithNoDeviderAtTheBottom(
    List<ChangeView> changes,
  ) {
    final versionSections = <Widget>[];
    final lastChange = changes.last;
    for (final change in changes) {
      versionSections.add(
        _VersionSection(
          change: change,
          showBottomDivider: change != lastChange,
          key: Key(change.version!),
        ),
      );
    }
    return versionSections;
  }
}

class _VersionSection extends StatelessWidget {
  const _VersionSection({
    super.key,
    required this.change,
    this.showBottomDivider = true,
  });

  final bool showBottomDivider;
  final ChangeView change;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: change.isNewerThanCurrentVersion! ? 0.3 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            change.version!,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8),
              _ChangeParagraph(
                list: change.newFeatures,
                title: "Neue Funktionen:",
              ),
              _ChangeParagraph(
                list: change.improvements,
                title: "Verbesserungen:",
              ),
              _ChangeParagraph(list: change.fixes, title: "Fehlerbehebungen:"),
            ],
          ),
          if (showBottomDivider) const Divider(),
        ],
      ),
    );
  }
}

class _ChangeParagraph extends StatelessWidget {
  const _ChangeParagraph({this.list, this.title});

  final String? title;
  final List<String>? list;

  @override
  Widget build(BuildContext context) {
    if (list == null || list!.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title!,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                list!
                    .map(
                      (text) => Padding(
                        padding: const EdgeInsets.only(bottom: 2.5),
                        child: Text(
                          text,
                          style: const TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            height: 16 / 15,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}

class UpdatePromptCard extends StatelessWidget {
  const UpdatePromptCard({super.key});

  String _getText() {
    if (PlatformCheck.isWeb) {
      return "Wir haben bemerkt, dass du eine veraltete Version der App verwendest. Lade die Seite neu, um die neuste Version zu erhalten! 👍";
    }

    return "Wir haben bemerkt, dass du eine veraltete Version der App installiert hast. Lade dir deswegen jetzt die Version im ${PlatformCheck.isMacOsOrIOS ? "App Store" : "Play Store"} herunter! 👍";
  }

  @override
  Widget build(BuildContext context) {
    return AnnouncementCard(
      key: const ValueKey('UpdatePromptCard'),
      onTap:
          PlatformCheck.isWeb
              ? null
              : () => launchURL(getStoreLink(), context: context),
      title: "Neues Update verfügbar!",
      padding: const EdgeInsets.all(0),
      titleColor: Colors.white,
      color: Colors.orange,
      content: Text(_getText(), style: const TextStyle(color: Colors.white)),
    );
  }

  String getStoreLink() {
    // Opens the Mac AppStore directly (only works on macOS devices)
    if (PlatformCheck.isMacOS) return 'https://sharezone.net/macos-direct';

    if (PlatformCheck.isAndroid) return 'https://sharezone.net/android';
    if (PlatformCheck.isIOS) return 'https://sharezone.net/ios';

    throw Exception('Unsupported platform');
  }
}
