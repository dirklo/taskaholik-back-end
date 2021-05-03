user1 = User.create(username: "Rick", email: "rick@email.com", password: "rick123" )
user2 = User.create(username: "Bob", email: "bob@email.com", password: "bob123" )
user3 = User.create(username: "Jim", email: "jim@email.com", password: "jim123" )

team1 = user1.led_teams.create(name: "Test Team")
team1.members << user2
team1.members << user3

project1 = user1.created_projects.create(title: "Make a PB&J Sandwich", team_id: 1)


task1 = project1.tasks.create(title: 'Prepare Ingredients', creator_id: 1)
task1.details.create(content: "slice bread", creator_id: 1)
detail1 = task1.details.create(content: "open peanut butter jar", creator_id: 1)
detail1.comments.create(content: "This is going to take forever", author_id: 3)
task1.details.create(content: "open jelly jar", creator_id: 1)
task1.comments.create(content: "Wow this is a difficult one!", author_id: 1)
task1.comments.create(content: "I'll work on this step", author_id: 2)

task2 = project1.tasks.create(title: 'Toast Bread', creator_id: 1)
task2.details.create(content: "plug in toaster", creator_id: 1)
detail2 = task2.details.create(content: "toast for PRECICELY 2 minutes", creator_id: 1)
detail2.comments.create(content: "Are we sure this is the right number of minutes?", author_id: 1)
task2.prereq_tasks.create(requirement_id: 1)
task2.comments.create(content: "I'll work on this step", author_id: 2)

task3 = project1.tasks.create(title: 'Assemble Sandwich', creator_id: 1)
task3.details.create(content: "apply jelly to side 1", creator_id: 1)
task3.details.create(content: "apply peanut butter to side 2", creator_id: 1)
detail3 = task3.details.create(content: "slap those bad-boys together", creator_id: 1)
detail3.comments.create(content: "I'm good at da slappin'!", author_id: 2)
task3.prereq_tasks.create(requirement_id: 1)
task3.prereq_tasks.create(requirement_id: 2)
task3.comments.create(content: "This step is nuts!", author_id: 3)

task4 = project1.tasks.create(title: 'Presentation', creator_id: 1)
task4.details.create(content: "cut sandwich diagnally", creator_id: 1)
task4.details.create(content: "present in center of white plate", creator_id: 1)
task4.details.create(content: "add chips to the side", creator_id: 1)
detail4 = task4.details.create(content: "deliver to customer", creator_id: 1)
detail4.comments.create(content: "What customers?", author_id: 2)
task4.prereq_tasks.create(requirement_id: 1)
task4.prereq_tasks.create(requirement_id: 2)
task4.prereq_tasks.create(requirement_id: 3)
task4.comments.create(content: "We can't do this one until COVID is over...", author_id: 1)