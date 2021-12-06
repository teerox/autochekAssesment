//
//  NetworkManager.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/4/21.
//

import Foundation

let BASEURL = "https://api.staging.myautochek.com"

typealias parameters = [String:Any]

/// Result enum to show success or failure
public enum RequestResult<T> {
    case success(T)
    case failure(RequestError)
}

/// Default error cases
public enum RequestError: Error {
    case noNetwork
    /// The rerquest failed for connectivity reasons
    case networkError(Error)
    /// The response don't have ann data
    case dataNotFound
    /// The user is unauthorised to hit the endpoint
    case unauthorized
    /// The response failed pass to json
    case jsonParsingError(Error)
    case networktimeout
    case serverError
}

/// Request supported
public enum RequestMethod: String{
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
}

public struct Param:Codable{
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    public var key:String
    public var value:String
}

protocol BaseWebProtocol : AnyObject{
    func requestData<T: Decodable, K:Codable>(url:String,method:RequestMethod,requestObject: K?,responseType: T.Type,completion: @escaping (RequestResult<T>) -> Void)
}


open class BaseNetworkService: BaseWebProtocol {
    
    func requestData<T, K>(url: String, method: RequestMethod, requestObject: K?,responseType: T.Type, completion: @escaping (RequestResult<T>) -> Void) where T : Decodable, K : Decodable, K : Encodable {
        
        var urlRequest = URLRequest(url: URL(string: BASEURL+url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = method.rawValue
        if let parameters = requestObject as? [Param] {
            let parameterData = parameters.reduce("") { (result, param) -> String in
                return result + "&\(param.key)=\(param.value)"
            }.data(using: .utf8)
            urlRequest.httpBody = parameterData
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completion(RequestResult.failure(.noNetwork))
            }else if let responseCode = response as? HTTPURLResponse {
                switch responseCode.statusCode {
                case 200...201:
                    guard let data = data else {
                        completion(RequestResult.failure(.dataNotFound))
                        return
                    }
                    do {
                        let decodedObject = try JSONDecoder().decode(responseType.self, from: data)
                        completion(RequestResult.success(decodedObject))
                    } catch let error {
                        print("error on parsing request to JSON : \(error)")
                        completion(RequestResult.failure(.jsonParsingError(error as! DecodingError)))
                    }
                case 400...499:
                    completion(RequestResult.failure(.dataNotFound))
                case 500...599:
                    completion(RequestResult.failure(.serverError))
                default:
                    completion(RequestResult.failure(.networktimeout))
                    break
                }
            }
        }.resume()
    }
}
