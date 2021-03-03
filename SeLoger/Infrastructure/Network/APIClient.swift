import Foundation
import RxSwift

class APIClient {
func send<T: Codable>(apiRequest: APIRequest)
-> Observable<ApiResult<T, ApiErrorModel>> {
return Observable<ApiResult>.create { observer in
let request = apiRequest.request(with: Constants.baseUrl)
let task = URLSession.shared
.dataTask(with: request) { (data, response, error) in
guard let statusCode = (response  as? HTTPURLResponse)?.statusCode else {
let  apiErrorMessage = ApiErrorModel(
message: "unexpected error occurred",
code: "-1",
status: -1)
observer.onNext(.failure(apiErrorMessage))
return
}

switch statusCode {
case 200 ... 299:
do {
let model: T = try JSONDecoder()
.decode(T.self, from: data ?? Data())
observer.onNext(.success(model))
} catch let error {
let  apiErrorMessage = ApiErrorModel(
message: error.localizedDescription,
code: "\((error as NSError).code )",
status: statusCode)
observer.onNext(.failure(apiErrorMessage))
}
default:
let apiErrorMessage: ApiErrorModel
do {
apiErrorMessage = try JSONDecoder()
.decode(ApiErrorModel.self,
from: data ?? Data())
} catch let error {
apiErrorMessage = ApiErrorModel(
message: error.localizedDescription,
code: "\((error as NSError).code )",
status: statusCode)
}
observer.onNext(.failure(apiErrorMessage))
}
observer.onCompleted()
}
task.resume()
return Disposables.create {
task.cancel()
}
}
}
}
