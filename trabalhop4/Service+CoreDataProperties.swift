//
//  Service+CoreDataProperties.swift
//  TrabalhoP4
//
//  Created by SP4 on 07/06/17.
//  Copyright © 2017 Tiago Pestana. All rights reserved.
//

import Foundation
import CoreData


extension Service {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Service> {
        return NSFetchRequest<Service>(entityName: "Service")
    }

    @NSManaged public var endDate: NSDate?
    @NSManaged public var requestDate: NSDate?
    @NSManaged public var startDate: NSDate?
    @NSManaged public var requestDescription: String?
    @NSManaged public var requestTitle: String?

}
