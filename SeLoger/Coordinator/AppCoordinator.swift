import UIKit
import Swinject

/// Define what type of flows can be started from this Coordinator
protocol AppCoordinatorProtocol {
    func showSplashFlow()
    func showHomeFlow()
}

final class AppCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var type: CoordinatorType { .app }
    var childCoordinators: [Coordinator] = []
    let container: Container
    private let window: UIWindow

    init(window: UIWindow, container: Container) {
        self.window = window
        self.container = container
        self.navigationController = UINavigationController()
        self.navigationController.setNavigationBarHidden(true, animated: true)
        self.window.rootViewController = navigationController
    }

    func start() {
        showSplashFlow()
    }
}

extension AppCoordinator: AppCoordinatorProtocol {

    func showSplashFlow() {
        let splashCoordinator = SplashCoordinator(
            navigationController: self.navigationController,
            container: container)
        splashCoordinator.finishDelegate = self
        splashCoordinator.start()
        childCoordinators.append(splashCoordinator)
    }

    func showHomeFlow() {
        let tabCoordinator = TabCoordinator(self.navigationController,
                                            container: container)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators
            .filter({ $0.type != childCoordinator.type })
        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()
            showHomeFlow()
        case .splash:
            navigationController.viewControllers.removeAll()
            showSplashFlow()
        default:
            break
        }
    }
}
