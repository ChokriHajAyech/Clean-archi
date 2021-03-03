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

    struct Input {}
    struct Output {
        var housingListDataCell: Driver<[HousingList]>
    }

    private let validateSubject = PublishSubject<Int>()
    var disposeBag = DisposeBag()

    init(housingDBUseCase: HousingDBUseCase, persistenceManager: PersistenceManager) {
        self.housingDBUseCase = housingDBUseCase
        self.persistenceManager = persistenceManager

        super.init()

        // Output
        let res = self.housingDBUseCase
            .getStoredHousingListings()
            .flatMap { data -> Driver<[HousingList]> in
                switch data {
                case .success(let list):
                    return Driver.from(optional: list)
                case .failure:
                    return Driver.from([])
                }
            }.asDriver(onErrorJustReturn: [])
        self.output = Output(housingListDataCell: res)
    }
}
