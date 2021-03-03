import Foundation
import RxSwift
import RxCocoa

class HousingDetailsViewModel: BaseViewModel<HousingDetailsCoordinator>,
                               ViewModelType {
    var housingUseCase: HousingUseCase!
    struct Input {
        let identifier: AnyObserver<Int>
    }
    struct Output {
        var housing: Driver<HousingDetails?>
    }

    var disposeBag = DisposeBag()
    private(set) var input: Input!
    private(set) var output: Output!
    private let identifier = ReplaySubject<Int>.create(bufferSize: 1)

    init(housingUseCase: HousingUseCase) {
        super.init()
        self.housingUseCase = housingUseCase

        //input init
        input = Input(identifier: identifier.asObserver())

        //output init
        let res = identifier.flatMap { identifier -> Driver<HousingDetails?> in

            return housingUseCase.housingItem(identifier: identifier)
                .map { data -> HousingDetails? in
                    switch data {
                    case .success(let housing):
                        return housing
                    case .failure:
                        return  nil
                    }
                }.asDriver(onErrorJustReturn: nil)
        }.asDriver(onErrorJustReturn: nil)
        self.output = Output(housing: res)
    }
}
