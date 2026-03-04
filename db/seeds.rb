Chat.create(title: "Recommendation for hamstring exercises", user_id: 1)
Routine.create(name: "Leg Workout", duration_in_seconds: 0, user_id: 1)
Exercice.create(name: "Single-Leg Romanian Deadlift",
                description: "Stand on one leg, hold dumbbell or weight in opposite hand (or go bodyweight). Hinge at the hip, keeping your back flat and core tight. Lower your upper body until you feel a stretch, then squeeze your glutes and return.",
                video_url: "https://www.youtube.com/watch?v=MsE_T9nAsSE",
                rep_amount: "3x8-12 reps per leg",
                objective: "Teaches balance, strength, and that hip-hinge motion you need for powerful hamstrings.",
                chat_id: 1,
                routine_id: 1)
Exercice.create(name: "Sliding Hamstring Curl",
                description: "On a smooth surface, lie on your back with heels on a towel/sliding device. Lift your hips, slide your feet away, then curl them back.",
                video_url: "https://www.youtube.com/watch?v=UaecXxAgsKA",
                rep_amount: "3x10-12 reps",
                objective: "Uses eccentric control to build strength without heavy equipment.",
                chat_id: 1,
                routine_id: 1)
Exercice.create(name: "Glute Bridge / Single-Leg Bridge",
                description: "Lie on your back, knees bent, feet flat. Press through your heels to lift hips, pause, and lower. For a tougher version: lift one leg and repeat.",
                video_url: "https://www.youtube.com/watch?v=3NXv0Nany-Q",
                rep_amount: "3x15 (double-leg), 3x8-12 per side (single-leg)",
                objective: "Hits glutes and hamstrings simultaneously—great for posture and strength.",
                chat_id: 1,
                routine_id: 1)
