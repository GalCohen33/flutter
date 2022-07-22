class DummyModel {
  static List<String> items = [
    'apple',
    // 'bannan',
    // 'avocado',
    // 'corn',
    // 'fish',
    // 'ham',
    // 'spaghetti',
    // 'rise',
    // 'tuna',
    // 'scope',
    // 'flour',
    // 'cats',
    // 'sandwich',
    // 'meat',
    // 'pigs',
  ];

  Set<String> getById(int index) => {items[index]};
}
