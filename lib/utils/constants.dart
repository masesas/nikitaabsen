import 'package:flutter/material.dart';

var mainColor = Colors.indigo.shade500;
var passwordRegex =
    r"^(?=.*\d{1})(?=.*[a-z]{1})(?=.*[A-Z]{0})(?=.*[!@#$%^&*{|}?~_=+.-]{0})(?=.*[a-zA-Z0-9@$!%*?&{|}~_=+.-])(?!.*\s).{8,50}$";

const defaultErrorMessage = 'Maaf, terjadi kesalahan pada server';
