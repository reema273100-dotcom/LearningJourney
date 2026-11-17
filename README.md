
# Learning Journey

An iOS app that helps you build a daily learning habit. Pick what you want to learn and for how long, then log each day you learn, or freeze a day to protect your streak.

## Main features
- Onboarding on first launch: choose what to learn and a duration (week, month, or year)
- Activity page with the current week, learned and frozen counters, and today's date
- Log a day as learned, or freeze it; switching replaces today's entry
- Freeze limits depend on the duration: 2 per week, 8 per month, 96 per year
- The streak resets after 32 hours without a learned or frozen day
- End screens when a goal is completed or missed, with a button to set a new goal
- Change your learning goal, with a warning that your streak will start over
- Calendar page showing every learned and frozen day
- Progress is saved on the device

## Technologies used
- Swift and SwiftUI
- MVVM architecture (Models, ViewModels, Views)
- Liquid Glass
- Xcode 27, iOS 27.0
- Git and GitHub

## Project structure
- `Models`: `Goal`, `DayLog`, `DayStatus`, `Duration`, `GoalState`
- `ViewModels`: state and rules for each screen
- `Views`: the Activity, Onboarding, and Calendar screens, plus shared components
- `RULES.md`: the app's rules and design decisions

## Screenshots
