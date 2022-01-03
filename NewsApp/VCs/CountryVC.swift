//
//  CountryVC.swift
//  NewsApp
//
//  Created by Avneet Kaur on 2022-01-03.
//

import UIKit
import FlagKit

class CountryVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var countryCv: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    var isSearched = false
    
    var countryNames = [[String:Any]]()
    let countryCode = ["ar", "au","at","be","br", "bg","ca","cn","co", "cz","eg","fr","de", "gr","hk","hu","in", "id","ie","il","it", "jp","lv","lt","my", "mx","ma","nl","nz", "ng","no","ph","pl", "pt","ro","sa","rs", "sg","sk","si","za", "kr","se","ch","tw", "th","tr","ae","ua", "gb","us","ve"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designinit()
        
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
                    do {
                          let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                          let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                          if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let result = jsonResult["data"] as? [[String:Any]] {
                              countryNames = result
                              countryCv.reloadData()
                          }
                      } catch {
                         print(error)
                      }
                }
    }
    
    func designinit() {
        
        backBtn.layer.cornerRadius = 25
        nextBtn.layer.cornerRadius = 25
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.layer.cornerRadius = 25
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count > 0 {
            isSearched = true
            
        }
        else {
            isSearched = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //number of regions api provides news access to
        return countryCode.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countryCv.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! CollectionViewCell
        
        let countrycode = countryCode[indexPath.row]
        let flag = Flag(countryCode: countrycode.uppercased())!
        let styledImage = flag.image(style: .circle)
        cell.flagImg.image = styledImage
        
        let countryname = countryNames.filter {$0["code"] as! String == countrycode.uppercased()}
        let name = countryname[0]["name"] as! String
        cell.countryLbl.text = name
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.view.frame.width) - 40, height: 55)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
       performSegue(withIdentifier: "categorySegue", sender: nil)
    }
    

    
    


}
