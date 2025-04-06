import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityProfile {
  String name;
  String description;
  String culture;
  File? profileImage;
  List<Map<String, dynamic>> events;
  List<Map<String, dynamic>> media;

  CommunityProfile({
    required this.name,
    required this.description,
    required this.culture,
    this.profileImage,
    this.events = const [],
    this.media = const [],
  });
}

class CommunityProfileNotifier extends StateNotifier<CommunityProfile> {
  CommunityProfileNotifier()
      : super(CommunityProfile(
          name: 'Community Name',
          description: 'Community Description',
          culture: 'Community Culture',
        ));

  void updateProfile({
    required String name,
    required String description,
    required String culture,
  }) {
    state = CommunityProfile(
      name: name,
      description: description,
      culture: culture,
      profileImage: state.profileImage,
      events: state.events,
      media: state.media,
    );
  }

  void addEvent(Map<String, dynamic> event) {
    state = CommunityProfile(
      name: state.name,
      description: state.description,
      culture: state.culture,
      profileImage: state.profileImage,
      events: [...state.events, event],
      media: state.media,
    );
  }

  void addMedia(Map<String, dynamic> mediaItem) {
    state = CommunityProfile(
      name: state.name,
      description: state.description,
      culture: state.culture,
      profileImage: state.profileImage,
      events: state.events,
      media: [...state.media, mediaItem],
    );
  }
}