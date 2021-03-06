import 'package:flutter/material.dart';

import '../enums/direction_enum.dart';

const double cubeSize = 30.0;
const double borderWidth = 1.0;
const int initSnakeLen = 6;

/// the number of points existing at the same time
const pointCount = 5;

const snakeInitX = 3, snakeInitY = 5;

const initSpeed = 30;
const speedIncrease = 2;
int speed = initSpeed;

const defPaddingSize = 15.0;

const Direction initDirection = Direction.right;

const Color
    //
    bgCubeColor = Color(0xFF4C3F91),
    snakeCubeColor = Color(0xFF9145B6),
    snakeHeadColor = Color(0xFFB958A5),
    dangerAreaColor = Color(0xFF37474F),
    gameBgColor = dangerAreaColor,
    pointColor = Color(0xFFFF5677)
    //
    ;
