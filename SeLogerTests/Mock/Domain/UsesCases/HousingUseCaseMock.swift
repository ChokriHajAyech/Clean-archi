//
//  HousingUseCaseMock.swift
//  SeLogerTests
//
//  Created by Mobiapps on 04/03/2021.
//  Copyright © 2021 AYECH. All rights reserved.
//

import Foundation
import RxSwift

@testable import SeLoger

class HousingUseCaseMock: HousingUseCase {
	
	var housinglistingsResullt:
		Observable<AppResult<[HousingDetails]?, AppError>>!
	var housingItemResult:
		Observable<AppResult<HousingDetails?, AppError>>!
	var getHousinglistingsCalled = false
	var getHousingItemCalled = false

	func housinglistings() -> Observable<AppResult<[HousingDetails]?, AppError>> {
		getHousinglistingsCalled = true
		housinglistingsResullt = Observable.just(AppResult.success([HousingDetails(identifier: 0, bedrooms: 2, city: "paris", area: 233.0, image: "http://img.com", price: 413.0, propertyType: "", rooms: 3)]))
		return housinglistingsResullt
	}
	
	func housingItem(identifier: Int) -> Observable<AppResult<HousingDetails?, AppError>> {
		getHousingItemCalled = true
		return housingItemResult
	}
	
	
}
