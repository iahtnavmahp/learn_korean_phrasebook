//
//  SQLService.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 26/11/2021.
//

import Foundation
import SQLite
extension FileManager {
    func copyfileToUserDocumentDirectory(forResource name: String,
                                         ofType ext: String) throws -> String
    {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: ext),
           let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                              .userDomainMask,
                                                              true).first {
            let fileName = "\(name).\(ext)"
            let fullDestPath = URL(fileURLWithPath: destPath)
                .appendingPathComponent(fileName)
            let fullDestPathString = fullDestPath.path
            
            if !self.fileExists(atPath: fullDestPathString) {
                try self.copyItem(atPath: bundlePath, toPath: fullDestPathString)
                
            }
            return fullDestPathString
        }
        return ""
    }
}
class SQLService:NSObject {
    static let shared: SQLService = SQLService()
    var DatabaseRoot:Connection?
    
    
     var DataCategory:[CategoryModel] = [CategoryModel]()
     var DataPhrase:[PhraseModel] = [PhraseModel]()
    
    func loadInit(linkPath:String){     do {
        let fileManager = FileManager.default
        let dbPath = try fileManager.copyfileToUserDocumentDirectory(forResource: "DB_Korea", ofType: "db")
        DatabaseRoot = try Connection ("\(dbPath)")
    }catch{
        DatabaseRoot = nil
        let nserror = error as NSError
        print("Cannot connect to Databace. Error is: \(nserror), \(nserror.userInfo)")
    }
    
    }
    
    func getDataCategory(closure: @escaping (_ response: [CategoryModel]?, _ error: Error?) -> Void) {
        let users1 = Table("category")
        let id1 = Expression<Int>("_id")
        let english1 = Expression<String>("english")
        let thumbnail1 = Expression<String>("thumbnail")
        let status1 = Expression<Int>("status")
        let weight1 = Expression<Int>("weight")
        
        DataCategory.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users1) {
                    DataCategory.append(CategoryModel(id: user[id1],
                                                      english: user[english1],
                                                      thumbnail: user[thumbnail1],
                                                      status: user[status1], weight: user[weight1]))
                }
            } catch  {}
        }
        closure(DataCategory, nil)
    }
    func getDataPhrase(closure: @escaping (_ response: [PhraseModel]?, _ error: Error?) -> Void) {
        let users1 = Table("phrase")
        let id1 = Expression<Int>("_id")
        let category_id1 = Expression<Int>("category_id")
        let english1 = Expression<String>("english")
        let trans_p_female1 = Expression<String>("trans_p_female")
        let trans_n_female1 = Expression<String>("trans_n_female")
        let favorite1 = Expression<Int>("favorite")
        let status1 = Expression<Int>("status")
        DataPhrase.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users1) {
                    DataPhrase.append(PhraseModel(id: user[id1]
                                                  , category_id: user[category_id1], english: user[english1], trans_p_female: user[trans_p_female1], trans_n_female: user[trans_n_female1],favorite: user[favorite1], status: user[status1]))
                }
            } catch  {}
        }
        closure(DataPhrase, nil)
    }
    func addFavoritePhrase(id:Int, favorite:Int) -> Void {
        let users = Table("phrase")
        let fav = Expression<Int>("favorite")
        let id1 = Expression<Int>("_id")
        
        if let DatabaseRoot = DatabaseRoot {
            do {
                let alice = users.filter(id1 == id)
                try DatabaseRoot.run(alice.update(fav <- favorite))
            } catch{
                print(error)
                return
            }
        }
        
    }
    
    
}
