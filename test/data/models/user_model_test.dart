import 'package:flutter_test/flutter_test.dart';
import 'package:seva_auth/data/models/user_model.dart';

void main() {
  group('[DATA] - UserModel', () {
    group('fromJson', () {
      test('Should return a valid model', () {
        // Arrange
        final json = {
          'name': 'name',
          'email': 'email',
          'id': 'uid',
        };

        // Act
        final model = UserModel.fromJson(json);

        // Assert
        expect(model, isNotNull);
        expect(model, isA<UserModel>());
        expect(model.name, json['name']);
        expect(model.email, json['email']);
        expect(model.id, json['id']);
      });
    });

    group('toJson', () {
      test('Should return a valid json', () {
        // Arrange
        const model = UserModel(
          name: 'name',
          email: 'email',
          id: 'uid',
        );

        // Act
        final json = model.toJson();

        // Assert
        expect(json, isNotNull);
        expect(json, isA<Map<String, dynamic>>());
        expect(json['name'], model.name);
        expect(json['email'], model.email);
        expect(json['id'], model.id);
      });
    });
    group('fromEntity', () {
      test('Should return a valid model', () {
        // Arrange
        const entity = UserModel(
          name: 'name',
          email: 'email',
          id: 'uid',
        );

        // Act
        final model = UserModel.fromEntity(entity);

        // Assert
        expect(model, isNotNull);
        expect(model, isA<UserModel>());
        expect(model.name, entity.name);
        expect(model.email, entity.email);
        expect(model.id, entity.id);
      });
    });
  });
}
