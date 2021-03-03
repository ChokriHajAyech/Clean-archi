import UIKit
import Swinject
import RxSwift
import RxCocoa
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    internal let container = Container()
    var appCoordinator: AppCoordinator!
    let disposeBag = DisposeBag()
    func application(_: UIApplication,
                     willFinishLaunchingWithOptions _:
                        [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        setupVCDependencies()
        setupVMDependencies()
        setupDependencies()
        return true
    }
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
                        launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    -> Bool {
        window = UIWindow()
        appCoordinator = AppCoordinator(window: window!, container: container)
        appCoordinator.start()
        window?.makeKeyAndVisible()
        return true
    }
}
