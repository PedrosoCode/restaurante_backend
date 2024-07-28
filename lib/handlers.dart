import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:restaurante_backend/imagens_routes.dart';
import 'package:restaurante_backend/pratos_routes.dart';

class Handlers {
  Router get router {
    final router = Router();

    // Montando as rotas para pratos
    router.mount('/pratos/', PratosRoutes().router);

    // Montando as rotas para imagens
    router.mount('/imagens/', ImagensRoutes().router);

    return router;
  }
}
