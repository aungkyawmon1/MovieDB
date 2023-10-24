//
//  BaseRepository.swift
//  MovieDB
//
//  Created by solinx on 24/10/2023.
//

import Foundation
import RealmSwift
import RxSwift

class BaseRepository: NSObject {
    
    override init() {
        super.init()
    }
    let disposeBag = DisposeBag()
    
    let realmInstance = try! Realm()

    func clearAllData() {
        // Delete all objects from the realm
        do {
            try realmInstance.write {
                realmInstance.deleteAll()
            }
        } catch {
            debugPrint("Something went wrong!")
        }
        
    }
    
}
