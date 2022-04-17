import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/model/ChildDto.dart';
import 'package:my_project/router/routes.dart';
import 'package:my_project/utils/Utils.dart';

class SingleChildCard extends StatelessWidget {
  ChildDto childDto;
  SingleChildCard(this.childDto);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Utils.homeNavigator.currentState!
            .pushNamed(routeChildrenDetail, arguments: childDto);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: screenWidth,
              height: screenHeight * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ),
                        radius: screenHeight * 0.05,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            childDto.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy', 'es_ES')
                                .format(DateTime.tryParse(childDto.birthday)!),
                            style: TextStyle(
                                color: Color.fromRGBO(161, 164, 182, 1),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
