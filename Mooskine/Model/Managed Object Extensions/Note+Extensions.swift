//
//  Note+Extensions.swift
//  Mooskine
//
//  Created by Rafael Calunga on 2018-08-26.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import CoreData

extension Note {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.creationDate = Date()
    }
}
