struct Service: Codable {
    let name: String
    let description: String
    let link: String
    let iconURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case link
        case iconURL = "icon_url"
    }
}

struct ServicesResponse: Codable {
    let body: Body
    let status: Int
}

struct Body: Codable {
    let services: [Service]
}
