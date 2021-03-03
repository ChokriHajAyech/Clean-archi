import UIKit
import Foundation
import CoreLocation
import RxSwift

class SplashViewController: BaseViewController<SplashCoordinator, SplashViewModel>,
    SplashStoryboardLodable, Storyboarded {
    override func viewDidLoad() {
        viewModel.showMain()
    }
}
