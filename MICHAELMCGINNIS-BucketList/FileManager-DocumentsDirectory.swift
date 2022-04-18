//
//  FileManager-DocumentsDirectory.swift
//  MICHAELMCGINNIS-BucketList
//
//  Created by Michael Mcginnis on 4/17/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
