

import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/constants/recomendaciones.dart';

class RecommendationBloc {

    RecomendacionesDiarias listRecomendaciones = RecomendacionesDiarias();
    //var recomRandom = listRecomendaciones;
    //Random().nextInt(listRecomendaciones);
    //var diaActual = 0;
    //Future<dynamic> prefs = SharedPreferences.getInstance().getInt('as');

    Future<List<int>> getRandomIntAndDayToRecommendation() async {

        var randomInt = Random().nextInt(listRecomendaciones.recomendaciones.length);
        var diaActual = DateTime.now().day;
        final prefs = await SharedPreferences.getInstance();

        if(!prefs.containsKey('diaActual') && !prefs.containsKey('randomInt')){  //agregando valores inciales a recomendacion diaria y fecha actual
            await prefs.setInt('diaActual',diaActual);
            await prefs.setInt('randomInt',randomInt);
        }

        if(prefs.containsKey('randomInt')  && prefs.getInt('diaActual') != DateTime.now().day) { // actualizando recomendacion si es otro dia

            while(prefs.getInt('randomInt') == randomInt) {                              // actualzando recomendacion si la nueva recomend. random es la misma
                randomInt = Random().nextInt(listRecomendaciones.recomendaciones.length);
                await prefs.setInt('randomInt',randomInt);
            }
            await prefs.setInt('diaActual',diaActual);

        }

        return  [prefs.getInt("randomInt")!, prefs.getInt("diaActual")!];
    }





}