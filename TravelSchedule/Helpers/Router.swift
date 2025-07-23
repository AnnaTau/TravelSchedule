//
//  Router.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import Foundation

final class Router: ObservableObject {
    @Published var path: [Route] = []
    
    func push(route: Route) {
        path.append(route)
    }
    
    func popRoot() {
        path.removeAll()
    }
    
    func popLast() {
        path.removeLast()
    }
}
