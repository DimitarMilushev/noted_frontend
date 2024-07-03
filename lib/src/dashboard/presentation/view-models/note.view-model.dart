import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noted_frontend/src/dashboard/application/dashboard.service.dart';
import 'package:noted_frontend/src/dashboard/presentation/view-models/note-view.data.dart';
import 'package:noted_frontend/src/shared/components/note-preivew-card.component.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note.view-model.g.dart';

@riverpod
class NoteViewModel extends _$NoteViewModel {
  late final DashboardService _service;

  NotePreviewCardData? get data => state.value?.data;
  bool get isSaving => state.value?.isSaving ?? false;

  @override
  FutureOr<NoteViewData> build() {
    _service = ref.read(dashboardServiceProvider);
    return NoteViewData();
  }

  Future<void> saveChanges() async {
    final stateData = state.valueOrNull;
    if (stateData == null) return;

    state = AsyncData(stateData.copyWith(isSaving: true));
    await Future.delayed(Durations.long1, () {
      state = AsyncData(stateData.copyWith(isSaving: false));
    });
  }

  Future<void> loadData(num id) async {
    state = const AsyncLoading();
    final data = await Future.delayed(
        Durations.long1, () => _lastNotesMock.where((x) => x.id == id).first);

    state = AsyncData(NoteViewData(data: data));
  }
}

final _lastNotesMock = [
  NotePreviewCardData(
    id: 1,
    content:
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    title: "Why do we use it?",
    lastUpdated: DateTime(2023, 1, 20),
  ),
  NotePreviewCardData(
    id: 2,
    content:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    title: "Origin of Lorem Ipsum",
    lastUpdated: DateTime(2023, 2, 10),
  ),
  NotePreviewCardData(
    id: 3,
    content:
        "Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, 'Lorem ipsum dolor sit amet..', comes from a line in section 1.10.32.",
    title: "The standard Lorem Ipsum passage",
    lastUpdated: DateTime(2023, 3, 5),
  ),
  NotePreviewCardData(
    id: 4,
    content:
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.",
    title: "Variations of Lorem Ipsum",
    lastUpdated: DateTime(2023, 4, 15),
  ),
  NotePreviewCardData(
    id: 5,
    content:
        "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
    title: "Lorem Ipsum generators",
    lastUpdated: DateTime(2023, 5, 22),
  ),
  NotePreviewCardData(
    id: 6,
    content:
        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
    title: "History of Lorem Ipsum",
    lastUpdated: DateTime(2023, 6, 30),
  ),
];
