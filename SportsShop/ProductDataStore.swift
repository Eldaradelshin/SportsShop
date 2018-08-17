

import Foundation

final class ProductDataStore {
    var callback:((Product) -> Void)?
    private var networkQ:DispatchQueue
    private var uiQ:DispatchQueue
    lazy var products:[Product] = self.loadData()
    
    init() {
        networkQ = DispatchQueue.global(qos: .background)
        uiQ = DispatchQueue.main
    }
    
    private func loadData() -> [Product] {
        for p in productData {
            networkQ.async {
                () in
                let stockConn = NetworkPool.getConnection()
                let level = stockConn.getStockLevel(name: p.name)
                if (level != nil) {
                    p.stockLevel = level!
                    self.uiQ.async {
                        () in
                        if (self.callback != nil) {
                            self.callback!(p)
                        }
                    }
                }
                NetworkPool.returnConnection(conn: stockConn)
            }
        }
        return productData
        
    }


private var productData: [Product] = [
    Product.createProduct(name: "Kayak", description: "A boat for one person", category: "Watersports", price: 275.0, stockLevel: 10),
    Product.createProduct(name: "Lifejacket", description: "Protective and fashionable", category: "Watersports", price: 48.95, stockLevel: 14),
    Product.createProduct(name: "Soccer ball", description: "FIFA-approved size and weight", category: "Soccer", price: 19.5, stockLevel: 32),
    Product.createProduct(name: "Corner flags", description: "Give your playing field a professional touch", category: "Soccer", price: 34.95, stockLevel: 1),
    Product.createProduct(name: "Stadium", description: "Flat-packed 35,000-seat stadium", category: "Soccer", price: 79500.0, stockLevel: 4),
    Product.createProduct(name: "Thinking Cap", description: "Improve your brain efficiency by 75% ", category: "Chess", price: 16.0, stockLevel: 8),
    Product.createProduct(name: "Unsteady Chair", description: "Secretly give your opponent a disadvantage", category: "Chess", price: 29.95, stockLevel: 3),
    Product.createProduct(name: "Human Chess Board", description: "A fun game for family", category: "Chess", price: 75.0, stockLevel: 2),
    Product.createProduct(name: "Bling-bling King", description: "Gold-plated, diamond studded King", category: "Chess", price: 1200.0, stockLevel: 4)]

}
