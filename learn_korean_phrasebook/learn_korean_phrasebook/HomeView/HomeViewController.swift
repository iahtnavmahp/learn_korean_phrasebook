//
//  HomeViewController.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 25/11/2021.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCategory.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.90,height: 103)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.roundCorners([.topRight, .bottomLeft], radius: 44)
        cell.imgTitle.image = UIImage.init(named: "\(listCategory[indexPath.row].english)")
        cell.lblTitle?.text = listCategory[indexPath.row].english
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GreetingsViewController") as! GreetingsViewController
        vc.modalPresentationStyle = .fullScreen
        vc.categoryID = listCategory[indexPath.row].id
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var listCategory : [CategoryModel] = [CategoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        SQLService.shared.getDataCategory(){ result,err in
            self.listCategory.removeAll()
            if let data = result {
                for i in data {
                    if i.status == 1 {
                        self.listCategory.append(i)
                    }
                    
                }
                self.myCollectionView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
