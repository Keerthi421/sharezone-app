// Copyright (c) 2022 Sharezone UG (haftungsbeschränkt)
// Licensed under the EUPL-1.2-or-later.
//
// You may obtain a copy of the Licence at:
// https://joinup.ec.europa.eu/software/page/eupl
//
// SPDX-License-Identifier: EUPL-1.2

part of '../../course_edit_design.dart';

class _SelectTypePopResult {
  final Design? initialDesign;
  final EditDesignType editDesignType;

  const _SelectTypePopResult(this.initialDesign, this.editDesignType);
}

class _SelectTypeDialog extends StatelessWidget {
  const _SelectTypeDialog({required this.bloc});

  final CourseEditDesignBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: const AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[_CourseDesign(), _PersonalDesign()],
        ),
      ),
    );
  }
}

class _CourseDesign extends StatelessWidget {
  const _CourseDesign();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CourseEditDesignBloc>(context);
    return _DesignTypeSection.left(
      stream: bloc.courseDesign,
      title: "Kurs",
      subtitle: "Farbe gilt für den gesamten Kurs",
      type: EditDesignType.course,
    );
  }
}

class _PersonalDesign extends StatelessWidget {
  const _PersonalDesign();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CourseEditDesignBloc>(context);
    return _DesignTypeSection.right(
      stream: bloc.personalDesign,
      title: "Persönlich",
      subtitle: "Gilt nur für dich und liegt über der Kursfarbe",
      type: EditDesignType.personal,
    );
  }
}

class _DesignTypeSection extends StatelessWidget {
  final Stream<Design?> stream;
  final String title, subtitle;
  final EdgeInsets padding;
  final EditDesignType type;

  const _DesignTypeSection.left({
    required this.stream,
    required this.title,
    required this.subtitle,
    required this.type,
  }) : padding = const EdgeInsets.fromLTRB(12, 12, 6, 12);

  const _DesignTypeSection.right({
    required this.stream,
    required this.title,
    required this.subtitle,
    required this.type,
  }) : padding = const EdgeInsets.fromLTRB(6, 12, 12, 12);

  @override
  Widget build(BuildContext context) {
    final hasPermissionToEdit = _hasPermissionToEdit(context);
    return Expanded(
      child: StreamBuilder<Design?>(
        stream: stream,
        builder: (context, snapshot) {
          final initialDesign = snapshot.data;
          return Opacity(
            opacity: hasPermissionToEdit ? 1 : 0.5,
            child: InkWell(
              onTap:
                  hasPermissionToEdit
                      ? () => Navigator.pop(
                        context,
                        _SelectTypePopResult(initialDesign, type),
                      )
                      : null,
              child: Padding(
                padding: padding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _ColorCircleSelectType(
                      design: initialDesign,
                      hasPermission: hasPermissionToEdit,
                      size: 50,
                    ),
                    const SizedBox(height: 12),
                    Text(title, textAlign: TextAlign.center),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool _hasPermissionToEdit(BuildContext context) {
    if (type == EditDesignType.personal) return true;
    final courseGateway = BlocProvider.of<SharezoneContext>(context).api.course;
    final bloc = BlocProvider.of<CourseEditDesignBloc>(context);
    final memberRole = courseGateway.getRoleFromCourseNoSync(bloc.courseId)!;
    return memberRole.hasPermission(GroupPermission.contentCreation);
  }
}

class _ColorCircleSelectType extends StatelessWidget {
  const _ColorCircleSelectType({
    required this.design,
    this.hasPermission = true,
    this.size = 50,
  });

  final Design? design;
  final bool hasPermission;
  final double size;

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (!hasPermission) child = const Icon(Icons.lock, color: Colors.white);
    if (design == null) {
      child = const Align(alignment: Alignment.center, child: Text("-"));
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: design?.color),
      child: child,
    );
  }
}
