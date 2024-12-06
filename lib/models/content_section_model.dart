import 'dart:ui';

class ContentSection {
  final String sectionTitle;
  final List<ContentItem> items;

  ContentSection({
    required this.sectionTitle,
    required this.items,
  });
}

class ContentItem {
  final String title;
  final String type;
  final String thumbnailUrl;
  final String schedule;
  final List<Tag> tags;

  ContentItem({
    required this.title,
    required this.type,
    required this.thumbnailUrl,
    required this.schedule,
    required this.tags,
  });
}

class FeaturedContent {
  final String? id;
  final String? path;
  final String? thumbnail;
  final List<dynamic>? participants;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String schedule;
  final List<Tag> tags;

  FeaturedContent({
    this.id,
    this.path,
    this.thumbnail,
    this.participants,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.schedule,
    required this.tags,
  });
}

class Tag {
  final String name;
  final Color color;

  Tag({required this.name, required this.color});
}
