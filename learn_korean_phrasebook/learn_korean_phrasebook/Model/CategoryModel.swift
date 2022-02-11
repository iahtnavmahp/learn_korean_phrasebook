//
//  CategoryModel.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 26/11/2021.
//

import Foundation
class CategoryModel {
    var id : Int = 0
    var english : String = ""
    var thumbnail : String = ""
    var status : Int = 0
    var weight : Int = 0
    
    init(id:Int ,english:String ,thumbnail:String ,status:Int,weight:Int) {
        self.id = id
        self.english = english
        self.thumbnail = thumbnail
        self.status = status
        self.weight = weight
    }
}
