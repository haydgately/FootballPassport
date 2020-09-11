import '../models/ground.dart';
import 'groundDataProvider.dart';

class GroundRepository {
  GroundDataProvider groundDataProvider = GroundDataProvider();

  Future<List<Ground>> getGrounds() => groundDataProvider.getGrounds();
  insertGround() => groundDataProvider.insertGround("Test Ground", "Test Team");
}
