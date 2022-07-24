import 'package:covid19/models/covid_bed_data.dart';
import 'package:covid19/services/bloc/homepage_bloc.dart';
import 'package:covid19/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CovidBarChart extends StatelessWidget {
  final List<double> covidCases;

  const CovidBarChart({required this.covidCases});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: StreamBuilder<List<dynamic>>(
          stream: homePageBloc.getCovidBedDataByDustrictWise,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            }
            return StreamBuilder<CovidBedData>(
                stream: homePageBloc.getCovidBedData,
                builder: (context, details) {
                  if (!details.hasData) {
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(snapshot.data!.length, (index) {
                        return index == 0
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4),
                                child: Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                Utils.trimString(
                                                    details.data!.fields![index]
                                                        .label
                                                        .toString()
                                                        .replaceAll(
                                                            ' under CHC and CDH as on 26.08.2021',
                                                            ''),
                                                    60),
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Color.fromARGB(
                                                            255, 170, 168, 168),
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                Utils.trimString(
                                                    snapshot.data![index], 60),
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 14.0,
                                                        color: CommonColor
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      }),
                    ),
                  );
                });
          }),
    );
  }
}
