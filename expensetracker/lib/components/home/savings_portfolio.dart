import 'package:expensetracker/components/home/portfolio_chart/portfolio_return_chart.dart';
import 'package:expensetracker/components/home/portfolio_chart/portfolio_savings_chart.dart';
import 'package:expensetracker/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';

class SavingsPortfolio extends StatelessWidget {
  const SavingsPortfolio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
           Navigator.pushReplacementNamed(
                              context,
                              HomePage.routeName,
                              arguments: const HomePageArgs(pageIndex: 1),
                            );
          },
          child: SizedBox(
            width: double.infinity,
            height: 230,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Flexible(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Your Portfolio',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '\$314',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Flexible(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Your return this year 3.19%',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Text(
                              'Savings',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        PortfolioReturnChart(),
                        PieChartSample2(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
