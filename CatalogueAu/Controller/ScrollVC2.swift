
import UIKit
import SafariServices




class ScrollVC2: UIViewController {
   
    
    
    
    @IBAction func bookmarkTapped() {
        
        let vc = SFSafariViewController(url: URL(string: "https://www.catalogueau.com/")!)
        present(vc, animated: true)
    }
    
   
  
    var categoriesNetworker = CategoriesNetworker()
    
   
   
    @IBOutlet weak var textField: UITextField!
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let page = UIView()
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var shareButtonItem: UIBarButtonItem!
    
    
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        shareTapped(sender: self)
    }
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        
 
        categoriesCatalog()
        createSpinnerView()
        pageControl.backgroundColor = .clear
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        toolBar.backgroundColor = .clear
        
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        
                view.addSubview(scrollView)
                view.addSubview(toolBar)
                
                view.addSubview(pageControl)
                addConstraints()
        
  
                
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        
        scrollView.setContentOffset(CGPoint(x: CGFloat(current)*view.frame.size.width, y: 0), animated: false)
        
        
    }
    
   
    func addConstraints() {
        let constraints: [NSLayoutConstraint] = [
            toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
//         toolBar.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: toolBar.topAnchor, constant: -5),
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    
]
        NSLayoutConstraint.activate(constraints)
    }
    func createSpinnerView() {
        let child = SpinnerViewController()
        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if scrollView.subviews.count == 2 {
            configureScrollView()
    }
    }
    @objc func shareTapped(sender: AnyObject) {
        let ActivityItem : NSURL = NSURL(string: "https://www.catalogueau.com")!
        let vc : UIActivityViewController = UIActivityViewController(
            activityItems: [ActivityItem], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = shareButtonItem
        self.present(vc, animated: true, completion: nil)
}
    
//MARK:- Image Array and For
    
    var imageArray = [CatalogImages]()
    func categoriesCatalog() {
        DispatchQueue.main.async {
           
           for i in 0..<self.imageArray.count {
            let imageView = UIImageView()
            imageView.url(self.imageArray[i].image!)
            imageView.contentMode = .scaleAspectFit
            let xPosition = Int(self.view.frame.width)*(i)
            imageView.frame = CGRect(x: CGFloat(xPosition), y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            self.page.frame = CGRect(x: 0, y: 0, width: imageView.frame.size.width*CGFloat(i+1), height: imageView.frame.size.height)
            self.page.backgroundColor = .clear
            self.pageControl.numberOfPages = self.imageArray.count
            self.scrollView.contentSize.width = self.view.frame.width*CGFloat(i + 1)
            self.scrollView.contentSize = self.page.frame.size
            self.page.isUserInteractionEnabled = true
            imageView.isUserInteractionEnabled = true
            self.page.addSubview(imageView)
            self.scrollView.addSubview(self.page)
               }
        }
   }
    //MARK: - Configure ScrollView
     func configureScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        scrollView.isUserInteractionEnabled = true
        scrollView.maximumZoomScale = 5
        scrollView.minimumZoomScale = 1
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
     }
}

//MARK:- UIScrollViewDelegate Exte.


extension ScrollVC2: UIScrollViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
        
        self.textField.text = String(self.pageControl.currentPage)
        
        }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      
       

        return page
        
    }
    
    
}





