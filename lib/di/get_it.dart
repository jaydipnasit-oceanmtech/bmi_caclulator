import 'package:bmi_caclulator/features/bmi_count/presentation/cubit/emi_count_cubit.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;

Future init() async {
  //Data source Dependency
  // getItInstance.registerLazySingleton<ProductDataSource>(() => ProductDataSourceImpl(client: getItInstance()));

//   //Data Repository Dependency
//   getItInstance.registerLazySingleton<ProductDataRepositories>(
//      () => ProductDataRepositoriesImpl(productDataSources: getItInstance()));

//   //Usecase Dependency
//   getItInstance.registerLazySingleton<GetProductData>(() => GetProductData(userRemoteRepositories: getItInstance()));

//   //Cubit Dependency
  getItInstance.registerFactory<EmiCountCubit>(() => EmiCountCubit());
}
