import Foundation

public enum NetworkError: Error {
    case invalidURL
    case decode
    case unexpectedStatusCode
    case unknown
}
