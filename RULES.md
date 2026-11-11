# Learning Journey: Rules



## Goal
- A goal has a subject, a duration (week, month, year), and a start date.
- The start date is the beginning (midnight) of the day the goal is created.
- The end date is one calendar period after the start date (calendar-based, not 7/30/365 days).
- The end date is exclusive: the goal covers every day from the start up to, but not including, the end date.
- Changing the goal creates a new goal. The old logs are discarded and the streak starts over.

## Logging a day
- One entry per calendar day. Each entry is either learned or frozen.
- Tapping the other button replaces today's entry with a new one (new timestamp).
- The pressed button disables itself.
- Both buttons become active again at 12AM, even if the user logged at 11PM.

## Freezes
- Limits per goal: week = 2, month = 8, year = 96.
- Freezes used = the number of frozen entries in the current goal.
- Freeze is disabled when all freezes are used.
- Replacing a frozen entry with learned gives the freeze back.

## Streak
- The streak resets if more than 32 hours pass without a learned or frozen entry.
- A freeze keeps the streak alive but is not a learned day.
- The streak also resets when the goal is updated.

## Goal result
- Completed: every day of the goal has an entry (learned or frozen).
- Failed: a day passes with no entry, and the 32-hour limit is exceeded.

## Wording
- "1 Day", but "0 Days" and "2 Days".
- Use "Frozen", not "Freezed". Use "Well done!", not "Will done!".
- Log button: "Log as Learned" / "Logged as Learned".
- Freeze button: "Freeze for a day" / "Frozen for a day".
- Messages: "If you update now, your streak will start over."

## MVVM layers
| Layer | Holds | Never holds |
|---|---|---|
| Model | Data, its shape, rules about the data | Any text shown to the user |
| ViewModel | State, decisions, and wording that depends on state | SwiftUI views or layout |
| View | Layout and styling | Logic or wording decisions |

## Swift concepts
- Enums: Duration, DayStatus
- Structs: DayLog, Goal
- Classes: ViewModels
- Optionals: today's log (nil = nothing yet), current goal (nil = onboarding)