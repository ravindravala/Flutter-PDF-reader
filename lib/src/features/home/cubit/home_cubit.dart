import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pdfreader/src/constant/app_constant.dart';
import 'package:pdfreader/src/constant/app_string.dart';
import 'package:pdfreader/src/models/file_info.dart';
import 'package:permission_handler/permission_handler.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void scanPDF() async {
    emit(HomeLoading());
    bool isGranted = await _requestStoragePermission();
    if (isGranted) {
      try {
        var scannedFiles = await _scanFiles();
        if (scannedFiles.isEmpty) {
          emit(HomeError(errorMessage: AppString.pdfFilesNotFound));
        } else {
          emit(HomeLoaded(pdfFiles: scannedFiles));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(HomeError(errorMessage: e.toString()));
      }
    } else {
      emit(HomeError(errorMessage: AppString.storageDeniedErrorMessage));
    }
  }

  Future<bool> _requestStoragePermission() async {
    await Permission.manageExternalStorage.request();
    return await Permission.manageExternalStorage.status ==
        PermissionStatus.granted;
  }

  Future<List<FileInfo>> _scanFiles() async {
    List<FileInfo> data = [];
    Directory dir = Directory(AppConstant.androidRootDirectory);
    List<FileSystemEntity> entries = dir.listSync(recursive: false).toList();

    for (FileSystemEntity entity in entries) {
      Directory newdir = Directory(entity.path);

      try {
        await for (FileSystemEntity newEntity
            in newdir.list(recursive: true, followLinks: false)) {
          if (newEntity.path.endsWith(AppConstant.pdfExtention)) {
            String name = newEntity.path.split("/").last;
            data.add(FileInfo(name: name, path: newEntity.path));
          }
        }
      } catch (_) {}
    }
    return data;
  }
}
