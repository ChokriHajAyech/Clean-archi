
import Foundation
import RxSwift

@testable import SeLoger

class HousingRepositoryMock: HousingRepository {
	
	var resultLisHousingtDetails: Observable<AppResult<[HousingDetails]?, AppError>>!
	var resultHousingtDetails: Observable<AppResult<HousingDetails?, AppError>>!
	var resultHousingtList: Observable<AppResult<[HousingList]?, AppError>>!
	var resultDB: Observable<AppResult<Bool, AppError>>!
	
	func housinglistings() -> Observable<AppResult<[HousingDetails]?, AppError>> {
		return resultLisHousingtDetails
	}
	
	func housingItem(identifier: Int) -> Observable<AppResult<HousingDetails?, AppError>> {
		return resultHousingtDetails
	}
	
	func getStoredHousingListings() -> Observable<AppResult<[HousingList]?, AppError>> {
		return resultHousingtList
	}
	
	func saveHousingListings(housingList: HousingList) -> Observable<AppResult<Bool, AppError>> {
		return resultDB
	}
	
	func deleteHousingListings(housingList: HousingList) -> Observable<AppResult<Bool, AppError>> {
		return resultDB
	}
	
	func deleteAllHousingListings() -> Observable<AppResult<Bool, AppError>> {
		return resultDB
	}
}
