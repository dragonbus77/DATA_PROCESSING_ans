void main() {
  var fruits = {1: 1, 4: 2, 6: 4, 3: 85, 5: 23, 2: 11};

  var sortMapByValue = Map.fromEntries(
      fruits.entries.toList()..sort((e1, e2) => e1.value.compareTo(e2.value)));
  print("***Sorted Map by value***");
  print(sortMapByValue);
}
