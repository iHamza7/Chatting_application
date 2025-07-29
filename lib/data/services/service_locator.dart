import 'package:chatting_application/data/repositories/auth_repository.dart';
import 'package:chatting_application/data/repositories/chat_repository.dart';
import 'package:chatting_application/data/repositories/contact_repository.dart';
import 'package:chatting_application/firebase_options.dart';
import 'package:chatting_application/logic/cubit/auth/auth_cubit.dart';
import 'package:chatting_application/logic/cubit/chat/chat_cubit.dart';
import 'package:chatting_application/router/app_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getIt.registerLazySingleton(() => AppRouter());
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => AuthRepository());
  getIt.registerLazySingleton(() => ContactRepository());
  getIt.registerLazySingleton(() => ChatRepository());
  getIt.registerLazySingleton(
    () => AuthCubit(
      authRepository: AuthRepository(),
    ),
  );
  getIt.registerFactory(
    () => ChatCubit(
      chatRepository: ChatRepository(),
      currentUserId: getIt<FirebaseAuth>().currentUser!.uid,
    ),
  );
}
