//
//  GreetingsViewController.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 26/11/2021.
//

import UIKit
import AVFoundation
class GreetingsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GreetingsModel.listGreetings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GreetingCollectionViewCell", for: indexPath) as! GreetingCollectionViewCell
        cell.roundCorners([.topRight, .bottomLeft], radius: 44)
        let a = GreetingsModel.listGreetings[indexPath.row]
        cell.lblFirst?.text = a.english
        cell.lblSecond?.text = a.trans_p_female
        cell.lblThird?.text = a.trans_n_female
        cell.btnFav.tag = indexPath.row
        cell.btnPlay.tag = indexPath.row
        cell.btnFav.addTarget(self, action: #selector(addFav), for: .touchUpInside)
        cell.btnPlay.addTarget(self, action: #selector(playSound), for: .touchUpInside)
        if a.favorite == 1 {
            
            cell.btnFav.setBackgroundImage(UIImage.init(named: "Favorite"), for: .normal)
        }else{
            cell.btnFav.setBackgroundImage(UIImage.init(named: "UnFavorite"), for: .normal)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.90,height: 161)
    }
    let synth = AVSpeechSynthesizer()
    let GreetingsModel = GreetingsViewModel()
    var categoryID : Int = 0
    
    var listGreetings : [PhraseModel] = [PhraseModel]()
    @IBOutlet weak var myConllectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GreetingCollectionViewCell", bundle: nil)
        myConllectionView.register(nib, forCellWithReuseIdentifier: "GreetingCollectionViewCell")
        myConllectionView.delegate = self
        myConllectionView.dataSource = self
        // Do any additional setup after loading the view.
        loadGreetings(categoryID: categoryID)
        
    }
    
    func loadGreetings(categoryID : Int){
        GreetingsModel.loadGreetings(categoryID:categoryID ){(done,msg) in
            if done {
                self.myConllectionView.reloadData()
            }else{
                print(msg)
            }
        }
    }
    
    @IBAction func btnDismiss(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    @objc func addFav(sender:UIButton){
        
        if GreetingsModel.listGreetings[sender.tag].favorite == 0 {
            GreetingsModel.listGreetings[sender.tag].favorite = 1
            GreetingsModel.addFav(idx: sender.tag, isFav: 1)
            
        }else{
            
            GreetingsModel.listGreetings[sender.tag].favorite = 0
            GreetingsModel.addFav(idx: sender.tag, isFav: 0)
        }
        myConllectionView.reloadData()
    }
    @objc func playSound(sender:UIButton){
        
        PlaySound.playSound(str: GreetingsModel.listGreetings[sender.tag].trans_n_female, synth: synth)
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
