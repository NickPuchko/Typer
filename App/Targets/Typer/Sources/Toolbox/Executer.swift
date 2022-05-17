//
//  Executer.swift
//  Typography
//
//  Created by Nikolai Puchko on 15.01.2022.
//

import Foundation

protocol Executer {
  associatedtype Action
  func execute(action: Action) async
}
