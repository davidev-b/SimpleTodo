//
//  Task.swift
//  SimpleTodo
//
//  Created by David B. on 28.11.20.
//

import Foundation
import CoreData

@objc(Task)

public class Task : NSManagedObject
{
    @NSManaged var title                : String
    @NSManaged var isDone               : Bool
    @NSManaged var createdAt            : Date
    @NSManaged var details              : String
}

