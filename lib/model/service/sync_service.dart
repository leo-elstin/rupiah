import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/database/tables/account.dart';
import 'package:expense_kit/model/database/tables/expense.dart';
import 'package:expense_kit/model/database/tables/sync.dart';
import 'package:expense_kit/model/entity/account_entity.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:expense_kit/model/service/login_service.dart';
import 'package:flutter/foundation.dart';

class SyncService {
  static final SyncService instance = SyncService._internal();

  static final Client _client = Client();

  factory SyncService() {
    return instance;
  }

  SyncService._internal() {
    _client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('rupiah')
        .setSelfSigned();
  }

  bool syncing = false;

  Future<List<ExpenseEntity>> getExpenses() async {
    final databases = Databases(_client);
    try {
      final response = await databases.listDocuments(
        databaseId: 'expense_db',
        collectionId: 'expenses',
      );
      return response.documents
          .map((e) => ExpenseEntity.fromMap(e.data))
          .toList();
    } on AppwriteException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  Future<List<AccountEntity>> getAccounts() async {
    final databases = Databases(_client);
    try {
      final response = await databases.listDocuments(
        databaseId: 'expense_db',
        collectionId: 'accounts',
      );
      return response.documents
          .map((e) => AccountEntity.fromMap(e.data))
          .toList();
    } on AppwriteException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  Future<void> sync() async {
    if (syncing) return;

    List<ExpenseEntity> expenses = await getExpenses();

    for (var expense in expenses) {
      await ExpenseTable().insert(expense);
    }
    List<AccountEntity> accounts = await getAccounts();

    for (var account in accounts) {
      await AccountTable().insert(account);
    }

    syncing = true;
    await Future.delayed(const Duration(seconds: 5));
    List<SyncData> items = await SyncTable().get();
    for (var item in items) {
      Document? doc;
      if (item.type == TableType.account) {
        doc = await syncAccount(
          AccountEntity.fromMap(jsonDecode(item.name)),
          item.id,
        );
      } else if (item.type == TableType.expense) {
        doc = await syncExpense(
          ExpenseEntity.fromMap(jsonDecode(item.name)),
          item.id,
        );
      }

      if (doc != null) {
        await SyncTable().delete(item.id);
      }
    }

    syncing = false;
  }

  Future<Document?> syncAccount(AccountEntity entity, int id) async {
    final databases = Databases(_client);
    try {
      User? user = await LoginService.getUser();
      Map<String, dynamic> data = {
        ...entity.toMap(),
        'userId': user?.$id,
      };
      return await databases.createDocument(
        databaseId: 'expense_db',
        collectionId: 'accounts',
        documentId: entity.id ?? ID.unique(),
        data: data,
      );
    } on AppwriteException catch (e) {
      if (e.code == 409) {
        await SyncTable().delete(id);
      }
      print(e);
      return null;
    }
  }

  Future<Document?> syncExpense(ExpenseEntity entity, int id) async {
    final databases = Databases(_client);
    try {
      User? user = await LoginService.getUser();
      Map<String, dynamic> data = {
        ...entity.toMap(),
        'userId': user?.$id,
      };
      return await databases.createDocument(
        databaseId: 'expense_db',
        collectionId: 'expenses',
        documentId: entity.id,
        data: data,
      );
    } on AppwriteException catch (e) {
      if (e.code == 409) {
        await SyncTable().delete(id);
      }
      return null;
    }
  }
}
