import 'dart:io';

import 'package:args/args.dart';

void main(List<String> arguments) {
  var parser = ArgParser();
  parser.addCommand('args');
  var args = parser.parse(arguments).arguments;
  BasicResponsive(args[0]);
}

class BasicResponsive {
  String _txt;
  final String _path;

  BasicResponsive(this._path) {
    _main(_path);
  }

  void _main(String path) async {
    print('Abrindo arquivo...');
    var file = await File(path);
    _txt = await file.readAsString();

    print('Editando arquivo...');
    _parameterManager();

    await file.writeAsString(_txt);
    print('Arquivo editado');
  }

  void _parameterManager() {
    var height = [
      'size',
      'height',
      'fontSize',
      'top',
      'bottom',
      'vertical',
      'maxHeight',
      'radius'
    ];
    var width = <String>['width', 'left', 'right', 'horizontal', 'maxWidth'];

    height.forEach((element) {
      _changeForDynamic(element, 'height');
    });
    width.forEach((element) {
      _changeForDynamic(element, 'width');
    });
  }

  void _changeForDynamic(
      String parameter, /*double sizeScreen, */ String sizeType) {
    var rx = RegExp(r'(' + parameter + r': )(\d+)?(\d+.?(\d+)?)');
    var matchs = rx.allMatches(_txt).toList();
    matchs.forEach((exp) {
      //var constProporcion = (double.parse(exp.group(2)) / sizeScreen).toStringAsPrecision(3);
      _txt = _txt.replaceFirst(
          rx, '${exp.group(1)}_ds.$sizeType(${exp.group(2)})');
    });
  }
}
