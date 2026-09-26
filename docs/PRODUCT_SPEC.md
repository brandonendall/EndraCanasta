# Endra Canasta — Product Specification

This is the working specification for Prototype 0.1 and the eventual commercial Android/iOS product. The working name can change before release.

## Product pillars

**Learnability.** Someone with zero Canasta knowledge should be able to learn through guided play, explanations, coached practice and progressively reduced assistance.

**Social connection.** Friends, Favorite Partners, Recent Players, invitations and contextual partnership history should make good playing relationships easy to keep.

**Fair play.** Production multiplayer will be server-authoritative. Hidden partner/opponent hands are never sent to another player's client. Competitive play has no private in-match partner chat.

**Personalization.** Each player can make the experience feel like their own without changing shared game information or gaining an advantage.

## Main play areas

1. Learn & Practice
2. Solo Play
3. Casual Play
4. Competitive Play
5. Friends & Private Tables

Profile, Friends, Messages, Statistics, Achievements, Match History, Customize and Settings are supporting navigation.

## Learn & Practice

Teach objective/cards, drawing/discarding, melds, canastas, wild cards, red/black threes, discard and frozen-pile rules, initial meld minimums, natural/mixed canastas, going out, concealed going out and scoring.

Invalid actions explain why and offer legal alternatives. Coaching fades with progress. Practice never affects competitive rank or competitive records.

## Solo Play

The user is the only human. Computer-controlled seats support multiple difficulty levels. Higher difficulty means better strategy, never better cards. Main UI calls this Solo Play rather than Bots.

## Social system

Friend, Favorite Partner, Recent Player, Mute and Block are distinct concepts. Friends may show Online, In Game, Away or Offline subject to privacy. Players can directly invite online friends.

A pair of friends may queue as partners and matchmaking can fill the opposing seats. Competitive matchmaking should account for premade partnerships.

Profiles can show contextual shared statistics: games together, wins together, partnership win rate, best streak, canastas together, competitive games together, last played, games as partners versus opponents, and shared match history.

## Competitive system

Keep three concepts separate:

- Account Level: experience/activity; does not decrease from a loss.
- Competitive Division: understandable visible tier.
- Competitive Rating: numerical skill measure used for matchmaking/progression.

An info control explains all three. Matchmaking begins narrow. If waiting grows, the player is asked whether to expand the skill range rather than having it silently widened.

## Chat, translation and moderation

Table chat can be muted globally or per person. Quick Chat uses semantic localized phrases so recipients see them in their own language. Typed messages can be translated while preserving the original text.

Positive sportsmanship feedback is private input that can eventually support a Good Sport recognition. Reports use concrete categories and become moderation signals rather than automatic punishment.

## Fair-play architecture

The production server owns shuffle, deck, full match state and action validation. Each client receives only legally visible information. Computer players operate using only information available to their seat. Server match logs support moderation and suspicious-behavior review.

## Inactivity and disconnects

Use a visible turn timer, escalating missed-turn warnings, conservative temporary auto-play, reconnect grace and eventual computer substitution. Competitive abandonment consequences belong to the player who leaves, not the innocent partner. Exact timers and rating formulas require playtesting.

## Personalization

Customization changes the local presentation only. It includes profile/avatar, banner, frame, bio/status, table colors/textures/themes, card-face styles, card backs, interface accents, text sizing, sounds, haptics, celebrations and accessibility.

Provide live preview. Cosmetics must never reveal hidden information or create gameplay advantage.

## Game table

Four seats: user bottom, partner top, opponents left/right. The hand gets the most space. Draw/discard piles remain central. Team melds/canastas are clearly separated.

Both team scores remain visible. Seats show avatar, username, card count/status and clear active-turn/timer information. Tapping a player exposes relevant profile/social/mute/report actions. Detailed scoring opens separately.

## Statistics and progression

Track meaningful records including games, wins/losses, win percentage, casual/competitive records, current/highest division, streaks, team score, canastas, natural/mixed canastas, going-out frequency and point differential. Match history records participants, score, mode, result and competitive rating change where applicable.

Achievements can span Learning, Canasta, Social and Competitive categories.

## Prototype 0.1 scope

Prototype 0.1 validates UX with simulated players/data where needed. It includes enough of Home, Learn & Practice, Solo, Casual, Competitive, Friends/Private Tables, Profile, Customize and the game table for hands-on Android evaluation.

Visible controls should respond. Avoid a prototype made of dead buttons.

## Commercial direction

The eventual product targets Android and iOS. Monetization, if adopted, must not provide gameplay advantages. Final name, store identifiers, legal documents, backend hosting and monetization remain deferred until later milestones.
