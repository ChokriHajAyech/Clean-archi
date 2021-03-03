import Foundation
import Swinject

extension Container {
    @discardableResult
    func registerViewController<ViewController: StoryboardLodable>(
        _ controllerType: ViewController.Type,
        initCompleted: ((Swinject.Resolver, ViewController) -> Void)?  = nil)
    -> Swinject.ServiceEntry<ViewController> {
        return register(ViewController.self) { resolver in
            let storyboard = UIStoryboard(name: controllerType.storyboardName,
                                          bundle: nil)
            let name = "\(controllerType)"
                .replacingOccurrences(of: "ViewController", with: "")
            guard let viewController = storyboard
                    .instantiateViewController(withIdentifier: name)
                    as? ViewController else {
                fatalError("can't instantiate viewController")
            }
            initCompleted?(resolver, viewController)
            return viewController
        }
    }
}
