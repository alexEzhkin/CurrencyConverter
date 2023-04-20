//
//  EventManager.swift
//  Currency Converter
//
//  Created by AndUser on 20/04/2023.
//

import Foundation
import RxSwift

class EventManager {
    static let shared = EventManager()
    private let successSubject = PublishSubject<Transaction>()
    private let failureSubject = PublishSubject<Transaction>()
    
    func notifySuccess(transaction: Transaction) {
        successSubject.onNext(transaction)
    }
    
    func notifyFailure(transaction: Transaction) {
        failureSubject.onNext(transaction)
    }
    
    func observeSuccess() -> Observable<Transaction> {
        return successSubject.asObservable()
    }
    
    func observeFailure() -> Observable<Transaction> {
        return failureSubject.asObservable()
    }
}
