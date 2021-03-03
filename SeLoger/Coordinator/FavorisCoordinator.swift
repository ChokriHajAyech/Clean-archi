import UIKit
import Foundation
import Swinject

class FavorisCoordinator: Coordinator {
    let container: Container
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: HomeCoordinator?
    weak var finishDelegate: CoordinatorFinishDelegate?
    var type: CoordinatorType { .tab }
    init(navigationController: UINavigationController, container: Container) {
        self.container = container
        self.navigationController = navigationController
    }
    func start() {
        let viewC = container.resolve(FavorisViewController.self)
        viewC?.configure(coordinator: self)
        navigationController.pushViewController(viewC!, animated: true)
    }
    func didFinishSettingsing() {
        parentCoordinator?.childDidFinish(self)
    }
    func finish() {
        //
    }
}
