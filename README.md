Original App Design Project - README Template
===

# SumFlip

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

SumFlip is an interactive math card game designed to make practicing math fun, challenging, and competitive. The game displays a target number, and players must flip two hidden number cards to find a combination that produces the target using addition, subtraction, multiplication, or division.

For example, if the target number is 5 and the selected operation is addition, players must find two cards containing numbers that add up to 5, such as 2 and 3.

Players earn points for correct matches and try to achieve the highest score before the timer runs out. The app will also include different difficulty levels to make the game accessible to beginners and more experienced players.

We plan to include leaderboards, multiplayer challenges, sound effects, and card-flipping animations to make the experience more engaging.

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:** Education, Games, Entertainment
- **Mobile:** IOS Application only
- **Story:**  SumFlip turns basic math practice into an entertaining game. Instead of solving traditional math questions, players use memory and problem-solving skills to find number combinations while competing against time. The goal is to make learning and practicing math enjoyable.
- **Market:** The app is designed for everyone.
- **Habit:** SumFlip is designed for both daily and occasional use.
- **Scope:** The core app will focus on card-flipping gameplay, mathematical operations, difficulty levels, a countdown timer, and score tracking.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [User can [specific action, e.g., register an account]]
* ...

**Optional Nice-to-have Stories**

* [User can [specific action, e.g., persist user information across working sessions]]
* ...

### 2. Screen Archetypes

- [ ] [**Screen Name, e.g., Login Screen**]
* [Required User Feature: User can log in.]
- [ ] [**Another Screen Name**]
* [Associated required user story]
...
...
...

### 3. Navigation

**Tab Navigation** (Tab to Screen)


- [ ] [First Tab, e.g., Home Feed]
- [ ] [Second Tab, e.g., Profile]
...
...
...

**Flow Navigation** (Screen to Screen)

- [ ] [**Screen Name**]
  * Leads to [**Next Screen**]
- [ ] [**Another Screen Name**]
  * Leads to [**Another Screen**] 


## Wireframes

[Handwritten.pdf](https://github.com/user-attachments/files/34383141/Handwritten.pdf)


### [BONUS] Digital Wireframes & Mockups

<img width="1536" height="426" alt="sumflip-digital" src="https://github.com/user-attachments/assets/3762999f-a365-4663-8490-0274192016da" />


### [BONUS] Interactive Prototype

## Schema 


### Models

The following models represent the data we plan to use for SumFlip. The final structure may change during development.

| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| username | String | Player's display name|
| score    | Int    | Player's score       |



### Networking

The core SumFlip game can run locally without requiring an external API. Game logic, card generation, scoring, and the countdown timer will be handled directly within the application.

If we implement an online leaderboard or multiplayer functionality, we may use a backend service such as Firebase to store and retrieve player information.

### Potential Network Requests

#### Leaderboard Screen

Retrieve top player scores from the database.

Retrieve a player's ranking and personal best score.

### Game Results Screen

Save a completed game's score to the database.

Update the player's high score if a new record is achieved.

### Possible Firebase Operations (Optional)

Read documents from a leaderboard collection to display high scores.

Create a document in the scores collection when a game finishes.

Update a player's high-score document.

Create and update documents in a matches collection for multiplayer games.


These are proposed database operations rather than finalized API endpoints. The exact networking implementation will be determined during development.
