import Foundation
import RxSwift

class SplashViewModel: BaseViewModel<SplashCoordinator> {}

extension SplashViewModel {
    func showMain() {
        coordinator?.showMain()
    }
}
