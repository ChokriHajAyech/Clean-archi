import Foundation
import RxSwift

public final class HousingApi {

    var apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func housinglistings()
    -> Observable<ApiResult<HomeModel, ApiErrorModel>> {
        return apiClient.send(apiRequest: HomeRequest())
    }

    func housingItem(identifier: Int)
    -> Observable<ApiResult<HousingModel, ApiErrorModel>> {
        return apiClient.send(apiRequest: HousingRequest(identifier: identifier))
    }
}
