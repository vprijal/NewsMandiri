struct Constants {
    struct ProductionServer {
        static let baseURL = "https://newsapi.org/v2"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content_Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case string = "String"
}

enum ContentType: String {
    case json = "Application/json"
    case formEncode = "application/x-ww-form-urlencoded"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
}