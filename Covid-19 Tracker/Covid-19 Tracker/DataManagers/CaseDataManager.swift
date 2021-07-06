//
//  CaseDataManager.swift
//  Covid-19 Tracker
//
//  Created by Brian Alberta on 4/19/20.
//  Copyright © 2020 Brian Alberta. All rights reserved.
//

import Foundation
import Combine

class DataManager {
    static func fetch<T: Decodable>(urlString: String?) -> AnyPublisher<T, CovidError> {
        guard let request = DataManager.generateURLRequest(for: urlString) else {
            return Fail(error: CovidError.invalidUrl)
                .eraseToAnyPublisher()
        }
        print("DataManager: Fetching url: \(request.url!)")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { CovidError.map($0)}
            .eraseToAnyPublisher()
    }
    
    static func fetchOverview(forFilter: DataFilter.FilterType, queryParam: String) -> AnyPublisher<[CaseFeatures], Never> {
        let baseURLString = AppDelegate().configuration.urlString(for: .overview)
        return DataManager.fetch(urlString: baseURLString)
            .map { (results: CasesRawResponse) -> [CaseFeatures] in
                return results.features.filter { $0.attributes.region == queryParam }
        }
        .catch { (error) in
            return Just([CaseFeatures]())
        }
        .eraseToAnyPublisher()
    }
    
    static func fetchDetails(options: [DataFilter.QueryType]?) -> AnyPublisher<[CaseDetailFeatures], Never> {
        let baseURLString = AppDelegate().configuration.urlString(for: .detail)
        let urlStringWithQueryItems = DataManager.addQueryItems(urlString: baseURLString, queryElements: options)
        
        return DataManager.fetch(urlString: urlStringWithQueryItems)
            .map { (results: CaseDetailsResponse) -> [CaseDetailFeatures] in
                return results.features
        }
        .catch { (error) in
            return Just([CaseDetailFeatures]())
        }
        .eraseToAnyPublisher()
    }
    
    static func fetchStateCurrentDetals(state: USState) -> AnyPublisher<StateCurrentDetails, Never> {
        
        var baseURLString: String?
        switch state {
        case .ALL:
            baseURLString = AppDelegate().configuration.urlString(for: .currentAllStates)
        default:
            baseURLString = AppDelegate().configuration.urlString(for: .currentStateBase)
        }
        
        let formattedURLString = formatURLString(baseURLString, state: state)
        
        
        return DataManager.fetch(urlString: formattedURLString)
            .map { $0 }
        .catch { (error) in
            return Just(StateCurrentDetails())
        }
        .eraseToAnyPublisher()
    }
    
    static func fetchAllStatesCurrentDetails() -> AnyPublisher<StatesCurrentRawResponse, Never> {
        
        let baseURLString = AppDelegate().configuration.urlString(for: .currentAllStates)
        
        return DataManager.fetch(urlString: baseURLString)
            .map { $0 }
        .catch { (error) in
            return Just(StatesCurrentRawResponse())
        }
        .eraseToAnyPublisher()
    }
}

extension DataManager {
    
    static func generateURLRequest(for urlString: String?) -> URLRequest? {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("https://www.arcgis.com/apps/opsdashboard/index.html", forHTTPHeaderField: "referer")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    static func formatURLString(_ urlString: String?, state: USState) -> String? {
        guard let urlString = urlString else {
            return nil
        }
        let replaced = urlString.replacingOccurrences(of: "{STATE}", with: state.rawValue)
        return replaced
        
    }
    
    static func addQueryItems(urlString: String?, queryElements: [DataFilter.QueryType]?) -> String? {
        guard let queryItems = queryElements, let baseURLString = urlString else {
            return urlString
        }
        
        var urlComponents = URLComponents(string: baseURLString)
        for item in queryItems {
            guard let newItem = generateQueryItem(for: item) else { break }
            urlComponents?.queryItems?.append(newItem)
        }
        guard let newURL = urlComponents?.string else {
            return urlString
        }
        return newURL
    }
    
    static func generateQueryItem(for rawItem: DataFilter.QueryType) -> URLQueryItem? {
        switch rawItem {
        case .locale(let region, let province):
            return buildLocaleQuery(region: region, province: province)
            
        case .statisics(let field, let operation):
            return buildStatisticsQuery(field: field, operation: operation)
        }
    }
    
    static func buildLocaleQuery(region: String?, province: String?) -> URLQueryItem? {
        var queryArray = [String]()
        var finalQuery = ""
        if let regionString = region, regionString.count > 0{
            queryArray.append("(Country_Region = '\(regionString)')")
        }
        if let provinceString = province, provinceString.count > 0 {
            queryArray.append("(Province_State = '\(provinceString)')")
        }
        
        var separatorNeeded = false
        for item in queryArray {
            if separatorNeeded {
                finalQuery += " AND "
            }
            finalQuery += item
            separatorNeeded = true
        }
        return finalQuery.count > 0 ? URLQueryItem(name: "where", value: finalQuery) : nil
    }
    
    // TODO: Finish implementation
    static func buildStatisticsQuery(field: Statistics.Fields, operation: Statistics.Comparison) -> URLQueryItem? {
        return nil
    }
}


struct Statistics {
    typealias Comparison = (operator: String, value: Int)
    
    enum Fields {
        case confirmed
        case deaths
        case recovered
        case mortalityRate
        case hospitalized
        case hospitalizationRate
        case tested
        case testingRate
    }
}

struct DataFilter {
    
    enum FilterType {
        case region
        case state
    }
    
    enum QueryType {
        case locale(region: String?, province: String?)
        case statisics(field: Statistics.Fields, operation: Statistics.Comparison)
    }
    
    func queryExecutor(state: FilterType, queryItem: String?, results: CasesRawResponse) -> [CaseFeatures] {
        switch state {
        case .state:
            return filterByState(state: queryItem, results: results)
        case .region:
            return filterByRegion(region: queryItem, results: results)
        }
    }
    
    private func filterByRegion(region: String?, results: CasesRawResponse) -> [CaseFeatures] {
        guard let filterString = region, filterString.count > 0 else {
            return []
        }
        let filteredResults = results.features.filter { $0.attributes.region == filterString }
        return filteredResults
    }
    
    private func filterByState(state: String?, results: CasesRawResponse) -> [CaseFeatures] {
        guard let filterString = state, filterString.count > 0 else {
            return []
        }
        let filteredResults = results.features.filter { $0.attributes.province == filterString }
        return filteredResults
    }
}

