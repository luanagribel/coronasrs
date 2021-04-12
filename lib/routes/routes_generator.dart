

import 'package:coronasrs/routes/routes.dart';
import 'package:coronasrs/ui/inicio.dart';
import 'package:coronasrs/ui/boletim.dart';
import 'package:coronasrs/ui/calendario.dart';
import 'package:coronasrs/ui/orientacoes.dart';
import 'package:coronasrs/ui/whatsapp.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name){
      case routeInicio:
        return MaterialPageRoute(builder: (_) => InicioPage());
        break;
      case routeBoletim:
        return MaterialPageRoute(builder: (_) => BoletimPage());
        break;
      case routeCalendario:
        return MaterialPageRoute(builder: (_) => CalendarioPage());
        break;
      case routeOrientacoes:
        return MaterialPageRoute(builder: (_) => OrientacoesPage());
        break;
      case routeWhatsapp:
        return MaterialPageRoute(builder: (_) => WhatsappPage());
        break;
    }
  }
}