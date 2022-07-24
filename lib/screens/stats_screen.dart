import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:covid19/models/data.dart';
import 'package:covid19/services/bloc/homepage_bloc.dart';
import 'package:covid19/services/utils.dart';
import 'package:covid19/styles.dart';
import 'package:covid19/widgets/country_dropdown.dart';
import 'package:covid19/widgets/covid_bar_chart.dart';
import 'package:covid19/widgets/custom_appbar.dart';
import 'package:covid19/widgets/stats_grid.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  static const routeName = '/stats-screen';

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  String _country = 'Ariyalur';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // callInitialData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Future.delayed(Duration.zero).then((_) {
      if(mounted)
      homePageBloc.getDistrict(context);
      homePageBloc.getDistrictWiseData(context, 'Ariyalur');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.primaryColor,
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          _buildRegionTabBar(),
          _buildStatsTabBar(),
          // SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 10.0),sliver: SliverToBoxAdapter(child: Text('All deatails are under CHC and CDH as on 26.08.2021')),),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: CovidBarChart(covidCases: covidUSADailyNewCases),
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Statistics',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: FutureBuilder<List<String>>(
            future: homePageBloc.getDistrict(context),
            builder: (context, snapshot) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: CountryDropdown(
                  countries: snapshot.data ?? [],
                  country: _country,
                  onChanged: (val) async {
                    print(val);
                    await homePageBloc.getDistrictWiseData(
                        context, val ?? 'Ariyalur');

                    setState(() => _country = val ?? 'Ariyalur');
                  },
                ),
                // TabBar(
                //   indicator: BubbleTabIndicator(
                //     tabBarIndicatorSize: TabBarIndicatorSize.tab,
                //     indicatorHeight: 40.0,
                //     indicatorColor: Colors.white,
                //   ),
                //   labelStyle: Styles.tabTextStyle,
                //   labelColor: Colors.black,
                //   unselectedLabelColor: Colors.white,
                //   tabs: <Widget>[

                //     Text('My Country'),
                //     Text('Global'),
                //   ],
                //   onTap: (index) {},
                // ),
              );
            }),
      ),
    );
  }

  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 1,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: <Widget>[
              Text('All beds are under CHC and CDH as on 26.08.2021',textAlign: TextAlign.center,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w100,),),
              // Text('Today'),
              // Text('Yesterday'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}
