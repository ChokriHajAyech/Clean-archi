import UIKit
import Foundation
import Swinject

class HomeCoordinator: Coordinator {

    let container: Container
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: SplashCoordinator?
    weak var finishDelegate: CoordinatorFinishDelegate?
    var type: CoordinatorType { .tab }

    init(navigationController: UINavigationController, container: Container) {
        self.container = container
        self.navigationController = navigationController
    }

    func start() {
        let viewC = container.resolve(HomeViewController.self)
        viewC?.configure(coordinator: self)
        navigationController.pushViewController(viewC!, animated: true)
    }

    func settingsSubscription() {
        let child = SettingsCoordinator(
            navigationController: navigationController, container: self.container)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }

    func favoris() {
        let child = FavorisCoordinator(navigationController: navigationController,
                                       container: self.container)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }

    func displayHousingDetails(identifier: Int) {
        let child = HousingDetailsCoordinator(
            navigationController: navigationController,
            container: self.container)
        child.identifier = identifier
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        if let child = child {
            for (index, coordinator) in childCoordinators.enumerated()
            where coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func didFinishSettingsing() {
        parentCoordinator?.childDidFinish(self)
    }
}
