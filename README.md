# Flix

Flix is an app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

## Flix Part 2

### User Stories

#### REQUIRED (10pts)
- [X] (5pts) User can tap a cell to see more details about a particular movie.
- [X] (5pts) User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

#### BONUS
- [X] (2pts) User can tap a poster in the collection view to see a detail screen of that movie.
- [X] (2pts) In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer.
- [X] Custom error popups when: the network does not connect you to the API, the API response is not a valid JSON, or the movie does not contain a YouTube trailer.

### App Walkthrough GIF

<img src="https://i.imgur.com/bLY5KOW.gif" width=250><br>


This gif shows what happens if the API response does not contain a YouTube trailer, or if the network connection fails.
<img src="https://i.imgur.com/5DpqRYB.gif" width=250><br>


### Notes
Describe any challenges encountered while building the app.

- [X] Working with gesture recognizers to first load the API request and then segue was a good learning experience.

---

## Flix Part 1

### User Stories

#### REQUIRED (10pts)
- [X] (2pts) User sees an app icon on the home screen and a styled launch screen.
- [X] (5pts) User can view and scroll through a list of movies now playing in theaters.
- [X] (3pts) User can view the movie poster image for each movie.

#### BONUS
- [X] (2pt) User can view the app on various device sizes and orientations.
- [X] (1pt) Run your app on a real device.

### App Walkthrough GIF

<img src="https://i.imgur.com/N5w3oma.gif" width=250><br>

<img src="https://i.imgur.com/2ABvCSd.gif" width=250><br>

### Notes
Describe any challenges encountered while building the app.

- [X] Biggest challenge was ensuring that text would wrap correctly and not fall off screen for all devices.
