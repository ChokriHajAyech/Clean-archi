import Foundation
import UIKit
import Swinject

class SettingsCoordinator: Coordinator {
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
        let viewC = container.resolve(SettingsViewController.self)
        viewC?.configure(coordinator: self)
        navigationController.pushViewController(viewC!, animated: false)
    }
    func didFinishSetting() {
        parentCoordinator?.childDidFinish(self)
    }
}
