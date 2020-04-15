# Flix: MVVM + Combine + SwiftUI
A project to explore using MVVM architecture and Combine + SwiftUI frameworks to create a simple movie browsing app with data from [The Movie Database API](https://developers.themoviedb.org/3/getting-started/introduction)

## 1. Fetch Movies and display in List
### Goal
Fetch a list of movie's now playing from [The Movie Database API - Now Playing Endpoint](https://developers.themoviedb.org/3/movies/get-now-playing) and display them in a SwiftUI list view.

### Steps
1. Reorganize project into a few basic groups, "View", "Network", "App", "Model".
1. Create API struct .
   1. Handle URL creation for endpoint .
   1. Basic network request using URLSessionDataTask publisher provided by Combine framework.
1. Create `MoviesListViewModel` for the movies list view.
   1. `ObservableObject` with a few `@Published` properties we want to expose to the view.
1. Create basic `MoviesListView` to display movie title in a list view.
   1. Embed in `NavigationView` + set nav title.
   1. Add `List`, `Section` + set section title.
   1. Use `ForEach` to return a `Text` view for each movie in the view model's `movies` array and display each movies's title.

### Images
![flix_1 1](https://user-images.githubusercontent.com/11927517/79384844-76f80900-7f1c-11ea-9cf0-3bab4c084ef3.gif)

