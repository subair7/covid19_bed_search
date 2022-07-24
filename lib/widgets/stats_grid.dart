import 'package:covid19/services/bloc/homepage_bloc.dart';
import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: StreamBuilder<List<dynamic>>(
          stream: homePageBloc.getCovidBedDataByDustrictWise,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            int earmarked = int.parse('${snapshot.data![2]}') +
                int.parse('${snapshot.data![3]}') +
                int.parse('${snapshot.data![4]}');
            int supply = int.parse('${snapshot.data![2]}') +
                int.parse('${snapshot.data![5]}') +
                int.parse('${snapshot.data![8]}');
            int nonSupply = int.parse('${snapshot.data![3]}') +
                int.parse('${snapshot.data![6]}') +
                int.parse('${snapshot.data![9]}');

            return Column(
              children: <Widget>[
                Flexible(
                  child: Row(children: <Widget>[
                    _buildStatCard(
                        'Total Vacant', '${snapshot.data![11]}', Colors.orange),
                    _buildStatCard(
                        'Earmarked Beds', earmarked.toString(), Colors.purple)
                  ]),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard(
                          'O2 Supply', supply.toString(), Colors.green),
                      _buildStatCard(
                          'Non O2 Supply', nonSupply.toString(), Colors.cyan),
                      // _buildStatCard('ICU', 'N/A', Colors.purple),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
