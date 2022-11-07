//
//  Extension+URLSessionError.swift
//  Pokemon
//
//  Created by Consultant on 6/17/22.
//

import Foundation

extension URLSession{
    enum RequestError:Error{
        case invalidUrl
        case errorDecode
        case failed(error: Error)
        case unknownError
    }
}
