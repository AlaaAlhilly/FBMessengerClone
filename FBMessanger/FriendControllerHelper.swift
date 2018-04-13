//
//  FriendControllerHelper.swift
//  FBMessanger
//
//  Created by Alaa_Naji on 7/16/16.
//  Copyright © 2016 Alaa_Naji. All rights reserved.
//

import UIKit
import CoreData
//class Friend: NSObject {
//    
//    var name:String?
//    var profileImageName:String?
//}
//class Message: NSObject {
//    
//    var text:String?
//    var date:NSDate?
//    var friend:Friend?
//}
extension FriendController {
    func clearData() {
        
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if let context = delegate?.managedObjectContext {
            do{
                let entityNames = ["Friend","Message"]
                for entityName in entityNames {
                    
                    let fetchRequest = NSFetchRequest(entityName: entityName)
                    let objects = try context.executeFetchRequest(fetchRequest) as? [NSManagedObject]
                    for object in objects! {
                        context.deleteObject(object)
                    }
                }
                try context.save()
            }catch let err{
                print(err)
            }
        }
    }
    func setupData(){
        clearData()
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if let context = delegate?.managedObjectContext{
            let mark = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
            let hillary = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
            let trump = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
            mark.name = "Mark Zukerburg"
            mark.profileImageName = "mark"
            hillary.name = "Hillary Clinton"
            hillary.profileImageName = "hillary"
            trump.name = "Donald Trump"
            trump.profileImageName = "trump"
            
            createMessageWithText("haha this is the first app you achieved", friend: mark, contex: context,minutesAgo: 1)
            createMessageWithText("Vote to me Alaa Please to Winn", friend: hillary, contex: context,minutesAgo: 3)
            createMessageWithText("did you even hear me MF, please don't forget to say hi in the ellection day its a big day for us babe please don't miss out and come on as soon as possible", friend: hillary, contex: context,minutesAgo: 2)
            createMessageWithText("Answer me and don't keep mother fuckin silent", friend: hillary, contex: context,minutesAgo: 8)
            createMessageWithText("YOU are Fired", friend: trump, contex: context,minutesAgo: 8)

            do{
                try(context.save())
            }catch let err{
                print(err)
            }
            //msg = [markMsg , hillaryMsg]
            loadData()
        }

    }
    func createMessageWithText(text:String , friend:Friend, contex:NSManagedObjectContext,minutesAgo:Double) {
        let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: contex) as! Message
        message.text = text
        message.date = NSDate().dateByAddingTimeInterval(-minutesAgo * 60)
        message.friend = friend

        
    }
    func loadData() {
        
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if let context = delegate?.managedObjectContext {
            if let friends = fetchFriend() {
                msg = [Message]()
                for frdname in friends{
                    do{
                        let fetchRequest = NSFetchRequest(entityName: "Message")
                        fetchRequest.sortDescriptors = [NSSortDescriptor(key:"date",ascending: false)]
                        fetchRequest.predicate = NSPredicate(format: "friend.name = %@" , frdname.name!)
                        fetchRequest.fetchLimit = 1
                        let fetchedMessages = try context.executeFetchRequest(fetchRequest) as? [Message]
                        msg?.appendContentsOf(fetchedMessages!)
                    }catch let err{
                        print(err)
                    }

                }
                msg = msg!.sort({$0.date!.compare($1.date!) == .OrderedDescending})
            }
         
        }
    }
    func fetchFriend() -> [Friend]? {
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        if let context = delegate?.managedObjectContext {
            do{
                
                let fetchRequest = NSFetchRequest(entityName: "Friend")
                return try context.executeFetchRequest(fetchRequest) as? [Friend]
            }catch let err{
                print (err)
            }
        }
        return nil
    }
}
