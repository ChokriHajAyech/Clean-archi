import Foundation

final class NetworkProvider {
    public func makeHousingNetwork() -> HousingApi {
        let apiCLient = APIClient()
        return HousingApi(apiClient: apiCLient)
    }
}
