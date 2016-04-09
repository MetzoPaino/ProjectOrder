//
//  ProtocolManager.swift
//  Project Order
//
//  Created by William Robinson on 09/04/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation

protocol Injectable {
    associatedtype CollectionModelAlias
    func inject(collection: CollectionModelAlias)
    func assertDependencies()
}