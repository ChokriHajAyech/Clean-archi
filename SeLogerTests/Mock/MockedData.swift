//
//  MockedData.swift
//  SeLogerTests
//
//  Created by Mobiapps on 04/03/2021.
//  Copyright © 2021 AYECH. All rights reserved.
//

import Foundation

@testable import SeLoger

class MockedData {
	func getListHousingDetails() -> [HousingDetails] {
		var housingDetails: [HousingDetails]
		let mapper = HousingMapper()
		var result: HomeModel!

		guard let pathString = Bundle(for: type(of: self)).path(forResource: "Housing", ofType: "json") else {
			fatalError("HomeModel.json not found")
		}
		
		let fileUrl = URL(fileURLWithPath: pathString)
		guard let data = try? Data(contentsOf: fileUrl) else {
			fatalError("Unable to convert HomeModel.json to data")
		}
		
		do {
			result = try JSONDecoder().decode(HomeModel.self, from: data)
		} catch {
			fatalError("Get HomeModel failed with error: \(error)")
		}

		housingDetails = result.items.compactMap { item -> HousingDetails in
			mapper.mapToEntity(type: item)!
		}
		return housingDetails
	}
}
