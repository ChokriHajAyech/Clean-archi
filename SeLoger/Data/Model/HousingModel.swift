import Foundation

struct HousingModel: Codable {

	let identifier: Int?
	let bedrooms: Int?
	let city: String?
	let area: Float
	let url: String?
	let price: Float?
	let professional: String?
	let propertyType: String?
	let rooms: Int?

	enum CodingKeys: String, CodingKey {
		case identifier = "id"
		case bedrooms
		case city
		case area
		case url
		case price
		case professional
		case propertyType
		case rooms
	}
}
