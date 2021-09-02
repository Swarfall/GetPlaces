//
//  CustomError.swift
//  Megakit
//
//  Created by Viacheslav Savitskyi on 31.08.2021.
//

import Foundation

enum CustomError: Error {
    case tryAgain
    case defaultError
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .tryAgain:
            return NSLocalizedString("Try again", comment: "Try again")
        case .defaultError:
            return NSLocalizedString("Oooopps", comment: "Oooopps")
        }
    }
}
