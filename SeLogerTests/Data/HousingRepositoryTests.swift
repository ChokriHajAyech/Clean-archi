
import Foundation
import Quick
import Nimble
import RxTest
import RxBlocking
import RxSwift

@testable import SeLoger

class HousingRepositoryTests: QuickSpec {
	override func spec() {
		describe("check all HousingRepository scenarios") {
		
		var housingRepository: HousingRepository!
		var housingServiceMock: HousingServiceMock!
		var observableTest: Observable<AppResult<[HousingDetails]?, AppError>>!
		var mockedListHousinDetails: [HousingDetails]!
		var persistenceManager: PersistenceManager!
			var mapper: HousingListDAOMapper!
			
		beforeEach {
			housingServiceMock = HousingServiceMock()
			mockedListHousinDetails = MockedData().getListHousingDetails()
			persistenceManager = PersistenceManager()
			mapper = HousingListDAOMapper()
		}
		
		it("succes fetch all housing, call housinglistings service")	{
			housingRepository = HousingRepositoryImpl(service: housingServiceMock, persistenceManager: persistenceManager, mapper: mapper)
			observableTest = Observable.just(.success(mockedListHousinDetails))
			housingServiceMock.housinglistingsResullt = observableTest
			let result = try? housingRepository.housinglistings().toBlocking()
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
