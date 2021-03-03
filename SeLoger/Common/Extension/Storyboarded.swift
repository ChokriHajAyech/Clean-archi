import Foundation
import UIKit

// MARK: - protocol

protocol Storyboarded: StoryboardLodable {
    static func instantiate() -> Self
}
protocol StoryboardLodable {
    @nonobjc static var storyboardName: String { get }
}
protocol MainStoryboardLodable: StoryboardLodable {}
protocol SplashStoryboardLodable: StoryboardLodable {}

// MARK: - Extension

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName =  String(describing: self)
        let className = fullName.components(separatedBy: ".").last!
        let storyBoard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("can't instantiate viewController")
        }
        return viewController
    }
}

extension MainStoryboardLodable where Self: UIViewController {
    static var storyboardName: String {
        return "Main"
    }
}

extension SplashStoryboardLodable where Self: UIViewController {
    static var storyboardName: String {
        return "Splash"
    }
}
