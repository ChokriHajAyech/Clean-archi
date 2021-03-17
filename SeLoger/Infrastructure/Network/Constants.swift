import Foundation

struct Constants {
	//The API's base URL
	static let baseUrl =
		URL(string: "https://gsl-apps-technical-test.dignp.com")!
	//The parameters (Queries) that we're gonna use
	struct Parameters {}
	//The header fields
	enum HttpHeaderField: String {
		case authentication = "Authorization"
		case contentType = "Content-Type"
		case acceptType = "Accept"
		case acceptEncoding = "Accept-Encoding"
	}
	//The content type (JSON)
	enum ContentType: String {
		case json = "application/json"
	}
}
