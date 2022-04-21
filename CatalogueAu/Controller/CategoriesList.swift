//
//  CategoriesViewController.swift
//  CatalogueAu
//
//  Created by Emir Gurdal on 24.05.2021.
//

import UIKit

struct imagesDataPass {
    let brand: String
    let images: [CatalogImages]
}





var RowCategoriesListVC: Int?

class CategoriesList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    
    var catalogViewManager = CatalogViewManager()
    
    let brand: [String]
    let url: [String]
    let brandName: [String]
    
    init?(brand: [String], url: [String], brandName: [String]) {
         self.brand = brand
         self.url = url
         self.brandName = brandName
      
        super.init(nibName: nil, bundle: nil)
            
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    let tableView = UITableView()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brand.count
    
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
     
        
        categoryCell.textLabel?.text = brand[indexPath.row]
        return categoryCell
        
    }
    


    var categoriesNetworker = CategoriesNetworker()
  

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        RowCategoriesListVC = indexPath.row
       
        
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        
        categoriesNetworker.dataCatalog { (catalog) in
            
            DispatchQueue.main.sync {
                
              
                let vc = storyboard.instantiateViewController(withIdentifier: "CatalogView2") as! ScrollVC2
                self.navigationController?.pushViewController(vc, animated: true)
                vc.imageArray = catalog.images!
                vc.title = catalog.title
                
                
                
            }
            
          
            
        
            
        }
        
            
    }
        
        
//        let catalogV: (CatalogViewModel) -> Void = { catalog in
//
//
//            DispatchQueue.main.async {
//
////                vc.title = catalog.title
////                vc.imageArray = catalog.images
//                print(catalog.images)
//                print(catalog.title)
//                vc.scrollView.reloadInputViews()
//            }
//
//        }
//
//        dataCatalog(completionHandler: catalogV)
        
 
    

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
////        guard let vc = segue.destination as? ScrollViewController else {return}
//
//        if segue.identifier == "segue" {
//
//
////            let indexPath = indexPaths[0] as NSIndexPath
//
//            let vc = segue.destination as! ScrollViewController
//
//
//        }
//
//    }
    
    
    
    
    

 
    
  
 
    
    
 
    
    
    
    
}
