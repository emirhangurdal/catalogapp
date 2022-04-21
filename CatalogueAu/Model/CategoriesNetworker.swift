//
//  CategoriesNetworker.swift
//  CatalogueAu
//
//  Created by Emir Gurdal on 8.07.2021.
//

import Foundation

protocol CategoriesNetworkerDelegate {
    func categoriesCatalog(catalogViewModel: CatalogViewModel)
}





class CategoriesNetworker {

    var delegate: CategoriesNetworkerDelegate?

    var categories = CategoriesViewController()

    func dataCatalog(completionHandler: @escaping (CatalogViewModel) -> Void) {




        let brandNameFromData = categories.data[RowCategoriesVC!].brandSlugName[RowCategoriesListVC!]
        let brandSlugFromData = categories.data[RowCategoriesVC!].url[RowCategoriesListVC!]

//print(RowCategoriesVC!)
//print(RowCategoriesListVC!)
        
        let urlString: String = ""

//        print(brandNameFromData)
//        print(brandSlugFromData)
//        print(urlString)
//        print("datacatalog working")

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)

            let task = session.dataTask(with: url) {(data, response, error) in
                if error == nil {

                    let decoder = JSONDecoder()

                    do {
                        let decodedData = try decoder.decode(CatalogViewData.self, from: data!)

                        let catalogFromCategories = CatalogViewModel(images: decodedData.catalogueimages!, title: decodedData.cataloguename)

                        let catalogViewModel = catalogFromCategories
                        
                        completionHandler(catalogViewModel)

             


                    } catch {
                        print(error)


                    }

                return

                }

                }

            task.resume()

        }


    }

}


