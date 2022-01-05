//
//  ViewController.swift
//  NewsApp
//
//  Created by Avneet Kaur on 2021-12-28.
//

import UIKit


class LangVC: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UISearchBarDelegate, UIScrollViewDelegate
{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var languageCV: UICollectionView!
    var isSearched = false
    var searchedArr = [[String:String]]()
    
    let langArr = [["lang":"Arabic", "abv":"ar", "script":"الإخبارية"],["lang":"German", "abv":"de", "script":"Nachrichten"],["lang":"English", "abv":"en", "script":"News"],["lang":"Spanish", "abv":"es", "script":"Noticias"],["lang":"French", "abv":"fr", "script":"Des nouvelles"],["lang":"Hebrew", "abv":"he", "script":"חֲדָשׁוֹת"],["lang":"Italian", "abv":"it", "script":"Notizia"],["lang":"Dutch", "abv":"nl", "script":"Nieuws"],["lang":"Norwegian", "abv":"no", "script":"Nyheter"],["lang":"Portuguese", "abv":"pt", "script":"Notícias"],["lang":"Russian", "abv":"ru", "script":"Новости"],["lang":"Swedish", "abv":"se", "script":"Nyheter"],["lang":"Chinese", "abv":"zh", "script":"消息"]]
    
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        designInit()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count > 0
        {
            isSearched = true
            let filter = langArr.filter { (($0["lang"] as! String).lowercased()).contains(searchBar.text!.lowercased()) }
            searchedArr = filter
            print(searchedArr)
            languageCV.reloadData()
        }
        else
        {
            isSearched = false
            languageCV.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //there are 13 languages to choose from
        if isSearched {
            return searchedArr.count
        }
            return langArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = languageCV.dequeueReusableCell(withReuseIdentifier: "languageCell", for: indexPath) as! CollectionViewCell
        
        //cell.addshadow()
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 15
    
        var partiDict = [String:String]()
        
        if isSearched {
            partiDict = searchedArr[indexPath.row] as! [String: String]
        }
        else
        {
            partiDict = langArr[indexPath.row] as! [String: String]
        }
         
        cell.langLbl.text = "\(partiDict["lang"] as! String)"
        cell.scriptLbl.text = "\(partiDict["script"] as! String)"
        
    
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: ((self.view.frame.width) - 40), height: 80)
        
    }
    
    func designInit()
    {
        //Design components
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.layer.cornerRadius = 25
        
    }

    //only one language can be chosen
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        LANG = langArr[indexPath.row]["abv"] as! String
        self.performSegue(withIdentifier: "countrySegue", sender: nil)
        
    }
    
}



extension UICollectionViewCell {
    func addshadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.5
    }
}
