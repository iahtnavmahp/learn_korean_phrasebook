//
//  FavViewController.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 26/11/2021.
//

import UIKit
import AVFoundation
class FavViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listFav.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GreetingCollectionViewCell", for: indexPath) as! GreetingCollectionViewCell
        cell.roundCorners([.topRight, .bottomLeft], radius: 44)
        if listFav.count > indexPath.row{
            let a = listFav[indexPath.row]
            cell.lblFirst?.text = a.english
            cell.lblSecond?.text = a.trans_p_female
            cell.lblThird?.text = a.trans_n_female
            cell.btnFav.tag = indexPath.row
            cell.btnPlay.tag = indexPath.row
            cell.btnFav.addTarget(self, action: #selector(deleteFav), for: .touchUpInside)
            cell.btnPlay.addTarget(self, action: #selector(playSound), for: .touchUpInside)
            cell.btnFav.setBackgroundImage(UIImage.init(named: "trash"), for: .normal)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.90,height: 161)
    }
    
    let synth = AVSpeechSynthesizer()
    var listFav : [PhraseModel] = [PhraseModel]()
    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        listFav.removeAll()
        SQLService.shared.getDataPhrase(){result,err in
            if let data = result {
                for i in data {
                    if i.favorite == 1{
                        self.listFav.append(i)
                    }
                    
                }
                self.myCollectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GreetingCollectionViewCell", bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: "GreetingCollectionViewCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @objc func deleteFav(sender:UIButton){
        SQLService.shared.addFavoritePhrase(id: listFav[sender.tag].id, favorite: 0)
        self.listFav.remove(at: sender.tag)
        myCollectionView.reloadData()
        
    }
    @objc func playSound(sender:UIButton){
        
        PlaySound.playSound(str: listFav[sender.tag].trans_n_female, synth: synth)
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
