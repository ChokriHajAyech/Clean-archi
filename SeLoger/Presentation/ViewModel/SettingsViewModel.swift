import Foundation

class SettingsViewModel: BaseViewModel<SettingsCoordinator> {}

extension SettingsViewModel {
    func didFinishSettingsing() {
        coordinator?.didFinishSetting()
    }
}
