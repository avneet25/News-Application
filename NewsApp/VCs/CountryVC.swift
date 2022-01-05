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
    
    var Count = Int()
    var isSearched = false
    var selectedCcode = [String]()
    var allCountries =     [["name":"Argentina", "abv": "ar"],  //stores data of all available countries
                            ["name":"Australia", "abv": "au"],
                            ["name":"Austria", "abv": "at"],
                            ["name":"Belgium", "abv": "be"],
                            ["name":"Brazil", "abv": "br"],
                            ["name":"Bulgaria", "abv": "bg"],
                            ["name":"Canada", "abv": "ca"],
                            ["name":"China", "abv": "cn"],
                            ["name":"Colombia", "abv": "co"],
                            ["name":"Czech Republic", "abv": "cz"],
                            ["name":"Egypt", "abv": "eg"],
                            ["name":"France", "abv": "fr"],
                            ["name":"Germany", "abv": "de"],
                            ["name":"Greece", "abv": "gr"],
                            ["name":"Hong Kong", "abv": "hk"],
                            ["name":"Hungary", "abv": "hu"],
                            ["name":"India", "abv": "in"],
                            ["name":"Indonesia", "abv": "id"],
                            ["name":"Ireland", "abv": "ie"],
                            ["name":"Israel", "abv": "il"],
                            ["name":"Itlay", "abv": "it"],
                            ["name":"Japan", "abv": "jp"],
                            ["name":"Latvia", "abv": "lv"],
                            ["name":"Lithuania", "abv": "lt"],
                            ["name":"Malaysia", "abv": "my"],
                            ["name":"Mexico", "abv": "mx"],
                            ["name":"Morocco", "abv": "ma"],
                            ["name":"Netherlands", "abv": "nl"],
                            ["name":"new Zealand", "abv": "nz"],
                            ["name":"Nigeria", "abv": "ng"],
                            ["name":"Norway", "abv": "no"],
                            ["name":"Philippines", "abv": "ph"],
                            ["name":"Poland", "abv": "pl"],
                            ["name":"Portugal", "abv": "pt"],
                            ["name":"Romania", "abv": "ro"],
                            ["name":"Saudi Arabia", "abv": "sa"],
                            ["name":"Serbia", "abv": "rs"],
                            ["name":"Singapore", "abv": "sg"],
                            ["name":"Slovakia", "abv": "sk"],
                            ["name":"Slovenia", "abv": "si"],
                            ["name":"South Africa", "abv": "za"],
                            ["name":"South Korea", "abv": "kr"],
                            ["name":"Sweden", "abv": "se"],
                            ["name":"Switzerland", "abv": "ch"],
                            ["name":"Taiwan", "abv": "tw"],
                            ["name":"Thailand", "abv": "th"],
                            ["name":"Turkey", "abv": "tr"],
                            ["name":"United Arab Emirates", "abv": "ae"],
                            ["name":"Ukraine", "abv": "ua"],
                            ["name":"United Kingdom", "abv": "gb"],
                            ["name":"United States", "abv": "us"],
                            ["name":"Venezuela", "abv": "ve"]]
    var currentCountries = [[String:Any]]() //stores country data of the current UI

    override func viewDidLoad() {
        super.viewDidLoad()
        designinit()
        Count = 0 //default selection
        currentCountries = allCountries //initially no search initiated so current UI has data of all countries
    }
    
    func designinit() {
        
        backBtn.layer.cornerRadius = 25
        nextBtn.layer.cornerRadius = 25
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.layer.cornerRadius = 25
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchBar.text!.count > 0
        {
            isSearched = true
            let filter = allCountries.filter {($0["name"]?.lowercased() as! String).contains(searchBar.text!.lowercased())}
            currentCountries = filter
            countryCv.reloadData()
        }
        else
        {
            isSearched = false
            currentCountries = allCountries
            countryCv.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //number of regions api provides news access to
        return currentCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countryCv.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! CollectionViewCell

        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .clear
        
        let countrycode = currentCountries[indexPath.row]["abv"] as! String
        let countryName = currentCountries[indexPath.row]["name"] as! String
        if selectedCcode.contains(countrycode) {
            cell.backgroundColor = .red
        }
       
        let flag = Flag(countryCode: countrycode.uppercased())!
        let styledImage = flag.image(style: .circle)
        cell.flagImg.image = styledImage
        cell.countryLbl.text = countryName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = countryCv.cellForItem(at: indexPath)
        
    
        if  cell?.backgroundColor == .clear && Count < 3 {
            Count += 1
            cell?.backgroundColor = .red
            selectedCcode.append(currentCountries[indexPath.row]["abv"] as! String)
        }
    
        else if (cell?.backgroundColor == .red) {
            
            cell?.backgroundColor = .clear
            Count -= 1
            let codeStr = currentCountries[indexPath.row]["abv"] as! String
            selectedCcode.removeAll {$0 == codeStr }
        }
        
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.view.frame.width) - 40, height: 55)
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
       
    }
    
    @IBAction func nextAction(_ sender: Any)
    {
        if selectedCcode.isEmpty {
            CCODE.append("us") //default
        }
        else {
            CCODE = selectedCcode
        }
        performSegue(withIdentifier: "categorySegue", sender: nil)
    }
    

    


}
