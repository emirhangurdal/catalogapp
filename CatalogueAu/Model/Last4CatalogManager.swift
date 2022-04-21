////
//  CatalogueCoverManager.swift
//  CatalogueAu
//
//  Created by Emir Gurdal on 14.04.2021.
//

import Foundation




protocol Last4CatalogManagerDelegate {
    
    func getLast4(last4Model: Last4CatalogModel)
}

var last4CatalogModel = [Last4CatalogModel]()

class Last4CatalogManager  {
    
    var selectedBrandFromMainPage: String = catalogueHomeModel[selectedRow].brand
    
    var delegate: Last4CatalogManagerDelegate?

    
    func performRequest(completionHandler: @escaping ([Last4CatalogModel]) -> Void)  {
        
        let urlString = "https://www.catalogueau.com/android/json/code.php?page=last4catalogue&brand=\(selectedBrandFromMainPage)"
        
        print(urlString)

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let decodedData = try decoder.decode(Last4CatalogData.self, from: data!)

//                        print(decodedData.latestcatalogs[1].cataloguetitle)
                     
                        
                        let last4CatalogData: [Last4CatalogModel] = [
                            Last4CatalogModel(cataloguetitle: decodedData.latestcatalogs[0].cataloguetitle, catalogueurl: decodedData.latestcatalogs[0].catalogueurl, brandurl: decodedData.latestcatalogs[0].brandurl),
                            Last4CatalogModel(cataloguetitle: decodedData.latestcatalogs[1].cataloguetitle, catalogueurl: decodedData.latestcatalogs[2].catalogueurl, brandurl: decodedData.latestcatalogs[2].brandurl),
                            Last4CatalogModel(cataloguetitle: decodedData.latestcatalogs[2].cataloguetitle, catalogueurl: decodedData.latestcatalogs[2].catalogueurl, brandurl: decodedData.latestcatalogs[2].brandurl),
                            Last4CatalogModel(cataloguetitle: decodedData.latestcatalogs[3].cataloguetitle, catalogueurl: decodedData.latestcatalogs[3].catalogueurl, brandurl: decodedData.latestcatalogs[3].brandurl)
                        ]
                        
                        last4CatalogModel = last4CatalogData
                        completionHandler(last4CatalogData)

                        
                    } catch {
                        print(error)
                        
                    
                    }
               

                return }

                      }
            

            task.resume()

        }

       
    }
    
    func getLast4Catalog(completionHandler: @escaping (CatalogViewModel) -> Void) {
        
        
        
        let brandNameFromData: String = last4CatalogModel[rowLast4Catalog!].brandurl //from catalogueHomeModel[indexPath.row] in didselectrow in Cover page.
        let brandSlugFromData: String = last4CatalogModel[rowLast4Catalog!].catalogueurl//from catalogueHomeModel[indexPath.row] in didselectrow in Cover page.
        
        
        
        let urlString = "https://www.catalogueau.com/android/json/code.php?page=displaycatalogue&brand=\(brandNameFromData)&catalogue=\(brandSlugFromData)"
        
        print(urlString)

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let decodedData = try decoder.decode(CatalogViewData.self, from: data!)

                            
                        let catalogViewModel = CatalogViewModel(images: decodedData.catalogueimages, title: decodedData.cataloguename)
                        
                        completionHandler(catalogViewModel)
                        
                        
                        
                    } catch {
                        print(error)
                        
                    
                    }
               

                return }

                      }
            

            task.resume()

        }
        
        
    }
    
    
    


}




