import Foundation

// Can add more as app becomes more complex
public enum HTTPMethod: String {
  case get = "GET"
}

// Keep it simple for now, can be expanded once more errors are handled.
public enum RequestError: Error {
  case badResponse
}

public final class ApiClient {

  private let urlSession: URLSession
  private let decoder: JSONDecoder

  public init(urlSession: URLSession = .shared, decoder: JSONDecoder = .init()) {
    self.urlSession = urlSession
    self.decoder = decoder
  }

  public func request<T: Decodable>(
    url: URL = APIConfig.apiBaseUrl,
    method: HTTPMethod = .get
  ) async throws -> T {
    let (data, response) = try await urlSession.data(for: buildUrlRequest(url: url, method: method))

    guard let _ = response as? HTTPURLResponse else {
      throw RequestError.badResponse
    }

    return try decoder.decode(T.self, from: data)
  }
}

// MARK: - Private
private extension ApiClient {
  func buildUrlRequest(
    url: URL,
    method: HTTPMethod
  ) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    return request
  }
}
