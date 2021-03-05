import Foundation
import Quick
import Nimble
import RxTest
import RxBlocking
import RxSwift

@testable import SeLoger

class HomeViewModelTests: QuickSpec {
	override func spec() {
		
		describe("Test HomeViewModel") {
			
			var viewModel: HomeViewModel!
			var housingUseCaseMocked: HousingUseCaseMock!
			var housingDBUseCaseMocked: HousingDBUseCaseMock!
			var housingDataCellMapper: HousingDataCellMapper!
			var persistenceManager: PersistenceManager!

			beforeEach {
				housingUseCaseMocked = HousingUseCaseMock()
				housingDBUseCaseMocked = HousingDBUseCaseMock()
				housingDataCellMapper = HousingDataCellMapper()
				persistenceManager = PersistenceManager()
				
				viewModel = HomeViewModel(housingUseCase: housingUseCaseMocked, housingDBUseCase: housingDBUseCaseMocked, mapper: housingDataCellMapper, persistenceManager: persistenceManager)
			}
			
			it("succes fetch all housing") {
				// act
				viewModel.input.trigger.onNext(())
				
				// assert
				assert(housingUseCaseMocked.getHousinglistingsCalled)
				let expectedResult = try? housingUseCaseMocked.housinglistingsResullt .toBlocking().first()?.value as? [HousingDetails]
				  expect("paris").to(equal(expectedResult?.first?.city))
			}
		}
	}
}

