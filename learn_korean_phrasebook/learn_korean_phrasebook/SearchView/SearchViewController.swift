//
//  SearchViewController.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 26/11/2021.
//

import UIKit
import AVFoundation
class SearchViewController: UIViewController,UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isCount {
            return 20
        }else{
            return listdataSearch.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GreetingCollectionViewCell", for: indexPath) as! GreetingCollectionViewCell
        cell.roundCorners([.topRight, .bottomLeft], radius: 44)
        if listdataSearch.count > indexPath.row {
            cell.lblFirst?.text = listdataSearch[indexPath.row].english
            cell.lblSecond?.text = listdataSearch[indexPath.row].trans_p_female
            cell.lblThird?.text = listdataSearch[indexPath.row].trans_n_female
            cell.btnFav.tag = indexPath.row
            cell.btnPlay.tag = indexPath.row
            cell.btnFav.addTarget(self, action: #selector(addFav), for: .touchUpInside)
            cell.btnPlay.addTarget(self, action: #selector(playSound), for: .touchUpInside)
            if listdataSearch[indexPath.row].favorite == 1 {
                cell.btnFav.setBackgroundImage(UIImage.init(named: "Favorite"), for: .normal)
            }else{
                cell.btnFav.setBackgroundImage(UIImage.init(named: "UnFavorite"), for: .normal)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.90,height: 161)
    }
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    let synth = AVSpeechSynthesizer()
    var isCount : Bool = false
    var listPhrase : [PhraseModel] = [PhraseModel]()
    var listdataSearch : [PhraseModel] = [PhraseModel]()
    override func viewWillAppear(_ animated: Bool) {
        searchBar.endEditing(true)
        searchBar.text = nil
        
        listdataSearch.removeAll()
        isCount = false
        myCollectionView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GreetingCollectionViewCell", bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: "GreetingCollectionViewCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        SQLService.shared.getDataPhrase(){result,err in
            if let data = result {
                self.listPhrase = data
            }
            
        }
        searchBarSearchButtonClicked(searchBar)
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        //---------------custom search bar
        searchBar.delegate = self
        searchBar.endEditing(true)
        searchBar.placeholder = "Search"
        searchBar.layer.borderWidth = 0
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.textColor = .white
            searchBar.heightAnchor.constraint(equalToConstant: 130).isActive = true
        }
        // Do any additional setup after loading the view.
        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listdataSearch.removeAll()
        
        for x in listPhrase {
            if x.english.uppercased().contains(searchText.uppercased()){
                listdataSearch.append(x)
            }
        }
        print(listdataSearch.count)
        if listdataSearch.count > 20 {
            isCount = true
        }else{
            isCount = false
        }
        print(isCount)
        myCollectionView.reloadData()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("end searching --> Close Keyboard")
        self.searchBar.endEditing(true)
    }
    @objc func addFav(sender:UIButton){
        if listdataSearch[sender.tag].favorite == 0 {
            listdataSearch[sender.tag].favorite = 1
            SQLService.shared.addFavoritePhrase(id: listdataSearch[sender.tag].id, favorite: 1)
        }else{
            listdataSearch[sender.tag].favorite = 0
            SQLService.shared.addFavoritePhrase(id: listdataSearch[sender.tag].id, favorite: 0)
        }
        myCollectionView.reloadData()
    }
    @objc func playSound(sender:UIButton){
        PlaySound.playSound(str: listdataSearch[sender.tag].trans_n_female, synth: synth)
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

