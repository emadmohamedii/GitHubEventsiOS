import Foundation
import Combine

public final class NetworkService: Networkable {
    public static let shared = NetworkService()
    private init () {}
    
    public func sendRequest<T: Decodable>(endpoint: any APIRouter) async throws -> T {
        guard let urlRequest = createRequest(endPoint: endpoint) else {
            throw NetworkError.invalidURL
        }
        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    continuation.resume(throwing: NetworkError.unexpectedStatusCode)
                    return
                }
                guard let data = data, let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    continuation.resume(throwing: NetworkError.decode)
                    return
                }
                continuation.resume(returning: decodedResponse)
            }
            task.resume()
        }
    }
    
    private func createRequest(endPoint: any APIRouter) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https" // Ensure the scheme is set
        components.host = URL(string: endPoint.host)?.host // Extract the host without the scheme
        components.path = "/" + endPoint.path // Ensure the path starts with "/"
   
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.header

        if let body = endPoint.body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                return nil
            }
        }
        
        return request
    }
}
