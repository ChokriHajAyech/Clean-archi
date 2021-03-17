import Foundation

class HousingRequest: APIRequest {
	var method = RequestType.GET
	var path = "listings"
	var parameters = [String: String]()
	var header: [String: String] =  [
		Constants.HttpHeaderField
			.acceptType.rawValue: Constants.ContentType.json.rawValue,
		Constants.HttpHeaderField
			.contentType.rawValue: Constants.ContentType.json.rawValue
	]

	init(identifier: Int) {
		self.path = path + "/\(identifier).json"
	}
}
