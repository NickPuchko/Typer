//
//  NetworkError.swift
//  Typography
//
//  Created by Nikolai Puchko on 15.01.2022.
//

import Foundation

enum NetworkError: Error {
  case invalid
  case generic(Error)
  case decoding(Error)
}
