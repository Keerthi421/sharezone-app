// Copyright (c) 2022 Sharezone UG (haftungsbeschränkt)
// Licensed under the EUPL-1.2-or-later.
//
// You may obtain a copy of the Licence at:
// https://joinup.ec.europa.eu/software/page/eupl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:analytics/analytics.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sharezone/blackboard/blackboard_card.dart';
import 'package:sharezone/blackboard/blackboard_dialog.dart';
import 'package:sharezone/blackboard/blackboard_view.dart';
import 'package:sharezone/blackboard/blocs/blackboard_page_bloc.dart';
import 'package:sharezone/blackboard/details/blackboard_details.dart';
import 'package:sharezone/main/application_bloc.dart';
import 'package:sharezone/navigation/logic/navigation_bloc.dart';
import 'package:sharezone/navigation/models/navigation_item.dart';
import 'package:sharezone/navigation/scaffold/sharezone_main_scaffold.dart';
import 'package:sharezone_widgets/sharezone_widgets.dart';

/// Open the blackboard page and returns true, if the user added a blackboard item
Future<bool> openBlackboardDialogAndShowConfirmationIfSuccessful(
  BuildContext context,
) async {
  final popOption = await Navigator.push<BlackboardPopOption>(
    context,
    IgnoreWillPopScopeWhenIosSwipeBackRoute(
      builder: (context) => const BlackboardDialog(),
      settings: const RouteSettings(name: BlackboardDialog.tag),
    ),
  );
  if (popOption == BlackboardPopOption.added && context.mounted) {
    _showUserConfirmationOfBlackboardArrival(context: context);
    return true;
  }
  return false;
}

Future<void> _showUserConfirmationOfBlackboardArrival({
  required BuildContext context,
}) async {
  await waitingForPopAnimation();
  if (context.mounted) {
    showDataArrivalConfirmedSnackbar(context: context);
  }
}

class BlackboardPage extends StatelessWidget {
  const BlackboardPage({super.key});

  static const tag = "blackboard-page";

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        popToOverview(context);
      },
      child: const SharezoneMainScaffold(
        body: _BlackboardList(),
        floatingActionButton: _BlackboardPageFAB(),
        navigationItem: NavigationItem.blackboard,
      ),
    );
  }
}

class _BlackboardPageFAB extends StatelessWidget {
  const _BlackboardPageFAB();

  @override
  Widget build(BuildContext context) {
    return ModalFloatingActionButton(
      onPressed:
          () => openBlackboardDialogAndShowConfirmationIfSuccessful(context),
      tooltip: "Neuen Infozettel",
      heroTag: 'sharezone-fab',
      icon: const Icon(Icons.add),
    );
  }
}

class _BlackboardList extends StatelessWidget {
  const _BlackboardList();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlackboardPageBloc>(context);
    return StreamBuilder<List<BlackboardView>>(
      stream: bloc.views,
      builder: (context, snapshot) {
        final list = snapshot.data;
        if (list == null) return Container();
        if (list.isEmpty) return const _NoItemsFound();
        return SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: SafeArea(
            child: AnimationLimiter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 250),
                  childAnimationBuilder:
                      (widget) => SlideAnimation(
                        verticalOffset: 20,
                        child: FadeInAnimation(child: widget),
                      ),
                  children: [for (final view in list) BlackboardCard(view)],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NoItemsFound extends StatelessWidget {
  const _NoItemsFound();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 64),
      child: PlaceholderWidgetWithAnimation(
        svgPath: 'assets/icons/megaphone.svg',
        animateSVG: true,
        title: 'Du hast alle Infozettel gelesen 👍',
        description: Column(
          children: <Widget>[
            const Text(
              'Hier können wichtige Ankündigungen in Form eines digitalen Zettels an Schüler, Lehrkräfte und Eltern ausgeteilt werden. Ideal für beispielsweise den Elternsprechtag, den Wandertag, das Sportfest, usw.',
            ),
            const SizedBox(height: 16),
            CardListTile(
              title: const Text('Infozettel hinzufügen'),
              leading: const Icon(Icons.add_circle_outline),
              centerTitle: true,
              onTap:
                  () => openBlackboardDialogAndShowConfirmationIfSuccessful(
                    context,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

void logBlackboardAddEvent(BuildContext context) {
  final analytics = BlocProvider.of<SharezoneContext>(context).analytics;
  analytics.log(NamedAnalyticsEvent(name: "blackboard_add"));
}
