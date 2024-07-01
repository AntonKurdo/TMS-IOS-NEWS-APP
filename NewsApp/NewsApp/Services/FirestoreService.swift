import Firebase

class FirestoreService {
    static let shared = FirestoreService()
    
    private init() {}
    
    private var db = Firestore.firestore()
    
    private let collectionName = "users"
    
    private let queue = DispatchQueue(label: "com.newsify.firestore")
    
    func getDocument(userId: String, propertyName: String, completion: @escaping (_ value: String?) -> ()) {
        queue.async {
            self.db.collection(self.collectionName).document(userId).getDocument { snapshot, error in
                guard let exists = snapshot?.exists else {
                    completion(nil)
                    return
                }
                if !exists {
                    completion(nil)
                    return
                }
                guard let values = snapshot?.data() else {
                    completion(nil)
                    return
                }
                guard let property = values[propertyName] else {
                    completion(nil)
                    return
                }
                DispatchQueue.main.async {
                    completion(property as? String)
                }
            }
        }
    }
    
    func getFavouriteArticlesFromDocument(userId: String, propertyName: String, completion: @escaping (_ value: [Article]?) -> ()) {
        queue.async {
            self.db.collection(self.collectionName).document(userId).getDocument { snapshot, error in
                guard let exists = snapshot?.exists else {
                    completion(nil)
                    return
                }
                if !exists {
                    completion(nil)
                    return
                }
                guard let values = snapshot?.data() else {
                    completion(nil)
                    return
                }
                guard let property = values[propertyName] else {
                    completion(nil)
                    return
                }
                if let data = try? JSONSerialization.data(withJSONObject: property, options: []) {
                    let decodedResult = try? JSONDecoder().decode([Article].self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedResult)
                    }
                }
            }
        }
    }
    
    func addOrUpdateDocument<T>(userId: String, fieldName: String, property: T)  {
        queue.async {
            self.db.collection(self.collectionName).document(userId).getDocument { snapshot, error in
                guard let existed = snapshot?.exists else {return}
                if (existed) {
                    self.db.collection(self.collectionName).document(userId).updateData([
                        fieldName: property
                    ])
                } else {
                    self.db.collection(self.collectionName).document(userId).setData([
                        fieldName: property
                    ])
                }
            }
        }
    }
}
