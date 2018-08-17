
import Foundation

final class NetworkPool {
    
    private let connectionCount = 3
    private var connections = [NetworkConnection]()
    private var semaphore:DispatchSemaphore
    private var queue:DispatchQueue
    private var itemsCreated = 0
    
    private init() {
        semaphore = DispatchSemaphore.init(value: connectionCount)
        queue = DispatchQueue.init(label:"NetworkpoolQ")
    }
    
    private func doGetConnection() -> NetworkConnection {
        
        semaphore.wait(timeout: DispatchTime.distantFuture)
        var result:NetworkConnection? = nil
        
        queue.sync { () in
            
            if (self.connections.count > 0)
            {
            result = self.connections.remove(at: 0)
            } else
                if (self.itemsCreated < self.connectionCount)
            {
                result = NetworkConnection()
                self.itemsCreated = itemsCreated+1
            }
        }
        return result!
    }
    
    private func doReturnConnection(conn:NetworkConnection) {
        queue.async {
            () in
            self.connections.append(conn)
            self.semaphore.signal()
        }
    }
    
    class func getConnection() -> NetworkConnection {
        return NetworkPool.sharedInstance.doGetConnection()
    }
    
    class func returnConnection(conn:NetworkConnection) {
        NetworkPool.sharedInstance.doReturnConnection(conn: conn)
    }
    
    private class var sharedInstance:NetworkPool {
        get {
            struct SingletonWrapper {
                static let singleton = NetworkPool()
            }
            return SingletonWrapper.singleton
        }
    }
}
