import 'dart:convert';
import 'package:covid19/models/covid_bed_data.dart';
import 'package:covid19/services/bloc/homepage_api_caller.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/material.dart';

class HomePageBloc {
  final HomePageAPiCaller _api = HomePageAPiCaller();

  final BehaviorSubject<CovidBedData> _liveVacancyDetails =
      BehaviorSubject<CovidBedData>();
  final BehaviorSubject<List<dynamic>> _liveVacancyDetailsByDistrict =
      BehaviorSubject<List<dynamic>>();

  Future<void> readJson(BuildContext context) async {
    _liveVacancyDetails.addError('Loading...');
    final String response = await DefaultAssetBundle.of(context)
        .loadString('assets/images/covid.json');
    final CovidBedData data = await CovidBedData.fromJson(jsonDecode(response));
    _liveVacancyDetails.add(data);
  }

  Future<List<String>> getDistrict(BuildContext context) async {
    final String response = await DefaultAssetBundle.of(context)
        .loadString('assets/images/covid.json');
    final CovidBedData data = await CovidBedData.fromJson(jsonDecode(response));
    Set<String> district = {'Ariyalur'};
    data.data!.forEach((element) {
      district.add(element[1].toString());
    });
    return district.toList();
  }

  getDistrictWiseData(BuildContext context, String district) async {
    print(district);
    _liveVacancyDetailsByDistrict.addError('Loading...');
    final String response = await DefaultAssetBundle.of(context)
        .loadString('assets/images/covid.json');
    final CovidBedData data = await CovidBedData.fromJson(jsonDecode(response));
    List districtData = [];
    for (final element in data.data ?? []) {
      if (element[1] == district) districtData = element;
    }
    _liveVacancyDetailsByDistrict.add(districtData);
    // ...
  }

  dispose() {
    _liveVacancyDetails.close();
    _liveVacancyDetailsByDistrict.close();
  }

  BehaviorSubject<CovidBedData> get getCovidBedData => _liveVacancyDetails;
  BehaviorSubject<List<dynamic>> get getCovidBedDataByDustrictWise =>
      _liveVacancyDetailsByDistrict;
}

HomePageBloc homePageBloc = HomePageBloc();
