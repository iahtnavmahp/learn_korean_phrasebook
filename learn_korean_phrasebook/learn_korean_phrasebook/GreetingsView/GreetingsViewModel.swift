//
//  GreetingsViewModel.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 26/11/2021.
//

import Foundation
typealias Completion = (Bool, String) -> Void
class GreetingsViewModel {
    var listGreetings : [PhraseModel] = [PhraseModel]()
    
    func loadGreetings(categoryID : Int,completion: @escaping Completion){
        listGreetings.removeAll()
        SQLService.shared.getDataPhrase(){result,err in
            if let data = result {
                for i in data {
                    if i.category_id == categoryID {
                        self.listGreetings.append(i)
                    }
                }
                completion(true,"load sucess")
            }else{
                completion(false,"load fail")
            }
        }
    }
    func addFav(idx:Int,isFav :Int){
        
        SQLService.shared.addFavoritePhrase(id: listGreetings[idx].id, favorite: isFav)
    }
}
