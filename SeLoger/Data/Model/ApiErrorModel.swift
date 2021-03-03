import Foundation

public struct ApiErrorModel: Decodable {
    let message: String?
    let code: String?
    var status: Int?

    public init(message: String?, code: String?, status: Int) {
        self.message = message
        self.code = code
        self.status = status
    }
}
