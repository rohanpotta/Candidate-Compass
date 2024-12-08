import Foundation
import UIKit
import CoreData
import Firebase

class CDHelper {
    static let shared = CDHelper()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Candidate_Compass")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func fetchUID() -> String? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser.uid
        }
        else {
            return nil
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addFollowedCandidate(candidatename: String, profileimage: UIImage) {
        let context = persistentContainer.viewContext
        let followedCandidate = FollowedCandidate(context: context)
        followedCandidate.nameCD = candidatename
        followedCandidate.profileImageCD = profileimage.pngData()
        followedCandidate.isFollowed = true

        if let userID = CDHelper.fetchUID() {
            followedCandidate.userID = userID
        }

        saveContext()
    }
    
    func deleteFollowedCandidate(candidate: FollowedCandidate) {
        let context = persistentContainer.viewContext
        context.delete(candidate)
        saveContext()
    }
    
    func retrieveFollowedCandidates() -> [FollowedCandidate] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FollowedCandidate> = FollowedCandidate.fetchRequest()
        
        if let userID = CDHelper.fetchUID() {
            let predicate = NSPredicate(format: "userID == %@", userID)
            fetchRequest.predicate = predicate
        }
        
        do {
            let followedCandidates = try context.fetch(fetchRequest)
            return followedCandidates
        } catch {
            print("Error retrieving followed candidates: \(error)")
            return []
        }
    }
}

