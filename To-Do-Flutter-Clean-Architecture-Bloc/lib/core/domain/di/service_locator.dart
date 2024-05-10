import 'package:todo/features/authentication/data/repo_impl/auth_cache_impl.dart';
import 'package:todo/features/authentication/domain/usecase/auth_use_case.dart';
import 'package:todo/features/todolist/data/cache/todo_cache_impl.dart';
import 'package:todo/features/todolist/data/http/todo_http_impl.dart';
import 'package:todo/features/welcome/data/repo_impl/welcome_repository_impl.dart';
import 'package:todo/features/welcome/domain/repository/welcome_repository.dart';
import 'package:todo/features/welcome/domain/usecase/welecome_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import '../../../app/app.dart';
import '../../../features/authentication/data/repo_impl/auth_http_impl.dart';
import '../../../features/authentication/domain/repository/auth_repository.dart';
import '../../../features/todolist/domain/repo/todo_repository.dart';
import '../../../features/todolist/domain/usecase/todos_use_case.dart';
import '../../../features/trades/data/cache/trade_cache_impl.dart';
import '../../../features/trades/data/http/trade_http_impl.dart';
import '../../../features/trades/domain/repo/trade_repository.dart';
import '../../../features/trades/domain/usecase/trades_use_case.dart';
import '../../data/cache/client/base_cache.dart';
import '../../data/cache/client/preference_cache.dart';
import '../../data/http/http_export.dart';

final serviceLocator = GetIt.instance;

class ServiceLocator {
  init({required AppConfig appConfig}) {
    // Base Register
    _baseRegister();

    // Register Repositories
    _registerRepositories();
  }

  void _baseRegister() {
    registerSingleton<AppConfig>(appConfig);

    registerFactory<ApiClientConfig>(() => ApiClientConfig(
          baseUrl: appConfig.apiBaseUrl,
          isDebug: appConfig.debug,
          apiVersion: appConfig.apiVersion,
        ));

    registerFactory<ApiClient>(
        () => ApiClient(get<ApiClientConfig>(), get<BaseCache>(), Logger()));

    registerFactory<BaseCache>(() => PreferenceCache());
  }

  void _registerRepositories() {
    // Register Repository without cache
    _registerRepoWithOutCache();

    // Register Repository with cache
    _registerRepoWithCache(get<ApiClient>(), get<BaseCache>());
  }

  void _registerRepoWithOutCache() {
    registerFactory<ApiUrl>(() => ApiUrl());
    registerFactory<WelcomeRepository>(() => WelcomeRepositoryImpl(get<ApiClient>()));
    //registerSingleton<ToDoRepository>(ToDoHttpImp(get<ApiClient>(), get<ApiUrl>()));
    registerFactory<ToDoRepository>(()=>ToDoHttpImp(get<ApiClient>(), get<ApiUrl>()));

    _registerUseCase();
  }

  void _registerRepoWithCache(ApiClient client, BaseCache cache) {
    _registerAuthRepositories(client, cache);
   // _registerTradeRepositories(client, cache);
    //_registerToDosRepositories(client, cache);
  }

  void _registerUseCase() {
    registerFactory<WelcomeUseCase>(() => WelcomeUseCase(get<WelcomeRepository>()));
    registerFactory<AuthUseCase>(() => AuthUseCase(get<AuthRepository>()));
    registerFactory<TradeUseCase>(() => TradeUseCase(get<TradeRepository>()));
    registerFactory<ToDosUseCase>(() => ToDosUseCase(get<ToDoRepository>()));
  }

  // void _registerTradeRepositories(ApiClient client, BaseCache cache) {
  //   var tradeHttp = TradeHttpImp(client, get<ApiUrl>());
  //   var tradeCache = TradeCacheImpl(cache, tradeHttp);
  //   registerSingleton<TradeRepository>(tradeCache);
  // }

  void _registerToDosRepositories(ApiClient client, BaseCache cache) {
    var todosHttp = ToDoHttpImp(client, get<ApiUrl>());
    var todosCache = ToDoCacheImpl(cache, todosHttp);
    registerSingleton<ToDoRepository>(todosCache);
  }

  void _registerAuthRepositories(ApiClient client, BaseCache cache) {
    var authHttp = AuthHttpImpl(client, get<ApiUrl>());
    var authCache = AuthCacheImpl(cache, authHttp);
    registerSingleton<AuthRepository>(authCache);
  }

  static registerSingleton<T extends Object>(object) {
    serviceLocator.registerSingleton<T>(object);
  }

  static registerFactory<T extends Object>(object) {
    serviceLocator.registerFactory<T>(object);
  }

  static T get<T extends Object>() {
    return serviceLocator.get<T>();
  }
}
