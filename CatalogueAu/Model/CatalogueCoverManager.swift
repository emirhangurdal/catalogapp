////
//  CatalogueCoverManager.swift
//  CatalogueAu
//
//  Created by Emir Gurdal on 14.04.2021.
//

import Foundation


protocol CatalogueCoverManagerDelegate {
    func getModelCover(catalogueHomeModel: [CatalogueHomeModel])
}
var catalogueHomeModel = [CatalogueHomeModel]()
class CatalogueCoverManager  {
    static let shared = CatalogueCoverManager()
    var delegate: CatalogueCoverManagerDelegate?
    func performRequest(completionHandler: @escaping ([CatalogueHomeModel]) -> Void)  {
        let urlString = ""
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    guard let httpResponse = response as? HTTPURLResponse,
                              (200...299).contains(httpResponse.statusCode) else {
                      print("Error with the response, unexpected status code: \(response)")
                      return
                    }
                    if let safeData = data {
                        catalogueHomeModel = self.parseJSON(safeData)
                        completionHandler(catalogueHomeModel)
                    }
                return }
                      }
            task.resume()
        }
    }

    func parseJSON(_ catalogueData: Data) -> [CatalogueHomeModel] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CatalogueHomeData.self, from: catalogueData)
             var imageArray = [CatalogueHomeModel]()
//            print(decodedData.homecatalogs[0]!.brandurl!)
//            print(decodedData.homecatalogs[0]!.catalogueurl!)
//            let image = UIImage(decodedData.homecatalogs[0]!.image!)
            let image1 = CatalogueHomeModel(title: decodedData.homecatalogs[0]!.cataloguetitle!, image:decodedData.homecatalogs[0]!.image!, brand: decodedData.homecatalogs[0]!.brandurl!, url: decodedData.homecatalogs[0]!.catalogueurl!, brandName: decodedData.homecatalogs[0]!.brandname! )
           
            let image2 = CatalogueHomeModel(title: decodedData.homecatalogs[1]!.cataloguetitle!, image:decodedData.homecatalogs[1]!.image!, brand: decodedData.homecatalogs[1]!.brandurl!, url: decodedData.homecatalogs[1]!.catalogueurl!, brandName: decodedData.homecatalogs[1]!.brandname! )
            
            let image3 = CatalogueHomeModel(title: decodedData.homecatalogs[2]!.cataloguetitle!, image:decodedData.homecatalogs[2]!.image!, brand: decodedData.homecatalogs[2]!.brandurl!, url: decodedData.homecatalogs[2]!.catalogueurl!, brandName: decodedData.homecatalogs[2]!.brandname! )
            
            let image4 =  CatalogueHomeModel(title: decodedData.homecatalogs[3]!.cataloguetitle!, image:decodedData.homecatalogs[3]!.image!, brand: decodedData.homecatalogs[3]!.brandurl!, url: decodedData.homecatalogs[3]!.catalogueurl!, brandName: decodedData.homecatalogs[3]!.brandname! )
            
            let image5 = CatalogueHomeModel(title: decodedData.homecatalogs[4]!.cataloguetitle!, image:decodedData.homecatalogs[4]!.image!, brand: decodedData.homecatalogs[4]!.brandurl!, url: decodedData.homecatalogs[4]!.catalogueurl!, brandName: decodedData.homecatalogs[4]!.brandname! )
            
            let image6 = CatalogueHomeModel(title: decodedData.homecatalogs[5]!.cataloguetitle!, image:decodedData.homecatalogs[5]!.image!, brand: decodedData.homecatalogs[5]!.brandurl!, url: decodedData.homecatalogs[5]!.catalogueurl!, brandName: decodedData.homecatalogs[5]!.brandname! )
            
            let image7 = CatalogueHomeModel(title: decodedData.homecatalogs[6]!.cataloguetitle!, image:decodedData.homecatalogs[6]!.image!, brand: decodedData.homecatalogs[6]!.brandurl!, url: decodedData.homecatalogs[6]!.catalogueurl!, brandName: decodedData.homecatalogs[6]!.brandname! )
            
            let image8 = CatalogueHomeModel(title: decodedData.homecatalogs[7]!.cataloguetitle!, image:decodedData.homecatalogs[7]!.image!, brand: decodedData.homecatalogs[7]!.brandurl!, url: decodedData.homecatalogs[7]!.catalogueurl!, brandName: decodedData.homecatalogs[7]!.brandname! )
            
            let image9 = CatalogueHomeModel(title: decodedData.homecatalogs[8]!.cataloguetitle!, image:decodedData.homecatalogs[8]!.image!, brand: decodedData.homecatalogs[8]!.brandurl!, url: decodedData.homecatalogs[8]!.catalogueurl!, brandName: decodedData.homecatalogs[8]!.brandname! )
           
//            let image10 = CatalogueHomeModel(title: decodedData.homecatalogs[9]!.cataloguetitle!, image:decodedData.homecatalogs[9]!.image!, brand: decodedData.homecatalogs[9]!.brandurl!, url: decodedData.homecatalogs[9]!.catalogueurl! )
            imageArray = [image1, image2, image3, image4, image5, image6, image7, image8, image9]


       return imageArray



        } catch {
            print(error)
        }

        return []

    }
    
   
   
  



}




