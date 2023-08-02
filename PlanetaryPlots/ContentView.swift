import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PlotOrbitsView()
                .tabItem {
                    Label("Plot Orbits", systemImage: "circle.circle")
                }
            SpirographView()
                .tabItem {
                    Label("Spirographs", systemImage: "scribble.variable")
                }
            
            RelativeOrbitsView()
                .tabItem {
                    Label("Relative Orbits", systemImage: "lasso")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
