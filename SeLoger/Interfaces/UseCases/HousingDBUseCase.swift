import Foundation
import RxSwift

protocol HousingDBUseCase {
    func getStoredHousingListings() ->
    Observable<AppResult<[HousingList]?, AppError>>
    func saveHousingListings(housingList: HousingList)
    -> Observable<AppResult<Bool, AppError>>
    func deleteHousingListings(housingList: HousingList)
    -> Observable<AppResult<Bool, AppError>>
    func deleteAllHousingListings()
        -> Observable<AppResult<Bool, AppError>>
}
