import 'dart:io'; //dart totals_answer.dart CSVExport-Code_With_Andrea-2019.csv
import 'dart:collection';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart totals.dart <inputFile.csv>');
    exit(1);
  }
  final lines = File(arguments.first).readAsLinesSync().sublist(1);
  final totalDurationMap = {};
  var totalDuration = 0.0;
  for (var line in lines) {
    final duration = double.parse(line.split(',')[3].replaceAll('"', ''));
    var tag = line.split(',')[5].replaceAll('"', '');
    tag = tag == '' ? 'Unallocated' : tag;
    totalDurationMap[tag] = totalDurationMap[tag] == null
        ? duration
        : totalDurationMap[tag] + duration;
    totalDuration += duration;
  }
  for (var entry in totalDurationMap.entries) {
    print('${entry.key} : ${entry.value.toStringAsFixed(1)}h');
  }
  print('Total for all tags: ${totalDuration.toStringAsFixed(1)}');
  var sortMapByValue = Map.fromEntries(totalDurationMap.entries.toList()
    ..sort((e1, e2) => e1.value.compareTo(e2.value)));
  for (var entry in sortMapByValue.entries) {
    print('${entry.key}: ${entry.value.toStringAsFixed(1)}h');
  }
}
