import Foundation

struct HomeModel: Codable {
	let items: [HousingModel]
	let totalCount: Int
}
