//
//  HomeViewModel.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 13/02/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var dataModel: AvenuesDataModel?
    private var apiManager: ApiManagerType
    var cancellable = Set<AnyCancellable>()
    init(apiManager: ApiManager = ApiManager()) {
        self.apiManager = apiManager
    }
    
    func fetchURL() -> URL? {
        if let plistPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
           let plistData = FileManager.default.contents(atPath: plistPath),
           let plistDictionary = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any],
           let myURLString = plistDictionary["AvenuesURL"] as? String,
           let myURL = URL(string: myURLString) {
            return myURL
            print("My URL: \(myURL)")
        } else {
            print("Error reading URL from plist")
            return nil
        }
    }
    
    func fetchData() {
        guard let url = fetchURL() else { return }
        apiManager.fetch(url: url).sink { error in
            print("\(error)")
        } receiveValue: { value in
            self.dataModel = value
        }
        .store(in: &cancellable)
    }
}


