struct User: Identifiable {
    let coordinate: CLLocationCoordinate2D
    let tag: Int
    var id: Int {tag}
}