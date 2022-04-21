
import Foundation
struct CatalogViewData: Codable {
    let catalogueimages: [CatalogImages]?
    let shareurl: String?
    let cataloguestartpage: Int?
    let cataloguename: String
}
struct CatalogImages: Codable {
    let image: String?
}





