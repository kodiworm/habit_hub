import 'package:flutter/material.dart';

class IconsRepository {
  // Predefined constant IconData instances
  static const Map<int, IconData> _iconDataMap = {
    0xe3af: Icons.directions_walk,
    0xe52f: Icons.directions_bike,
    0xe855: Icons.alarm,
    0xe865: Icons.book,
    0xe3a8: Icons.brush,
    0xe39c: Icons.bubble_chart,
    0xe7e9: Icons.cake,
    0xe86c: Icons.check_circle,
    0xe89f: Icons.child_care,
    0xe84e: Icons.accessibility,
    0xe541: Icons.local_cafe,
    0xe54f: Icons.local_grocery_store,
    0xe553: Icons.local_play,
    0xe53e: Icons.local_atm,
    0xe405: Icons.music_note,
    0xe869: Icons.build,
    0xeb3e: Icons.beach_access,
    0xe838: Icons.star_border,
    0xf222: Icons.directions_transit_sharp,
    0xe80c: Icons.school,
    0xe55b: Icons.local_gas_station,
  };

  /// Retrieves a constant IconData instance for the given codePoint.
  static IconData getIconData(int codePoint) {
    return _iconDataMap[codePoint] ?? Icons.error; // Fallback to error icon
  }

  /// Returns a list of codePoints for featured icons.
  List<int> getFeaturedIcons() {
    return _iconDataMap.keys.toList();
  }
}
