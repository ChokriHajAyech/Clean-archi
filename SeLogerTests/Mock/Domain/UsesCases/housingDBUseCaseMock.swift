//
//  housingDBUseCaseMock.swift
//  SeLogerTests
//
//  Created by Mobiapps on 04/03/2021.
//  Copyright © 2021 AYECH. All rights reserved.
//

import Foundation
import RxSwift

@testable import SeLoger

class HousingDBUseCaseMock: HousingDBUseCase {
	var resultDB: Observable<AppResult<Bool, AppError>>!
	var resultHousingtList: Observable<AppResult<[HousingList]?, AppError>>!

	func getStoredHousingListings() -> Observable<AppResult<[HousingList]?, AppError>> {
		
		resultHousingtList = Observable.just(AppResult.success([HousingList(identifier: 0, propertyType: "", area: 230, price: 23490, city: "Paris", urlImage: "https://www.img.com", isSelected: true)]))
		
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
