import Foundation

public enum RequestType: String {
	case GET, POST
}

protocol APIRequest {
	var method: RequestType { get }
	var path: String { get }
	var parameters: [String: String] { get }
	var header: [String: String] { get set }
}

extension APIRequest {
	func request(with baseURL: URL) -> URLRequest {
		guard var components = URLComponents(
			url: baseURL.appendingPathComponent(path),
			resolvingAgainstBaseURL: false
		) else {
			fatalError("Unable to create URL components")
		}
		components.queryItems = parameters.map {
			URLQueryItem(name: String($0), value: String($1))
		}
		guard let url = components.url else {
			fatalError("Could not get url")
		}
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
		header.forEach { (key, value) in
			request.setValue(value, forHTTPHeaderField: key)
		}
		return request
	}
}
