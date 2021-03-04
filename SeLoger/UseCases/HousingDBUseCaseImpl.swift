import Foundation
import RxSwift

final class HousingDBUseCaseImpl: HousingDBUseCase {
    let repository: HousingRepository
    init(repository: HousingRepository) {
        self.repository = repository
    }
    func getStoredHousingListings() ->
    Observable<AppResult<[HousingList]?, AppError>> {
        return repository.getStoredHousingListings()
    }

    func saveHousingListings(housingList: HousingList)
    -> Observable<AppResult<Bool, AppError>> {
        return repository.saveHousingListings(housingList: housingList)
    }
    func deleteHousingListings(housingList: HousingList)
    -> Observable<AppResult<Bool, AppError>> {
        return repository.deleteHousingListings(housingList: housingList)
    }
    func deleteAllHousingListings()
    -> Observable<AppResult<Bool, AppError>> {
        return repository.deleteAllHousingListings()
    }
}
