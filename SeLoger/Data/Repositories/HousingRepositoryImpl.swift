import Foundation
import RxSwift
import RxCoreData
import CoreData

final class HousingRepositoryImpl: HousingRepository {

    let service: HousingService
    let persistenceManager: PersistenceManager!
    var mapper: HousingListDAOMapper!

    init(service: HousingService, persistenceManager: PersistenceManager,
         mapper: HousingListDAOMapper) {
        self.service = service
        self.persistenceManager = persistenceManager
        self.mapper = mapper
    }

    func housinglistings() ->
        Observable<AppResult<[HousingDetails]?, AppError>> {
        return service.housinglistings()
    }

    func housingItem(identifier: Int)
        -> Observable<AppResult<HousingDetails?, AppError>> {
        return service.housingItem(identifier: identifier)
    }

    func getStoredHousingListings() ->
        Observable<AppResult<[HousingList]?, AppError>> {
        return  self.persistenceManager.managedObjectContext.rx
            .entities(HousingListCoredataModel.self, sortDescriptors: [])
            .flatMap { list -> Observable<AppResult<[HousingList]?,
                                                    AppError>>  in
                let list = list.compactMap { item -> HousingList in
                    self.mapper.mapToEntity(type: item)!
                }
                return Observable.just(AppResult.success(list))
            }
    }

    func saveHousingListings(housingList: HousingList)
        -> Observable<AppResult<Bool, AppError>> {
        do { try self.persistenceManager.managedObjectContext
            .rx.update(HousingListCoredataModel.init(housing: housingList))
            return Observable.just(AppResult.success(true))

        } catch let error {
            let apperror = AppError(message: error.localizedDescription,
                                    code: "\(error as NSError).code", status: -1)
            return Observable.just(AppResult.failure(apperror))
        }
    }

    func deleteHousingListings(housingList: HousingList)
        -> Observable<AppResult<Bool, AppError>> {
        do { try self.persistenceManager.managedObjectContext
            .rx.delete(HousingListCoredataModel.init(housing: housingList))
            return Observable.just(AppResult.success(true))

        } catch let error {
            let apperror = AppError(message: error.localizedDescription, code: "\(error as NSError).code", status: -1)
            return Observable.just(AppResult.failure(apperror))
        }
    }
}
