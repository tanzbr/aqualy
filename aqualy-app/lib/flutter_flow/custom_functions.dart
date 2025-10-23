import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String? getDateText(DateTime? date) {
  if (date == null) return "...";

  String month = "";
  switch (date.month) {
    case 1:
      month = "jan.";
    case 2:
      month = "fev.";
    case 3:
      month = "mar.";
    case 4:
      month = "abr.";
    case 5:
      month = "mai.";
    case 6:
      month = "jun.";
    case 7:
      month = "jul.";
    case 8:
      month = "ago.";
    case 9:
      month = "set.";
    case 10:
      month = "out.";
    case 11:
      month = "nov.";
    case 12:
      month = "dez.";
  }
  return date.day.toString() + " " + month;
}

String getDateString(DateTime date) {
  // Usa o DateFormat da biblioteca intl para formatar corretamente
  final formattedDate = DateFormat('yyyy-MM-dd').format(date);
  return formattedDate;
}

String getFirstName(String name) {
  return name.split(" ")[0];
}

List<String> getDateIntervals(String periodo) {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  late DateTime startDate;
  late DateTime endDate;

  switch (periodo) {
    case 'Hoje':
      startDate = DateTime(now.year, now.month, now.day);
      endDate = startDate;
      break;

    case 'Ontem':
      final ontem = now.subtract(const Duration(days: 1));
      startDate = DateTime(ontem.year, ontem.month, ontem.day);
      endDate = startDate;
      break;

    case '7 dias':
      startDate = DateTime(now.year, now.month, now.day)
          .subtract(const Duration(days: 6));
      endDate = DateTime(now.year, now.month, now.day);
      break;

    case '14 dias':
      startDate = DateTime(now.year, now.month, now.day)
          .subtract(const Duration(days: 13));
      endDate = DateTime(now.year, now.month, now.day);
      break;

    case '30 dias':
      startDate = DateTime(now.year, now.month, now.day)
          .subtract(const Duration(days: 29));
      endDate = DateTime(now.year, now.month, now.day);
      break;

    case '90 dias':
      startDate = DateTime(now.year, now.month, now.day)
          .subtract(const Duration(days: 89));
      endDate = DateTime(now.year, now.month, now.day);
      break;

    default:
      // Caso o valor seja inválido, retorna hoje como padrão
      startDate = DateTime(now.year, now.month, now.day);
      endDate = startDate;
  }

  return [formatter.format(startDate), formatter.format(endDate)];
}
