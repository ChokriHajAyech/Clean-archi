import Foundation
import RxSwift

@testable import SeLoger

class HousingServiceMock: HousingService {

	var housinglistingsResullt:
		Observable<AppResult<[HousingDetails]?, AppError>>!
	var housingItem:
		Observable<AppResult<HousingDetails?, AppError>>!

	func housinglistings()
	-> Observable<AppResult<[HousingDetails]?, AppError>> {
		return housinglistingsResullt
	}

	func housingItem(identifier: Int)
	-> Observable<AppResult<HousingDetails?, AppError>> {
		return housingItem
	}
}
