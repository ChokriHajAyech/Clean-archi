import Foundation
import RxSwift
import RxCocoa
import RxCoreData
import CoreData

class FavoritesViewModel: BaseViewModel<FavorisCoordinator>, ViewModelType {

    var persistenceManager: PersistenceManager!
    var mapper: HousingListDAOMapper!
    var housingDBUseCase: HousingDBUseCase!

    private(set) var input: Input!
    private(set) var output: Output!

    struct Input {
        let trigger: AnyObserver<Void>
    }

    struct Output {
        var housingListDataCell: Driver<[HousingList]>
        var reload: Driver<Void>
    }

    private let validateSubject = PublishSubject<Int>()
    private let triggerSubject = PublishSubject<Void>()
    var disposeBag = DisposeBag()

    init(housingDBUseCase: HousingDBUseCase, persistenceManager: PersistenceManager) {
        self.housingDBUseCase = housingDBUseCase
        self.persistenceManager = persistenceManager

        super.init()

        self.input = Input(trigger: triggerSubject.asObserver())

        let reload = self.triggerSubject.asDriver(onErrorJustReturn: ())

        // Output
        let res = triggerSubject.flatMap { _  -> Driver<[HousingList]> in
            return self.housingDBUseCase
                .getStoredHousingListings()
                .flatMap { data -> Driver<[HousingList]> in
                    switch data {
                    case .success(let list):
                        return Driver.from(optional: list)
                    case .failure:
                        return Driver.from([])
                    }
                }.asDriverOnErrorJustComplete()
        }.asDriverOnErrorJustComplete()
        self.output = Output(housingListDataCell: res, reload: reload)
    }
}
