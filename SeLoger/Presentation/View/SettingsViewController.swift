import UIKit
import RxCocoa
import RxSwift

class SettingsViewController: BaseViewController<SettingsCoordinator, SettingsViewModel>,
                              Storyboarded, MainStoryboardLodable {

    @IBOutlet weak var switchUI: UISwitch!
    @IBOutlet weak var infoCacheLabel: UILabel!

    let disposBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        switchUI.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(switchUI.rx.value)
            .bind(to: viewModel.input.trigger)
            .disposed(by: disposBag)

        viewModel.output
            .switcher
            .drive(switchUI.rx.isOn)
            .disposed(by: disposBag)
    }

}
