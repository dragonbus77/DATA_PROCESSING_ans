import 'dart:io';
import 'dart:collection';

void main(List<String> arguments) {
  // 제공되는 것
  if (arguments.isEmpty) {
    print(
        'Usage: dart totals.dart <inputFile.csv>'); // dart totals.dart CSVExport-Code_With_Andrea-2019.csv
    exit(1);
  }
  final inputFile = arguments.first;
  //print(inputFile); //CSVExport-Code_With_Andrea-2019.csv
  final lines = File(inputFile).readAsLinesSync(); //모든 csv 파일이 출력
  // 여기까지
  final totalDurationByTag = {};
  lines.removeAt(0); //앞에 duration, tags 같은 단어 있는 행 없애버리기
  var totalDuration = 0.0;
  for (var line in lines) {
    // 한 행씩 읽기
    final values = line.split(
        ','); // ["Code With Andrea", "07/06/2019 16:40", "07/06/2019 17:30", "0.83", "", "Blogging", "", "", "", ""]같은게 출력
    final durationStr = values[3].replaceAll('"', ''); // " 없애기
    final duration = double.parse(durationStr); //double로 바꾸기
    final tag = values[5].replaceAll('"', ''); // " 없애기
    final previousTotal = totalDurationByTag[tag]; //태그별로 duration 합치기
    if (previousTotal == null) {
      totalDurationByTag[tag] = duration;
    } else {
      totalDurationByTag[tag] = previousTotal + duration;
    }
    totalDuration += duration;
  }
  for (var entry in totalDurationByTag.entries) {
    final durationFormatted = entry.value.toStringAsFixed(1);
    final tag = entry.key == '' ? 'Unallocated' : entry.key;
    print('$tag: ${durationFormatted}h');
  }
  print('Total for all tags: ${totalDuration.toStringAsFixed(1)}');
}
// lines = readFile(inputFile)
// durationByTag = empty map
// lines.removeFirst()
// for (line in lines)
//   values = line.split(',')
//   duration = values[3]
//   tag = values[5]
//   update(durationByTag[tag], duration)
// end
// printAll(durationByTag)