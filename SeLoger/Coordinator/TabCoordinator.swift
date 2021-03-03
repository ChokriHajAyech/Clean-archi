import UIKit
import Swinject

class TabCoordinator: NSObject, Coordinator, TabCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var container: Container
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var type: CoordinatorType { .tab }
    required init(_ navigationController: UINavigationController,
                  container: Container) {
        self.navigationController = navigationController
        self.container = container
        self.tabBarController = .init()
    }
    func start() {
        let pages: [TabBarPageEnum] = [.home, .favorites, .settings]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }
    deinit {
        print("TabCoordinator deinit")
    }
    private func prepareTabBarController(
        withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPageEnum.home.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        navigationController.viewControllers = [tabBarController]
    }
    private func getTabController(_ page: TabBarPageEnum) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        navController.tabBarItem = UITabBarItem
            .init(title: page.pageTitleValue(),
                  image: page.pageImageIcon(),
                  tag: page.pageOrderNumber())
        switch page {
        case .home:
            let homeCoordinator = HomeCoordinator(
                navigationController: navController, container: container)
            homeCoordinator.start()
        case .favorites:
            let favorisCoordinator = FavorisCoordinator(
                navigationController: navController, container: container)
            favorisCoordinator.start()
        case .settings:
            let settingsCoordinator = SettingsCoordinator(
                navigationController: navController, container: container)
            settingsCoordinator.start()
        }
        return navController
    }
    func currentPage() -> TabBarPageEnum? {
        TabBarPageEnum.init(index: tabBarController.selectedIndex)
    }
    func selectPage(_ page: TabBarPageEnum) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPageEnum.init(index: index) else { return }
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
    }
}
