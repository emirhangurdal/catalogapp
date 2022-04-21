//
//  ViewController.swift
//  CatalogueAu
//
//  Created by Emir Gurdal on 9.04.2021.
//

import UIKit

protocol VCDelegate  {

}

var selectedRow = 0



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredData = [CatalogueHomeModel]()
    var delegate: VCDelegate?
    @IBOutlet var tableView: UITableView!
    var catalogueCoverManager = CatalogueCoverManager()
//    var catalogViewManager = CatalogViewManager()
        override func viewDidLoad() {
        super.viewDidLoad()
            self.tableView.keyboardDismissMode = .onDrag
            filteredData = catalogueHomeModel
            searchBar.delegate = self
            self.navigationController?.isNavigationBarHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                self.navigationController?.isNavigationBarHidden = false
            })
            self.navigationController?.isToolbarHidden = true
            let nib = UINib(nibName: "CatalogueTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "CatalogueTableViewCell")
            tableView.delegate = self
            tableView.dataSource = self
//            catalogViewManager.delegate = self
            catalogueCoverManager.delegate = self
//         catalogViewManager.performRequestForCatalogView()
            createSpinnerView()
            addLogo()
            
            catalogueCoverManager.performRequest() { [weak self] (x) in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
    }
    //MARK: - SearchBarMethods
    
    var isFiltering: Bool = false
    func searchBar(_ searchBarF: UISearchBar, textDidChange searchText: String) {
        searchBarF.text = searchBar.text
        if searchText.isEmpty {
            filteredData.removeAll()
            isFiltering = false
        } else {
            filteredData = searchText.isEmpty ? catalogueHomeModel : catalogueHomeModel.filter({ (catalogueHomeModel) -> Bool in
                return catalogueHomeModel.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
            isFiltering = true
        }
        tableView.reloadData()
    }

//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.searchBar.endEditing(true)
//    }

//MARK: - Logo and Spinner
    func createSpinnerView() {
        let child = SpinnerViewController()
        child.spinner.backgroundColor = .clear
        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    lazy var navigationTitleImageView = UIImageView()
    func addLogo() {
            self.navigationTitleImageView.image = UIImage(named: "1024LogoNav")
            self.navigationTitleImageView.contentMode = .scaleAspectFit
            self.navigationTitleImageView.translatesAutoresizingMaskIntoConstraints = false
            if let navC = self.navigationController{
                navC.navigationBar.addSubview(self.navigationTitleImageView)
                self.navigationTitleImageView.centerXAnchor.constraint(equalTo: navC.navigationBar.centerXAnchor).isActive = true
                self.navigationTitleImageView.centerYAnchor.constraint(equalTo: navC.navigationBar.centerYAnchor, constant: 0).isActive = true
                self.navigationTitleImageView.widthAnchor.constraint(equalTo: navC.navigationBar.widthAnchor, multiplier: 0.2).isActive = true
                self.navigationTitleImageView.heightAnchor.constraint(equalTo: navC.navigationBar.widthAnchor, multiplier: 0.088).isActive = true
            }
    }
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      self.navigationTitleImageView.removeFromSuperview()
  }
    
    override func viewWillAppear(_ animated: Bool) {
        addLogo()
    }

//MARK: - CatalogViewDataPass
    
    struct CatalogView {
        let brand: [String]
        let images: [String]
       
    }
    
// MARK: - Tableview Funcs

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredData.count : catalogueHomeModel.count
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "CatalogView", sender: indexPath)
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let catalogueCell = tableView.dequeueReusableCell(withIdentifier: "CatalogueTableViewCell",
                                                              for: indexPath) as! CatalogueTableViewCell
        let coverURLString = isFiltering ? filteredData[indexPath.row].image : catalogueHomeModel[indexPath.row].image
//        let coverURLString = filteredData[indexPath.row].image
        catalogueCell.catalogueTitle.text = isFiltering ? filteredData[indexPath.row].title : catalogueHomeModel[indexPath.row].title
        
        catalogueCell.catalogueCover.downloaded(from: coverURLString)
        return catalogueCell
        }
}

//MARK: - CatalogueCoverNetworkerDelegate

extension ViewController: CatalogueCoverManagerDelegate {
    func getModelCover(catalogueHomeModel: [CatalogueHomeModel]) {
    }
   }

//MARK: - UIIMAGEVIEW EXTENSION

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                    self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func url(_ url: String?) {
        DispatchQueue.global().async { [weak self] in
            guard let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            func setImage(image:UIImage?) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            let urlToString = url.absoluteString as NSString
            if let cachedImage = ImageStore.imageCache.object(forKey: urlToString) {
                setImage(image: cachedImage)
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageStore.imageCache.setObject(image, forKey: urlToString)
                    setImage(image: image)
                    
                   
                }
            }else {
                setImage(image: nil)
            }
        }
    }
}




    



