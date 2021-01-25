UberProject
===============

#### Project layout

### API
Things that assist with getting/sending data to the Uber API

### Features
Higher-level features like "Ride Estimator", maybe we'd have "Settings" and "Login" if I were to flesh out this app more
### Categories
Various generic categories
### Supporting Files
Files we need for every app (launch screen, info.plist, main.m, etc.)
###Frameworks
Frameworks I used, in particular, my JSON mapper ([JLObjectMapping](https://github.com/taquitos/JLObjectMapping)). I included the source in this project for your perusal.


## Notes

I added another API (API/Products) to show the design of the app and the ease of adding new functionality. You can see how adding new API involves creating a new API/subfolder, a new UberAPI category to handle the types of requests you're looking to build out, and then subfolders to handle all requests/responses along with any models that you will serialize/deserialize.'

* all dependencies are injected into controllers for looser coupling
* API Keys were not obfuscated because that was out of scope and would require a server to request them from + Keychain storage to do correctly
* view models for the table view cells instead of directly referencing IBOutlets (which are hidden in a class extension in the implementation file)
* various markers (nullibility, designated initializer, etc)
* no external frameworks
* server error models
* handling of request cancelling (for any UberAPI requests as well as the routing information)
* simple and extensible networking layer without external dependencies


## Unit testing
Unit testing and integration testing are extremely important to me. While I didn't add any tests, I'll provide you with some proof of how serious I am about tests with some examples from github: [https://github.com/taquitos/JLObjectMapping/tree/master/JLJSONMappingTests](https://github.com/taquitos/JLObjectMapping/tree/master/JLJSONMappingTests). In this UberProject, I made the decision to skip the tests to let me move faster through a timed exercise.

I normally take my time and test each module I build before integrating it (I don't do test-driven often, I find it can be disruptive to flow if I'm really on a roll with something), but not always. Sometimes I do need to wait until I've fully fleshed out the ideas.

Along with standard unit testing practices, specifically for this project, I would have used OHHTTPStubs to inject every type of request and response I would expect from the server for each API, along with various error conditions to test the error handling code more (like fuzzing).


