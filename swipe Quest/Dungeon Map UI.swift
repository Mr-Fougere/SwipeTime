import SwiftUI

struct DungeonMapView: View {
    @ObservedObject var donjonMap: DonjonMap
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<10, id: \.self) { x in
                    VStack {
                        ForEach(0..<10, id: \.self) { y in
                            let cell = donjonMap.getCell(at: Coordinate(x: x, y: y))!
                            if donjonMap.path.contains(where: { $0.coordinate == cell.coordinate }) {
                                Image(cell.type.description).background(Color.green)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
    }
}
