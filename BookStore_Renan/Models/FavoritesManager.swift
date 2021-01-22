//
//  FaveritesManager.swift
//  BookStore_Renan
//
//  Created by Renan Baialuna on 22/01/21.
//

import Foundation
import UIKit


struct FavoritesManager {
    let appDelegate: AppDelegate!
    
    init(appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
        
    }
    
    func saveFavorite(_ id: String) {
        let context = appDelegate.persistentContainer.viewContext
        let newFavorite = Favorites(context: context)
        newFavorite.id = id
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func deleteFavorite(_ id: String) {
        let context = appDelegate.persistentContainer.viewContext
        if let fav = getFavorite(id) {
            context.delete(fav)
            do {
                try context.save()
            } catch {

            }
        }
    }
    
    func getFavorite(_ id: String) -> Favorites? {
        let allFavorites = getAllFavorites()
        if let favorite = allFavorites.first(where: {$0.id == id}) {
            return favorite
        }
        return nil
    }
    
    func getAllFavorites() -> [Favorites] {
        let context = appDelegate.persistentContainer.viewContext
        var favorites: [Favorites] = []
        do {
            favorites = try context.fetch(Favorites.fetchRequest())
            return favorites
        } catch {
            
        }
        return favorites
    }
    
}
