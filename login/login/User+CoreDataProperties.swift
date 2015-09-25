//
//  User+CoreDataProperties.swift
//  login
//
//  Created by 李昊 on 15/9/24.
//  Copyright © 2015年 李昊. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var username: String?
    @NSManaged var password: String?

}
