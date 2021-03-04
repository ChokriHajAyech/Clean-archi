import Foundation
import Swinject
import SwinjectAutoregistration

extension AppDelegate {

    // MARK: - register ViewController

    internal func setupVCDependencies() {

        container.registerViewController(
            SplashViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(SplashViewModel.self)
        }
        container.registerViewController(
            HomeViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(HomeViewModel.self)
        }
        container.registerViewController(
            FavorisViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(FavoritesViewModel.self)
        }
        container.registerViewController(
            SettingsViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(SettingsViewModel.self)
        }

        container.registerViewController(
            HousingDetailsViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(HousingDetailsViewModel.self)
        }
    }

    internal func setupVMDependencies() {

        // MARK: - Autoregister ViewModel

        container.autoregister(SplashViewModel.self,
                               initializer: SplashViewModel.init)
            .inObjectScope(ObjectScope.container)

        container.autoregister(
            FavoritesViewModel.self, initializer: FavoritesViewModel.init)
            .initCompleted { resolver, viewModel in
                viewModel.mapper = resolver.resolve(HousingListDAOMapper.self)
                viewModel.housingDBUseCase = resolver.resolve(HousingDBUseCase.self)
            }.inObjectScope(ObjectScope.container)

        container.autoregister(
            HomeViewModel.self, initializer: HomeViewModel.init)
            .initCompleted { resolver, viewModel in
                viewModel.housingUseCase = resolver.resolve(HousingUseCase.self)
            }.inObjectScope(ObjectScope.container)

        container.autoregister(
            HousingDetailsViewModel.self,
            initializer: HousingDetailsViewModel.init)
            .initCompleted { resolver, viewModel in
                viewModel.housingUseCase = resolver.resolve(HousingUseCase.self)
            }.inObjectScope(ObjectScope.container)

        container.autoregister(SettingsViewModel.self,
                               initializer: SettingsViewModel.init)
            .initCompleted { resolver, viewModel in
                viewModel.housingDBUseCase = resolver.resolve(HousingDBUseCase.self)
            }.inObjectScope(ObjectScope.container)

        container.autoregister(HousingDetailsViewModel.self,
                               initializer: HousingDetailsViewModel.init)
            .inObjectScope(ObjectScope.container)

    }

    internal func setupDependencies() {

        // Core Date
       container.autoregister(
        PersistenceManager.self,
        initializer: PersistenceManager.init)
        .inObjectScope(ObjectScope.container)

        // MARK: - register UsesCases

        container.autoregister(HousingUseCase.self,
                               initializer: HousingUseCaseImpl.init)
        container.autoregister(HousingDBUseCase.self,
                               initializer: HousingDBUseCaseImpl.init)

        // MARK: - register Repository

        container.autoregister(HousingRepository.self,
                               initializer: HousingRepositoryImpl.init)
            .inObjectScope(ObjectScope.container)

        // MARK: - register Service

        container.autoregister(HousingService.self,
                               initializer: HousingServiceImpl.init)
            .inObjectScope(ObjectScope.container)

        // MARK: - Mappers

        container.autoregister(HousingMapper.self,
                               initializer: HousingMapper.init)
            .inObjectScope(ObjectScope.container)

        container.autoregister(HousingDataCellMapper.self,
                               initializer: HousingDataCellMapper.init)
            .inObjectScope(ObjectScope.container)

        container.autoregister(HousingListDAOMapper.self,
                               initializer: HousingListDAOMapper.init)
            .inObjectScope(ObjectScope.container)

        // MARK: - Networks

        container.autoregister(NetworkProvider.self,
                               initializer: NetworkProvider.init)
            .inObjectScope(ObjectScope.container)
        container.autoregister(
            HousingApi.self, initializer: HousingApi.init)
            .initCompleted { _, api in
                api.apiClient = APIClient()
            }.inObjectScope(ObjectScope.container)
        container.register(HousingApi.self) { resolver -> HousingApi in
            resolver.resolve(NetworkProvider.self)!.makeHousingNetwork()
        }.inObjectScope(ObjectScope.container)

    }
}
