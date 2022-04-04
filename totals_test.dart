import 'dart:io'; //dart totals_.dart CSVExport-Code_With_Andrea-2019.csv
import 'dart:collection';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart totals.dart <inputFile.csv>');
    exit(1);
  }
  final lines = File(arguments.first).readAsLinesSync();
  final totalDurationByTag = {};
  var totalDuration = 0.0;
  lines.removeAt(0);
  for (var line in lines) {
    final duration = double.parse(line.split(',')[3].replaceAll('"', ''));
    final tag = line.split(',')[5].replaceAll('"', '');
    final previousTotal = totalDurationByTag[tag];
    if (previousTotal == null) {
      totalDurationByTag[tag] = duration;
    } else {
      totalDurationByTag[tag] = previousTotal + duration;
    }
    totalDuration += duration;
  }
  for (var entry in totalDurationByTag.entries) {
    final tag = entry.key == '' ? 'Unallocated' : entry.key;
    print('$tag: ${entry.value.toStringAsFixed(1)}h');
  }
  print('Total for all tags: ${totalDuration.toStringAsFixed(1)}');
  var sortMapByValue = Map.fromEntries(totalDurationByTag.entries.toList()
    ..sort((e1, e2) => e1.value.compareTo(e2.value)));
  for (var entry in sortMapByValue.entries) {
    final tag2 = entry.key == '' ? 'Unallocated' : entry.key;
    print('$tag2: ${entry.value.toStringAsFixed(1)}h');
  }
}
