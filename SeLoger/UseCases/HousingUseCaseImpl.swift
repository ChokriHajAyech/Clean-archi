import Foundation
import RxSwift

final class HousingUseCaseImpl: HousingUseCase {
    let repository: HousingRepository

    init(repository: HousingRepository) {
        self.repository = repository
    }

    func housinglistings()
	-> Observable<AppResult<[HousingDetails]?, AppError>> {
        return repository.housinglistings()
    }

    func housingItem(identifier: Int)
    -> Observable<AppResult<HousingDetails?, AppError>> {
        return repository.housingItem(identifier: identifier)
    }
}
