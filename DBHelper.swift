//
//  DBHelper.swift
//  reflexionCompanyTask
//
//  Created by Mac on 11/01/23.
//

import Foundation
import CoreData
import UIKit
class DBHelper{
//MARK - insert the movie record into the local database
    func insertData(title: String,year:Double,runtime : Double,cast:String){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let MovieeEntity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
      
        let Moviee = NSManagedObject(entity: MovieeEntity!, insertInto: managedContext )
        
        Moviee.setValue(title, forKey: "title")
        Moviee.setValue(year, forKey: "year")
        Moviee.setValue(runtime, forKey: "runtime")
        Moviee.setValue(cast, forKey: "cast")
        
    do{
        try managedContext.save()
        print("insert succ..")
    }catch let error as NSError{
        print("The data cannot be saved -\(error)")
    }
}
// MARK - retrived record of movies
    func retriveMovieeRecords() -> [MovieList]{
        var result : [MovieList] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Data not found")
            return result
        
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        
        do{
            let fetchResult = try managedContext.fetch(fetchRequest)
            
            for eachFetchResult in fetchResult as! [NSManagedObject]{
                print("The Movie Record \(eachFetchResult.value(forKey: "title"))")
                print("The Movie Record \(eachFetchResult.value(forKey: "year"))")
                print("The Movie Record \(eachFetchResult.value(forKey: "runtime"))")
                print("The Movie Record \(eachFetchResult.value(forKey: "cast"))")
            }
        }catch{
            print("Failed to extract Employee Records")
        }
        return result
    }
}
