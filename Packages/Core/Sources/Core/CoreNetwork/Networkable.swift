import Foundation
import Combine

public protocol Networkable {
    func sendRequest<T: Decodable>(endpoint: APIRouter) async throws -> T
}
