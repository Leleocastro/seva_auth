// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seva_auth/data/datasources/user/user_datasoure_impl.dart';
import 'package:seva_auth/data/models/user_model.dart';
import 'package:seva_auth/utils/failure.dart';

class FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

class CollectionReferenceMock extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class DocumentReferenceMock extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class QueryMock extends Mock implements Query<Map<String, dynamic>> {}

class SnapMock extends Mock implements QuerySnapshot<Map<String, dynamic>> {}

class QueryDocMock implements QueryDocumentSnapshot<Map<String, dynamic>> {
  final Map<String, dynamic> dataMock;
  QueryDocMock({required this.dataMock});
  @override
  operator [](Object field) => throw UnimplementedError();

  @override
  Map<String, dynamic> data() {
    return dataMock;
  }

  @override
  bool get exists => throw UnimplementedError();

  @override
  get(Object field) => throw UnimplementedError();

  @override
  String get id => throw UnimplementedError();

  @override
  SnapshotMetadata get metadata => throw UnimplementedError();

  @override
  DocumentReference<Map<String, dynamic>> get reference =>
      throw UnimplementedError();
}

void main() {
  late final FirebaseFirestore firestore;
  late final UserDatasourceImpl datasource;
  late final UserModel userModel;
  late final CollectionReference<Map<String, dynamic>> collection;
  late final DocumentReference<Map<String, dynamic>> document;
  late final Query<Map<String, dynamic>> query;
  late final QuerySnapshot<Map<String, dynamic>> querySnapshot;
  setUpAll(() {
    firestore = FirebaseFirestoreMock();
    datasource = UserDatasourceImpl(firestore);
    collection = CollectionReferenceMock();
    document = DocumentReferenceMock();
    query = QueryMock();
    querySnapshot = SnapMock();
    userModel = const UserModel(
      id: 'id',
      name: 'name',
      email: 'email',
    );
    when(() => firestore.collection(any())).thenReturn(
      collection,
    );
    when(() => collection.doc(any())).thenReturn(
      document,
    );
  });
  group('[DATA] - UserDatasource', () {
    group('saveUser', () {
      test('Should save the user', () async {
        // Arrange
        when(() => document.set(any())).thenAnswer((_) async {});

        // Act
        var (ok, err) = await datasource.saveUser(userModel);

        // Assert
        expect(ok, isNotNull);
        expect(ok, isA<bool>());
        expect(ok, equals(true));
        expect(err, isNull);
      });
      test('Should return an error', () async {
        // Arrange
        when(() => document.set(any())).thenThrow(Exception());

        // Act
        var (ok, err) = await datasource.saveUser(userModel);

        // Assert
        expect(ok, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
      });
    });
    group('getUsers', () {
      test('Should return a list of users', () async {
        // Arrange
        when(() => collection.orderBy(any())).thenReturn(query);
        when(() => query.get()).thenAnswer((_) async => querySnapshot);
        when(() => querySnapshot.docs).thenReturn([
          QueryDocMock(
            dataMock: {
              'id': 'id',
              'name': 'name',
              'email': 'email',
            },
          ),
        ]);

        // Act
        var (data, err) = await datasource.getUsers();

        // Assert
        expect(data, isNotNull);
        expect(data, isA<List<UserModel>>());
        expect(data?.length, equals(1));
        expect(data?.first.id, equals('id'));
        expect(data?.first.name, equals('name'));
        expect(data?.first.email, equals('email'));
        expect(err, isNull);
      });
      test('Should return an error', () async {
        // Arrange
        when(() => collection.orderBy(any())).thenReturn(query);
        when(() => query.get()).thenThrow(Exception());

        // Act
        var (data, err) = await datasource.getUsers();

        // Assert
        expect(data, isNull);
        expect(err, isNotNull);
        expect(err, isA<Failure>());
      });
    });
  });
}
