import Firebase

class FirestoreService {
    static let shared = FirestoreService()
    
    private init() {}
    
    private let db = Firestore.firestore()
    
    private let collectionName = "users"
    
    private let queue = DispatchQueue(label: "com.newsify.firestore")
    
    
    func getDocument(userId: String, propertyName: String, completion: @escaping (_ value: String) -> ()) {
        queue.async {
            self.db.collection(self.collectionName).document(userId).getDocument { snapshot, error in
                guard let values = snapshot?.data() else { return }
                guard let property = values[propertyName] else { return }
                DispatchQueue.main.async {
                    completion(property as! String)
                }
            }
        }
    }
    
    func addOrUpdateDocument(userId: String, fieldName: String, property: String)  {
        queue.async {
            self.db.collection(self.collectionName).document(userId).updateData([
                fieldName: property
            ])
        }
    }
}
