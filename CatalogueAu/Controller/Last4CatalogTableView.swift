
import Foundation
import UIKit


var rowLast4Catalog: Int?

class Last4CatalogTableView: UIViewController, UITableViewDelegate, UITableViewDataSource  {
   
    
    
    
    var last4CatalogManager = Last4CatalogManager()
    var label: [String]?
    
    
 
    
    let tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        last4CatalogManager.performRequest { (last4Catalog) in
            
            DispatchQueue.main.async {
                self.label = [last4Catalog[0].cataloguetitle,
                         last4Catalog[1].cataloguetitle,
                         last4Catalog[2].cataloguetitle,
                         last4Catalog[3].cataloguetitle
                ]
                self.tableView.reloadData()
            }
       
            
            
        }
        
        

       
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }
    
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let last4MenuCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        last4MenuCell.textLabel?.text = self.label?[indexPath.row]
        return last4MenuCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        rowLast4Catalog = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        last4CatalogManager.getLast4Catalog { (catalog) in
       
            DispatchQueue.main.async {
                let vc = storyboard.instantiateViewController(withIdentifier: "CatalogView2") as! ScrollVC2
                self.navigationController?.pushViewController(vc, animated: true)
                
                vc.imageArray = catalog.images!
                vc.title = catalog.title

            }
           
        }
        
      
        
        
    }
    

    
  
    
    
}
