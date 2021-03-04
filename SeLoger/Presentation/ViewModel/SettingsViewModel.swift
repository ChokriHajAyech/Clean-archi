import Foundation
import RxSwift
import RxCocoa

class SettingsViewModel: BaseViewModel<SettingsCoordinator>, ViewModelType {

    var housingDBUseCase: HousingDBUseCase!
    var mapper: HousingDataCellMapper!
    var persistenceManager: PersistenceManager!

    private(set) var input: Input!
    private(set) var output: Output!

    struct Input {
        let trigger: AnyObserver<Bool>
    }

    struct Output {
        var switcher: Driver<Bool>
    }

    private let switchSubject = PublishSubject<Bool>()

    init(housingDBUseCase: HousingDBUseCase,
         persistenceManager: PersistenceManager) {
        self.housingDBUseCase = housingDBUseCase
        self.persistenceManager = persistenceManager

        // input
        self.input = Input(trigger: switchSubject.asObserver())

        // output

        let switcher = switchSubject.flatMap({ _ -> Observable<Bool> in
            return housingDBUseCase.deleteAllHousingListings()
                .flatMap { data -> Observable<Bool> in
                    switch data {
                    case .success(let res):
                        return Observable.just(res)
                    case .failure:
                        return  Observable.just(false)
                    }
                }
        }).asDriverOnErrorJustComplete()

        self.output = Output(switcher: switcher)

    }
}

extension SettingsViewModel {
    func didFinishSettingsing() {
        coordinator?.didFinishSetting()
    }
}
