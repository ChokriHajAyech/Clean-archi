import UIKit

protocol TabCoordinatorProtocol {
    var tabBarController: UITabBarController { get set }
    func selectPage(_ page: TabBarPageEnum)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabBarPageEnum?
}
