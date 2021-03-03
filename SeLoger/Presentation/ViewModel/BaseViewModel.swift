import Foundation

class BaseViewModel <C: Coordinator> {
    var coordinator: C?

    func configure(coordinator: C) {
        self.coordinator = coordinator
    }
}
