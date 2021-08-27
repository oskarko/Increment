//
//  QuerySnapshotPublisher.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Combine
import Firebase

extension Publishers {
    struct QuerySnapshotPublisher: Publisher {
        typealias Output = QuerySnapshot
        typealias Failure = IncrementError
        
        private let query: Query
        
        init(query: Query) {
            self.query = query
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, IncrementError == S.Failure, QuerySnapshot == S.Input {
            let querySnapshotSubscription = QuerySnapshotSubscription(subscriber: subscriber, query: query)
            subscriber.receive(subscription: querySnapshotSubscription)
        }
        
        class QuerySnapshotSubscription<S: Subscriber>: Subscription where S.Input == QuerySnapshot, S.Failure == IncrementError {
            private var subscriber: S?
            private var listener: ListenerRegistration?
            
            init(subscriber: S, query: Query) {
                listener = query.addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        subscriber.receive(completion: .failure(.default(description: error.localizedDescription)))
                    } else if let querySnapshot = querySnapshot {
                        _ = subscriber.receive(querySnapshot)
                    } else {
                        subscriber.receive(completion: .failure(.default()))
                    }
                }
            }
            
            func request(_ demand: Subscribers.Demand) {}
            func cancel() {
                subscriber = nil
                listener = nil
            }
            
        }
    }
}
