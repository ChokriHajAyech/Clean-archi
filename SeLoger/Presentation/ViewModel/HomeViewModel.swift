import Foundation
import RxSwift
import RxCocoa
import RxCoreData
import CoreData

protocol HomeViewModelBindable {
    func bind(to viewModel: HomeViewModel)
    var disposeBag: DisposeBag? { get }
}

class HomeViewModel: BaseViewModel<HomeCoordinator>, ViewModelType {

    var housingUseCase: HousingUseCase!
    var housingDBUseCase: HousingDBUseCase!
    var mapper: HousingDataCellMapper!
    var persistenceManager: PersistenceManager!

    private(set) var input: Input!
    private(set) var output: Output!

    struct Input {
        let trigger: AnyObserver<Void>
        let validate: AnyObserver<Int>
        let search: AnyObserver<String>
    }

    struct Output {
        var housingListDataCell: Driver<[HousingList]>
    }

    private var offersList = BehaviorRelay<[HousingList]>(value: [])
    public var rxOffers: Observable<[HousingList]> {
        return offersList.asObservable()
    }

    private let appearSubject = PublishSubject<Void>()
    private let validateSubject = PublishSubject<Int>()
    private let searchSubject = PublishSubject<String>()

    var disposeBag = DisposeBag()

    init(housingUseCase: HousingUseCase, housingDBUseCase: HousingDBUseCase,
         mapper: HousingDataCellMapper, persistenceManager: PersistenceManager) {
        super.init()
        self.housingUseCase = housingUseCase
        self.housingDBUseCase = housingDBUseCase
        self.mapper = mapper
        self.persistenceManager = persistenceManager

        // input
        self.input = Input( trigger: appearSubject.asObserver(),
                            validate: validateSubject.asObserver(),
                            search: searchSubject.asObserver())

        // Output

        let res =  getAllHousingData()
        res.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: offersList)
            .disposed(by: disposeBag)

        let driverForSeaarch = Driver.combineLatest(
            searchSubject.asDriver(onErrorJustReturn: ""), res)
        let targets = searchHousing(driver: driverForSeaarch)
        targets.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: offersList)
            .disposed(by: disposeBag)

        let driverForFavorites = Driver.combineLatest(
            validateSubject.asDriver(onErrorJustReturn: -1), res)
        let action = addToFavorites(driver: driverForFavorites)

        action.asObservable().observeOn(MainScheduler.instance)
            .bind(to: offersList)
            .disposed(by: disposeBag)
        self.output = Output(housingListDataCell: res)
    }

    func getAllHousingData() -> Driver<[HousingList]> {
        appearSubject.flatMap({ [self] list -> Observable<[HousingList]> in
            return housingUseCase.housinglistings()
                .map { [self] data -> [HousingList] in
                    switch data {
                    case .success(let list):
                        let list = list?.compactMap { item -> HousingList in
                            self.mapper.mapFromEntity(type: item)!
                        }
                        return list ?? [HousingList]()
                    case .failure:
                        return [HousingList]()
                    }
                }.flatMap { list -> Observable<
                    (AppResult<[HousingList]?, AppError>, [HousingList])> in
                  return Observable.combineLatest(
                        self.housingDBUseCase.getStoredHousingListings(),
                        Observable.just(list))
                }.map { (data, list) -> [HousingList] in
                    switch data {
                    case .success(let storedList):
                        var listObject = list

                        storedList?.forEach({ housingStored in
                            if let row = listObject.firstIndex(where: {$0.identifier == housingStored.identifier}) {
                                listObject[row] = housingStored
                            }
                        })
                        return listObject
                    case .failure:
                        return [HousingList]()
                    }
                }
        }).asDriverOnErrorJustComplete()

    }

    func addToFavorites(driver: Driver<(Int, [HousingList])>)
    -> Driver<[HousingList]> {
        validateSubject.withLatestFrom(driver)
            .observeOn(MainScheduler.instance)
            .flatMap { identifier, list -> Observable<(AppResult<Bool, AppError>,
                                    HousingList, [HousingList])> in
                let filtered = list.filter { housing in
                    return housing.identifier == identifier
                }
                if let housingElement = filtered.first {
                    var housing = housingElement

                    if housing.isSelected ?? false {

                        return Observable.combineLatest(
                            self.housingDBUseCase
                                .deleteHousingListings(housingList: housing),
                            Observable.just(housing), Observable.just(list))
                    }
                    housing.isSelected = true
                    return Observable.combineLatest(
                        self.housingDBUseCase
                            .saveHousingListings(housingList: housing),
                        Observable.just(housing), Observable.just(list))
                }
                return Observable.empty()
            }.map {(_, selectedObject, list) -> [HousingList] in
                var listObject = list
                if let row = listObject
                    .firstIndex(where: {
                                    $0.identifier == selectedObject.identifier}) {
                    listObject[row] = selectedObject
                }
                return listObject
            }.asDriver(onErrorJustReturn: [])
    }

    func displayHousingDetails(identifier: Int) {
        coordinator?.displayHousingDetails(identifier: identifier)
    }

    func searchHousing(driver: Driver<(String, [HousingList])>)
    -> Driver<[HousingList]> {
        searchSubject
            .startWith("")
            .distinctUntilChanged()
            .withLatestFrom(driver)
            .map({ (search, targets) -> [HousingList] in
                return targets.filter({
                    $0.city?.hasPrefix(search) ?? false
                        || $0.city?.contains(search) ?? false
                        || ("\(String(describing: $0.price))".hasPrefix(search))
                        || ("\(String(describing: $0.price))".contains(search))
                        || ("\(String(describing: $0.area))".hasPrefix(search))
                        || ("\(String(describing: $0.area))".contains(search))
                        ||  $0.propertyType!.hasPrefix(search)
                        ||  $0.propertyType!.contains(search)
                })
            }).asDriver(onErrorJustReturn: [])
    }
}
