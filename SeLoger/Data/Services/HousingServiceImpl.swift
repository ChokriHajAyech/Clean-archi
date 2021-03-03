import Foundation
import RxSwift

final class HousingServiceImpl: HousingService {
    var api: HousingApi
    let mapper: HousingMapper

    init(api: HousingApi, mapper: HousingMapper) {
        self.api = api
        self.mapper = mapper
    }

    func housinglistings() -> Observable<AppResult<[HousingDetails]?, AppError>> {
        return api.housinglistings().map { data in
            switch data {
            case .success(let list):
                let list = list.items.compactMap { item -> HousingDetails in
                    self.mapper.mapToEntity(type: item)!
                }
                return AppResult.success(list)
            case .failure(let error):
                let error = AppError(message: error.message, code: error.code,
                                     status: error.status)
                return AppResult.failure(error)
            }
        }
    }

    func housingItem(identifier: Int)
    -> Observable<AppResult<HousingDetails?, AppError>> {
        return api.housingItem(identifier: identifier).map { [self] data  in
            switch data {
            case .success(let item):
                return  AppResult.success(self.mapper.mapToEntity(type: item))
            case .failure(let error):
                let error = AppError(message: error.message,
                                     code: error.code, status: error.status)
                return AppResult.failure(error)
            }
        }
    }
}
