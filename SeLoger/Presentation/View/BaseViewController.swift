import UIKit

class BaseViewController<C: Coordinator, V: BaseViewModel<C>>: UIViewController
where C: Coordinator {
    var viewModel: V!
    func configure(coordinator: C) {
        viewModel.configure(coordinator: coordinator)
    }
}
