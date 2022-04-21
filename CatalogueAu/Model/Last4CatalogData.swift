//
//  Last4CatalogData.swift
//  CatalogueAu
//
//  Created by Emir Gurdal on 7.07.2021.
//

import Foundation

struct Last4CatalogData: Codable {
    
    let latestcatalogs: [LatestCatalogs]
}

struct LatestCatalogs: Codable {
    
    let brandurl: String
    let cataloguetitle: String
    let catalogueurl: String
    let image: String
    let date: String
    let cataloguestartpage: Int
    
}

//MARK:- Model:



struct Last4CatalogModel: Codable {
    let cataloguetitle: String
    let catalogueurl: String
    let brandurl: String
}
