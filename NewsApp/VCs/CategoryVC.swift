//
//  CategoryVC.swift
//  NewsApp
//
//  Created by Avneet Kaur on 2022-01-02.
//

import UIKit

class CategoryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    

    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    var selectCateg = [String]()
    var Count = Int()
   
    let categoryArr = ["General","Business","Entertainment","Health","Science","Sports","Technology"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.layer.cornerRadius = 25
        nextBtn.layer.cornerRadius = 25
        Count = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCV.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CollectionViewCell

        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 15
        cell.categoryLbl.text = categoryArr[indexPath.row]
        cell.categoryImg.image = UIImage.init(named: categoryArr[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = categoryCV.cellForItem(at: indexPath)
        let partiCat = categoryArr[indexPath.row].lowercased()
       
            if cell?.backgroundColor == .clear
            {
                cell?.backgroundColor = .red
                Count += 1
                selectCateg.append(partiCat)
            }
            else
            {
                cell?.backgroundColor = .clear
                Count -= 1
                selectCateg.removeAll {$0 == partiCat}
            }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.view.frame.width - 120)/2, height: (self.view.frame.width - 120)/2)
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any)
    {
        if selectCateg.contains("general") || Count == 0 || Count >= 6
        {
            selectCateg.removeAll(keepingCapacity: false)
            selectCateg.append("general")
        }
        
    
        performSegue(withIdentifier: "newsSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsSegue"{
            let vc2 = segue.destination as! NewslistVC
            vc2.Categ = selectCateg
        }
    }
    
}
