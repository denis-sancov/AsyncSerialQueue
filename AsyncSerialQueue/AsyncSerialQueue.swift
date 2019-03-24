//
//  AsyncSerialQueue.swift
//  AsyncSerialQueue
//
//  Created by Denis Sancov on 24/03/2019.
//  Copyright © 2019 Denis Sancov. All rights reserved.
//

import Foundation

final class AsyncSerialQueue {
    typealias Task = (_ callback: @escaping () -> Void) -> Void
    
    private lazy var semaphore = DispatchSemaphore(value: 0)
    private lazy var tasks = [Task]()
    
    private(set) var active = false
    
    func enqueue(_ task: @escaping Task) {
        if active {
            abort()
        }
        tasks.append(task)
    }
    
    func execute(on finish: (() -> Void)? = nil) {
        guard active == false else {
            abort()
            return
        }
        
        active = true
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let ref = self else { return }
            
            for task in ref.tasks {
                guard ref.active else {
                    break
                }
                
                DispatchQueue.main.async {
                    task() {
                        ref.semaphore.signal()
                    }
                }
                
                ref.semaphore.wait()
            }
            
            ref.tasks.removeAll(keepingCapacity: true)
            ref.active = false
            
            if let callback = finish {
                DispatchQueue.main.async(execute: callback)
            }
        }
    }
    
    func abort() {
        tasks.removeAll()
        active = false
    }
}
