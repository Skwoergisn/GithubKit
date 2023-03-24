# GithubKit
A Swift framework for interacting with Github

## How to use
### Configure
Start by importing `GithubKit` and configure it with your app credentials:

```swift
import GithubKit

Github.configure(
    clientID: <app client id>,
    clientSecret: <app client secret>,
    redirectURL: URL(string: <app redirect url>)!
)
```

### Auth
Before you are able to query Github's API, you need to authenticate through your app. GithubKit provides a convenient SwiftUI sheet for this. 
The sheet accepts a completion block which provides the result of the authentication. If successful, you will receive a Github.Configuration object, which you can use for any authenticated API calls.

```swift
import GithubKit

struct MyView: View {
    @State 
    var showGithubSheet: Bool = false

    var body: some View {
        Button {
            showGithubSheet = true
        } label: {
            Text("Authenticate with Github")
        }
        .githubAuthSheet(isPresented: $showGithubSheet) { result in
            if case let .success(configuration) = result {
                // Store this `configuration` object for later
            }
        }
    }
}
```

### API calls
Once Authentication succeeds, you have everything needed to start making calls to the Github API.

To do so, simply call the API constructor with the config you created during authentication:

```swift
import GithubKit

let githubAPI = try await Github.API.Authenticated.main(configuration: config) 
```

With this, you are now able to perform calls to the Github API, i.e

```swift
let myRepositories = try await githubAPI.repositories.userRepositories()

// You now have an array of repositories belonging to the authenticated user, neat!
```
