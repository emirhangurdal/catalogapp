import Foundation
struct CatalogueHomeData: Codable {
    let homecatalogs: [Homecatalogs?]
}
struct Homecatalogs: Codable {
    let cataloguetitle: String?
    let catalogurl: String?
    let cataloguestartpage: Int?
    let brandname: String?
    let brandurl: String?
    let catalogueurl: String?
    let image: String?
    let date: String?
}

