import Foundation

class HomeRequest: APIRequest {
	var method = RequestType.GET
	var path = "listings.json"
	var parameters = [String: String]()
	var header: [String: String] =  [
		Constants.HttpHeaderField
			.acceptType.rawValue: Constants.ContentType.json.rawValue,
		Constants.HttpHeaderField
			.contentType.rawValue: Constants.ContentType.json.rawValue
	]
}
