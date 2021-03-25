
import 'package:intl/intl.dart';

class DataBaseConstants {
  static const dbName = 'snackGame.db';
  static const dbVersion = 1;
  static const resumeGameTable = 'resumeGameTable';
  static const columnId='_id';
  static const direction = 'direction';
  static const dx = 'dx';
  static const dy = 'dy';
  static const score = 'score';
  static const date = 'date';
  static const scoreTable = 'scoreTable';
  static final dateFormat = new DateFormat("h:mm a d-M-yyyy");

}