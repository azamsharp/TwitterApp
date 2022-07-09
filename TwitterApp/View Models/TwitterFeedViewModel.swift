//
//  TwitterFeedScreenViewModel.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/8/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TwitterFeedViewModel: BaseViewModel {
    
    var db: Firestore
    @Published var tweets = [Tweet]()
    
    init(db: Firestore = Firestore.firestore()) {
        self.db = db
        super.init()
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
     
        db.collection("tweets")
            .addSnapshotListener { [weak self] documentSnapshot, error in
                
                guard let snapshot = documentSnapshot else {
                    return
                }
                
                guard let documents = snapshot.documents else {
                    return
                }
                
                self?.tweets = documents.compactMap { doc in
                    try? doc.data(as: Tweet.self)
                }
            }
    }
    
}
