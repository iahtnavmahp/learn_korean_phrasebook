//
//  MoreViewController.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 26/11/2021.
//

import UIKit

class MoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCollectionViewCell", for: indexPath) as! MoreCollectionViewCell
        cell.lblMore?.text = listArr[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
                    vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }else if indexPath.row == 1{
            if let urlStr = NSURL(string: "https://apps.apple.com/app/id1596335932") {
                let objectsToShare = [urlStr]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

                if UIDevice.current.userInterfaceIdiom == .pad {
                    if let popup = activityVC.popoverPresentationController {
                        popup.sourceView = self.view
                        popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                    }
                }
                self.present(activityVC, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.85,height: 60)
    }
    
    @IBOutlet weak var constrainTop: NSLayoutConstraint!
    @IBOutlet weak var viewRadius: UIView!
    let listArr = ["About","Share this app"]
    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        constrainTop.constant = view.frame.height/4
        let nib = UINib(nibName: "MoreCollectionViewCell", bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: "MoreCollectionViewCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        viewRadius.layer.cornerRadius = 20
        
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
