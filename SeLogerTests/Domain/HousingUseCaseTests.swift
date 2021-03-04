
import Foundation
import Quick
import Nimble
import RxTest
import RxBlocking
import RxSwift

@testable import SeLoger

class HousingUseCaseTests: QuickSpec {
	override func spec() {
		describe("check all HousingUseCase scenarios") {
		
		var housingUseCase: HousingUseCase!
		var housingRepositoryMock: HousingRepositoryMock!
		var observableTest: Observable<AppResult<[HousingDetails]?, AppError>>!
		var mockedListHousinDetails: [HousingDetails]!

		beforeEach {
			housingRepositoryMock = HousingRepositoryMock()
			mockedListHousinDetails = MockedData().getListHousingDetails()
		}
		
		it("succes fetch all housing")	{
			housingUseCase = HousingUseCaseImpl(repository: housingRepositoryMock)
			observableTest = Observable.just(.success(mockedListHousinDetails))
			housingRepositoryMock.resultLisHousingtDetails = observableTest
			let result = try? housingUseCase.housinglistings().toBlocking()
				.first()?.value as? [HousingDetails]
			let expectedResult = try? observableTest.toBlocking().first()?.value as? [HousingDetails]
			expect(result?.first?.identifier)
				.to(equal(expectedResult?.first?.identifier))
			expect(result?.first?.rooms)
				.to(equal(expectedResult?.first?.rooms))
		}
	}
	}
}
