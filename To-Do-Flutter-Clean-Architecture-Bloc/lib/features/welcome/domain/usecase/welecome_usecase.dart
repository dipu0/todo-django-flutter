import 'package:todo/features/welcome/domain/repository/welcome_repository.dart';

class WelcomeUseCase {
  WelcomeRepository welcomeRepository;

  WelcomeUseCase(this.welcomeRepository);

  Future<bool> isUserLoggedIn() async {
    return await welcomeRepository.isUserLoggedIn();
  }
}
