# 🏋️‍♀️ Smart Trainer

An AI-powered fitness coaching web app that generates personalized workout routines through a conversational interface. Chat with an AI coach, get custom exercises tailored to your goals and constraints, then save them into reusable routines.

---

## Features

- **AI Coaching Chat** — Conversational interface where an AI coach gathers information about your fitness level, target muscles, available equipment, and any physical constraints before generating a workout.
- **Two-Phase AI Conversation** — A guided gathering phase (up to 3 questions) followed by a structured generation phase that outputs exercises as structured data.
- **Personalized Exercise Generation** — The AI produces 3 custom exercises per session, each with a detailed description, rep counts, targeted muscles, objectives, and an embedded YouTube video.
- **Routine Management** — Create named routines, add or remove exercises from them, and keep your workouts organized.
- **AI-Assisted Routine Assignment** — Ask the AI to add generated exercises directly to one of your routines; it uses a tool call to handle the operation.
- **User Authentication** — Full sign-up, login, and password recovery flow powered by Devise.
- **Per-User Data Isolation** — Every user sees only their own chats, exercises, and routines.
- **Sidebar Navigation** — Quick access to all routines, new chat creation, and account management from any page.
- **Markdown Rendering** — AI responses are rendered with full Markdown support.
- For some reason, there is also a goddamn shark that swims on the homepage.

---

## Stack

| Layer | Technology |
|---|---|
| Language | Ruby 3.3.5 |
| Framework | Ruby on Rails 8.1.2 |
| Database | PostgreSQL |
| Frontend | ERB, Bootstrap 5.3, Hotwire (Turbo + Stimulus) |
| JavaScript | Import Maps |
| Authentication | Devise |
| AI Integration | ruby_llm |
| Asset Pipeline | Propshaft + Sprockets |
| Styling | Bootstrap 5.3, Font Awesome 6.1, SCSS |
| Web Server | Puma + Thruster |
| Deployment | Kamal (Docker) |
| Security | Brakeman, Bundler-audit |
| Code Style | RuboCop (Rails Omakase) |
