import Foundation
import RxSwift

protocol HousingRepository {
    func housinglistings()
    -> Observable<AppResult<[HousingDetails]?, AppError>>
    func housingItem(identifier: Int)
    -> Observable<AppResult<HousingDetails?, AppError>>

    //Stored housing data
    func getStoredHousingListings()
    -> Observable<AppResult<[HousingList]?, AppError>>
    func saveHousingListings(housingList: HousingList)
    -> Observable<AppResult<Bool, AppError>>
    func deleteHousingListings(housingList: HousingList)
    -> Observable<AppResult<Bool, AppError>>
    func deleteAllHousingListings()
        -> Observable<AppResult<Bool, AppError>>
}
