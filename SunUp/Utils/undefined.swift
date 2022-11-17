//
//  undefined.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 04/03/2022.
//

#if DEBUG

import Foundation

func undefined<T>(with testValue: T? = nil) -> T {
    if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil,
       let testValue = testValue {
        return testValue
    }
    
    fatalError("""
    
    <----------------------------------------------
    
        \(T.self) not defined.
    
    ---------------------------------------------->
    
    """)
}

#endif
