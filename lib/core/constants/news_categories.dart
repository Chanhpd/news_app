enum NewsCategory {
  general,
  business,
  technology,
  sports,
  entertainment,
  health,
  science;

  String get displayName {
    switch (this) {
      case NewsCategory.general:
        return 'General';
      case NewsCategory.business:
        return 'Business';
      case NewsCategory.technology:
        return 'Technology';
      case NewsCategory.sports:
        return 'Sports';
      case NewsCategory.entertainment:
        return 'Entertainment';
      case NewsCategory.health:
        return 'Health';
      case NewsCategory.science:
        return 'Science';
    }
  }

  String get apiValue {
    return name;
  }
}
