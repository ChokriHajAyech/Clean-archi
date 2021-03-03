import Foundation
import UIKit
import Swinject

class HousingDetailsCoordinator: Coordinator {

    weak var parentCoordinator: HomeCoordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    let container: Container
    weak var finishDelegate: CoordinatorFinishDelegate?
    var type: CoordinatorType { .housingDetails }
    var identifier: Int = -1

    init(navigationController: UINavigationController, container: Container) {
        self.container = container
        self.navigationController = navigationController
    }
    func start() {
        let viewC = container.resolve(HousingDetailsViewController.self)!
        viewC.configure(coordinator: self, identifier: identifier)
        self.navigationController.pushViewController(viewC, animated: true)
    }

    deinit {
        print("SplashCoordinator deinit")
    }

    func childDidFinish(_ child: Coordinator?) {
        if let child = child {
            for (index, coordinator) in childCoordinators.enumerated()  where coordinator === child {
                    childCoordinators.remove(at: index)
                    break
            }
        }
    }
}
