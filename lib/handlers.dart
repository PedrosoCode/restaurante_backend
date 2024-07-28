import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:restaurante_backend/pratos_routes.dart';

class Handlers {
  Router get router {
    final router = Router();

    router.mount('/pratos/', PratosRoutes().router);

    return router;
  }
}
