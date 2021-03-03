import Foundation
import UIKit
import Swinject

class SplashCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    let container: Container
    weak var finishDelegate: CoordinatorFinishDelegate?
    var type: CoordinatorType { .splash }
    init(navigationController: UINavigationController, container: Container) {
        self.container = container
        self.navigationController = navigationController
    }

    func start() {
        let viewC = container.resolve(SplashViewController.self)!
        viewC.configure(coordinator: self)
        self.navigationController.pushViewController(viewC, animated: false)
    }

    deinit {
        print("SplashCoordinator deinit")
    }

    func showMain() {
        let tabCoordinator = TabCoordinator(self.navigationController,
                                            container: container)
        tabCoordinator.finishDelegate = nil
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }

    func childDidFinish(_ child: Coordinator?) {
        if let child = child {
            for (index, coordinator) in childCoordinators
                .enumerated() where coordinator === child {
                    childCoordinators.remove(at: index)
                    break
            }
        }
    }
}
