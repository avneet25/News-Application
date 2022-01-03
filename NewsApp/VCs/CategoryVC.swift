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
    
    
    let categoryArr = ["General","Business","Entertainment","Health","Science","Sports","Technology"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.layer.cornerRadius = 25
        nextBtn.layer.cornerRadius = 25
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCV.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CollectionViewCell
        
       
        
        cell.layer.cornerRadius = 15
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOpacity = 0.5
//        cell.layer.shadowOffset = CGSize.zero
        
        cell.categoryLbl.text = categoryArr[indexPath.row]
        cell.categoryImg.image = UIImage.init(named: categoryArr[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.view.frame.width - 120)/2, height: (self.view.frame.width - 120)/2)
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        performSegue(withIdentifier: "newsSegue", sender: nil)
    }
    
}
