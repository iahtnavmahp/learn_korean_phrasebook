//
//  PhraseModel.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 26/11/2021.
//

import Foundation
class PhraseModel : NSObject {
    var id :Int = 0
    var category_id : Int = 0
    var english : String = ""
    var trans_p_female :String = ""
    var trans_n_female :String = ""
    var favorite : Int?
    var status : Int = 0
    init(id:Int,category_id:Int,english:String,trans_p_female:String,trans_n_female :String,favorite : Int,status : Int) {
        self.id = id
        self.category_id = category_id
        self.english = english
        self.trans_p_female = trans_p_female
        self.trans_n_female = trans_n_female
        self.favorite = favorite
        self.status = status
    }
}
