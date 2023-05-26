import 'package:flutter_test/flutter_test.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';

void main() {
  group('[DOMAIN] - UserEntity', () {
    test('Should return a valid entity', () {
      // Arrange
      const entity = UserEntity(
        name: 'name',
        email: 'email',
        id: 'uid',
      );

      // Assert
      expect(entity, isNotNull);
      expect(entity, isA<UserEntity>());
      expect(entity.name, entity.name);
      expect(entity.email, entity.email);
      expect(entity.id, entity.id);
    });
  });
}
