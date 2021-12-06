//
//  RequestConfig.swift
//  Mobile Assessment
//
//  Created by Anthony Odu on 12/4/21.
//

import Foundation
/// Request Config Model
public struct RequestConfigModel<T: Decodable, K:Codable> {
    
    /// Make request using the base error handler
    /// - Parameter T: This is should signify the response class
    /// - Parameter K: This is should signify the request class
    /// - Parameter url: the string signifying the endpoint's url, this shouldn't contain base url
    /// - Parameter requestMethod: the `RequestMethod` is an enum that defines the Http methods
    /// - Parameter requestTimeout: this double defines how long bbefore a time out is reached, default is set to 60
    /// - Parameter debug: this  bool allows for logging of network request, response and general error
    /// - Returns: `RequestResult`  holds the data for both failed and success cases
    public init(url: String, requestMethod: RequestMethod, responseType: T.Type, requestObject: K? = nil, requestTimeout: Double? = nil, debug: Bool? = nil) {
        self.url = url
        self.requestMethod = requestMethod
        self.responseType = responseType
        self.requestObject = requestObject
        self.requestTimeout = requestTimeout
        self.debug = debug
    }
    
    public var url: String // url: the string signifying the endpoint's url, this shouldn't contain base url
    public var requestMethod: RequestMethod //  the `RequestMethod` is an enum that defines the Http methods
    public var responseType: T.Type // the expected result type
    public var requestObject: K? // the request object
    public var requestTimeout : Double? // requestTimeout: this double defines how long bbefore a time out is reached, default is set to 60
    public var debug:Bool? /// debug: this  bool allows for logging of network request, response and general error
    
}
