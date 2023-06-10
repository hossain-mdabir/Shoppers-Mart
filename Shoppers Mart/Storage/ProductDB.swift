//
//  ProductDB.swift
//  Shoppers Mart
//
//  Created by Md Abir Hossain on 10-06-2023.
//

import Foundation
import SQLite3


class ProductDB {
    
    let dbName: String = "ProductDB.sqlite"
    var db : OpaquePointer?
    
    // MARK: - Table Name
    static let TABLE_PRODUCT = "TableProduct"
    
    
    // MARK: - Car Table
    static let COL_ID = "ColId"
    static let COL_TITLE = "ColTitle"
    static let COL_PRICE = "ColPrice"
    static let COL_DESCRIPTION = "ColDescription"
    static let COL_CATEGORY = "ColCategory"
    static let COL_IMAGE = "ColImage"
    static let COL_RATE = "ColRate"
    static let COL_ORDER_QTY = "ColOrderQty"
    static let COL_TOTAL_PRICE = "ColOrderQty"
    
    
    init() {
        
        print("UserDefaults-Product-databaseCreated :: \(UserDefaults.standard.bool(forKey: "databaseCreated"))")
        
        self.db = createDatabase()
        
        //        if UserDefaults.standard.bool(forKey: "databaseCreated") == false {
        
        self.createProdTable()
        //        }
    }
    
    // MARK: - Create McQueen database
    func createDatabase() -> OpaquePointer? {
        
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbName).appendingPathExtension(dbName)
        
        print("filePath \(filePath)")
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is error in creating ProductDB")
            return nil
        } else {
            print("Product Database has been created with path \(dbName)")
            UserDefaults.standard.set(true, forKey: "databaseCreated")
            print("UserDefaults.databaseCreated :: \(UserDefaults.standard.bool(forKey: "databaseCreated"))")
            return db
        }
    }
    
    // MARK: - Create car table
    func createProdTable() {
        let query = """
             CREATE TABLE IF NOT EXISTS \(ProductDB.TABLE_PRODUCT)
             (ID INTEGER PRIMARY KEY AUTOINCREMENT,
            \(ProductDB.COL_ID) INTEGER,
            \(ProductDB.COL_TITLE) TEXT,
            \(ProductDB.COL_PRICE) REAL,
            \(ProductDB.COL_DESCRIPTION) TEXT,
            \(ProductDB.COL_CATEGORY) TEXT,
            \(ProductDB.COL_IMAGE) TEXT,
            \(ProductDB.COL_RATE) REAL,
            \(ProductDB.COL_ORDER_QTY) INTEGER,
            \(ProductDB.COL_TOTAL_PRICE) REAL
            )
            """
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Product Table created SUCCESSFULLY")
            } else {
                print("Product Table creation FAILED")
            }
        } else {
            print("Failed to create Product Table")
        }
        sqlite3_finalize(statement)
    }
    
    
    // MARK: - Insert car info in the table
    func insertProd(prod: ProductList) {
        let query = """
            INSERT INTO  \(ProductDB.TABLE_PRODUCT) (
            \(ProductDB.COL_ID),
            \(ProductDB.COL_TITLE),
            \(ProductDB.COL_PRICE),
            \(ProductDB.COL_DESCRIPTION),
            \(ProductDB.COL_CATEGORY),
            \(ProductDB.COL_IMAGE),
            \(ProductDB.COL_RATE),
            \(ProductDB.COL_ORDER_QTY),
            \(ProductDB.COL_TOTAL_PRICE)
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(statement, 1, Int32(prod.id ?? 0))
            sqlite3_bind_text(statement, 2, ((prod.title ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_double(statement, 3, prod.price ?? 0)
            sqlite3_bind_text(statement, 4, ((prod.description ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, ((prod.category ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 6, ((prod.image ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_double(statement, 7, prod.rating?.rate ?? 0)
            sqlite3_bind_int(statement, 8, Int32(prod.orderQty ?? 0))
            sqlite3_bind_double(statement, 9, prod.totalPrice ?? 0)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Product Data inserted successfully")
            } else {
                print("Product Data not inserted in the Table")
            }
        } else {
            print("Product Query is not as per requirement")
        }
        sqlite3_finalize(statement)
    }
    
    
    // MARK: - Get car
    func getProducts() -> [ProductList] {
        
        var prodList = [ProductList]()
        var statement: OpaquePointer? = nil
        let query = "SELECT * FROM TableProduct"
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            
            while sqlite3_step(statement) == SQLITE_ROW {
                
                let id = Int(sqlite3_column_double(statement, 1))
                let title = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                let price = sqlite3_column_double(statement, 3)
                let description = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                let category = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                let image = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                let rate = sqlite3_column_double(statement, 7)
                let orderQty = Int(sqlite3_column_double(statement, 8))
                let totalPrice = sqlite3_column_double(statement, 9)
                
                var prod = ProductList()
                prod.id = id
                prod.title = title
                prod.price = price
                prod.description = description
                prod.category = category
                prod.image = image
                prod.rating?.rate = rate
                prod.orderQty = orderQty
                prod.totalPrice = totalPrice
                
                prodList.append(prod)
                
                print("size---:CC \(prod.title)")
            }
        } else {
            
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        
        sqlite3_finalize(statement)
        print("ProductDB size : \(prodList.count)")
        
        return prodList
    }
    
    
    // MARK: - Delete added products for selected customer
    func deleteProd(prodTitle: String) {
        let query = "DELETE FROM \(ProductDB.TABLE_PRODUCT) WHERE \(ProductDB.COL_TITLE) = '\(prodTitle)'"
        
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE {
                print("ProductDB Data delete success")
            } else {
                print("ProductDB Data is not deleted from table")
            }
        }
    }
    
    // MARK: - Update added products for selected customer
    func updateProd(prodTitle: String, prodQty: Int, totalPrice: Double) {
        var query = "UPDATE OrderCHD SET \(ProductDB.COL_ORDER_QTY) = \(prodQty), \(ProductDB.COL_TOTAL_PRICE) = \(totalPrice) WHERE \(ProductDB.COL_TITLE) = '\(prodTitle)'"
        
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE {
                print("ProductDB Data update success")
            } else {
                print("ProductDB Data is not updated from table")
            }
        }
    }
}
