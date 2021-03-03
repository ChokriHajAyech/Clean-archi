import Foundation
import RxSwift

protocol HousingUseCase {
    func housinglistings()
    -> Observable<AppResult<[HousingDetails]?, AppError>>
    func housingItem(identifier: Int)
    -> Observable<AppResult<HousingDetails?, AppError>>
}
