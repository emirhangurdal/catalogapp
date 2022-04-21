
import Foundation
protocol CatalogViewManagerDelegate  {
    func getModel(catalogViewModel: CatalogViewModel)
}
struct CatalogViewManager {
    let brandNameFromData: String = catalogueHomeModel[selectedRow].brand //from catalogueHomeModel[indexPath.row] in didselectrow in Cover page.
    let brandSlugFromData: String = catalogueHomeModel[selectedRow].url//from catalogueHomeModel[indexPath.row] in didselectrow in Cover page.
    var delegate: CatalogViewManagerDelegate?
    func performRequestForCatalogView(completionHandler: @escaping (CatalogViewModel?) -> Void) {
        let urlString = ""
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error == nil {
                    let catalogViewModel = parseJSON(data!)
                    delegate?.getModel(catalogViewModel: catalogViewModel!)
                    completionHandler(catalogViewModel)
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                              print("Error with the response, unexpected status code: \(response)")
                              return
                          }
                    return
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ catalogueData: Data) -> CatalogViewModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CatalogViewData.self, from: catalogueData)
            let catalogViewModel = CatalogViewModel(images: decodedData.catalogueimages, title: decodedData.cataloguename)
            return catalogViewModel
        } catch {
            print(error)
            return nil
        }
    }
}

