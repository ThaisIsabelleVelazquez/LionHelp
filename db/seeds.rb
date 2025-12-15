# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).

# --- Create User Accounts ---
accounts = [
    { user_id: 1, name: 'John Doe', email: 'jd1234@columbia.edu' , password: 'Password1!' },
    { user_id: 2, name: 'Kathy Lee', email: 'kl1234@columbia.edu' , password: 'Password1!' },
    { user_id: 3, name: 'Hannah Lasso', email: 'hl1234@barnard.edu' , password: 'Password1!' },
    { user_id: 4, name: 'Barbara Reddington', email: 'br1234@barnard.edu' , password: 'Password1!' },
    { user_id: 5, name: 'Janine Abbott', email: 'ja1234@barnard.edu' , password: 'Password1!' },
    { user_id: 6, name: 'Sam Patel', email: 'sp1234@columbia.edu' , password: 'Password1!' },
    { user_id: 7, name: 'Emily Chen', email: 'ec1234@columbia.edu' , password: 'Password1!' },
    { user_id: 8, name: 'Lina Morales', email: 'lm1234@columbia.edu' , password: 'Password1!' },
    { user_id: 9, name: 'Maya Brooks', email: 'mb1234@columbia.edu' , password: 'Password1!' },
    { user_id: 10, name: 'Chris Ramos', email: 'cr1234@columbia.edu' , password: 'Password1!' }
]
UserAccount.delete_all
accounts.each do |account|
  UserAccount.create!(account)
end

puts "Created #{UserAccount.count} accounts!"

# --- Create Columbia Student Services ---
services = [
  { vendor_id: 2, title: 'Meal Swipes', vendor_name: 'Kathy Lee', description: 'Selling meal swipes! Can meet at Lerner or JJ’s.', price: 9.00, category: 'Food' },
  { vendor_id: 1, title: 'Tutoring – COMS W1004', vendor_name: 'John Doe', description: 'One-hour tutoring sessions for Java/Python intro CS. Experienced TA.', price: 25.00, category: 'Tutoring' },
  { vendor_id: 5, title: 'Dorm Cleaning', vendor_name: 'Janine Abbott', description: 'Will deep-clean your Carman or EC suite.', price: 40.00, category: 'Cleaning' },
  { vendor_id: 3, title: 'Furniture Pickup', vendor_name: 'Hannah Lasso', description: 'Selling gently used IKEA desk and chair. Can deliver anywhere on campus.', price: 60.00, category: 'Other' },
  { vendor_id: 6, title: 'Print Station Helper', vendor_name: 'Sam Patel', description: 'Trouble printing in Butler or Mudd? I’ll meet you and help debug it.', price: 5.00, category: 'Tech Help' },
  { vendor_id: 7, title: 'Resume Review & Interview Prep', vendor_name: 'Emily Chen', description: 'Peer review of CS and engineering resumes. Includes mock interviews.', price: 30.00, category: 'Tutoring' },
  { vendor_id: 8, title: 'Bike Rentals Around Campus', vendor_name: 'Lina Morales', description: 'Rent my foldable bike for quick trips around Morningside Heights.', price: 15.00, category: 'Transportation' },
  { vendor_id: 9, title: 'Laundry Folding Service', vendor_name: 'Maya Brooks', description: 'I’ll fold and organize your washed clothes for you. Pickup from John Jay.', price: 12.00, category: 'Cleaning' },
  { vendor_id: 10, title: 'Headshots for LinkedIn', vendor_name: 'Chris Ramos', description: 'Quick professional headshots taken on Low Steps. DSLR + retouching included.', price: 25.00, category: 'Other' },
  { vendor_id: 1, title: 'Manicures', vendor_name: 'John Doe', description: 'Able to do acrylics, gel, and more!', price: 65.00, category: 'Other' },
  { vendor_id: 1, title: 'Moving Out Services', vendor_name: 'John Doe', description: 'Focus on finals while I package and prep your room for moving out in one day.', price: 25.00, category: 'Other' },
  { vendor_id: 4, title: 'Home-Made Baked Goods', vendor_name: 'Barbara Reddington', description: 'Fresh baked goods delivered to you personally!', price: 15.00, category: 'Food' }
]

Service.delete_all
services.each do |service|
  Service.create!(service)
end

puts "Created #{Service.count} services!"

# --- Create Reviews from client to vendor and vendor to client ---
reviews = [
    { client_id: 1, vendor_id: 3, vendor_name: 'Hannah Lasso', title: 'Furniture Pickup', rating: 4, comment: 'Personally delivered to me.', reviewer: "client", client_name: "John Doe" },
    { client_id: 2, vendor_id: 3, vendor_name: 'Hannah Lasso', title: 'Furniture Pickup', rating: 3, comment: 'My chair had a scratch on the back.', reviewer: "client", client_name: "Kathy Lee" },
    { client_id: 5, vendor_id: 3, vendor_name: 'Hannah Lasso', title: 'Furniture Pickup', rating: 5, comment: 'Was really friendly.', reviewer: "client", client_name: "Janine Abbott" },
    { client_id: 4, vendor_id: 3, vendor_name: 'Hannah Lasso', title: 'Furniture Pickup', rating: 5, comment: 'Sold at a really good price', reviewer: "client", client_name: "Barbara Reddington" },
  

    { client_id: 1, vendor_id: 5, vendor_name: 'Janine Abbott', title: 'Dorm Cleaning', rating: 5, comment: 'My room was super clean when I got back.', reviewer: "client", client_name: "John Doe" },
    { client_id: 4, vendor_id: 5, vendor_name: 'Janine Abbott', title: 'Dorm Cleaning', rating: 5, comment: 'She left behind a scented candle that smelled really good.', reviewer: "client", client_name: "Barbara Reddington" },
    { client_id: 6, vendor_id: 5, vendor_name: 'Janine Abbott', title: 'Dorm Cleaning', rating: 5, comment: 'Our EC suite has never looked better.', reviewer: "client", client_name: "Sam Patel" },
    { client_id: 7, vendor_id: 5, vendor_name: 'Janine Abbott', title: 'Dorm Cleaning', rating: 4, comment: 'MGreat service and very convenient.', reviewer: "client", client_name: "Emily Chen" },
    { client_id: 8, vendor_id: 5, vendor_name: 'Janine Abbott', title: 'Dorm Cleaning', rating: 4, comment: 'A few small spots were missed, but overall a great experience.', reviewer: "client", client_name: "Lina Morales" },

    { client_id: 7, vendor_id: 6, vendor_name: 'Sam Patel', title: 'Print Station Helper', rating: 4, comment: 'Sam has been an incredibly reliable resource throughout the semester.', reviewer: "client", client_name: "Emily Chen" },
    { client_id: 8, vendor_id: 6, vendor_name: 'Sam Patel', title: 'Print Station Helper', rating: 5, comment: 'I was impressed by how knowledgeable and patient Sam was.', reviewer: "client", client_name: "Lina Morales" },
    { client_id: 9, vendor_id: 6, vendor_name: 'Sam Patel', title: 'Print Station Helper', rating: 5, comment: 'Sam provides timely and effective support that genuinely supports student productivity.', reviewer: "client", client_name: "Maya Brooks" },
    { client_id: 10, vendor_id: 6, vendor_name: 'Sam Patel', title: 'Print Station Helper', rating: 4, comment: "Every interaction I've had with Sam has been professional and efficient.", reviewer: "client", client_name: "Chris Ramos" },
    { client_id: 1, vendor_id: 6, vendor_name: 'Sam Patel', title: 'Print Station Helper', rating: 5, comment: "Sam is a standout student service at Columbia.", reviewer: "client", client_name: "John Doe" },

    { client_id: 2, vendor_id: 1, vendor_name: 'John Doe', title: 'Tutoring – COMS W1004', rating: 3, comment: 'The tutor was knowledgeable about Java, but some explanations felt rushed, especially when we moved into loops and classes.', reviewer: "client", client_name: "Kathy Lee" },
    { client_id: 3, vendor_id: 1, vendor_name: 'John Doe', title: 'Tutoring – COMS W1004', rating: 4, comment: 'Overall a decent tutor who knows the material well.', reviewer: "client", client_name: "Hannah Lasso" },
    { client_id: 4, vendor_id: 1, vendor_name: 'John Doe', title: 'Tutoring – COMS W1004', rating: 3, comment: "The tutor helped clarify syntax errors and basic concepts, but the teaching style didn't always match how I learn.", reviewer: "client", client_name: "Barbara Reddington" },
    { client_id: 5, vendor_id: 1, vendor_name: 'John Doe', title: 'Tutoring – COMS W1004', rating: 4, comment: "Good understanding of Intro to Java topics and helpful with debugging.", reviewer: "client", client_name: "Janine Abbott" },
    { client_id: 6, vendor_id: 1, vendor_name: 'John Doe', title: 'Tutoring – COMS W1004', rating: 3, comment: "The tutor was helpful for specific questions, but I struggled when new concepts were introduced quickly.", reviewer: "client", client_name: "Sam Patel" },

    { client_id: 3, vendor_id: 2, vendor_name: 'Kathy Lee', title: 'Meal Swipes', rating: 1, comment: 'Hard to coordinate and slow to respond.', reviewer: "client", client_name: "Hannah Lasso" },
    { client_id: 4, vendor_id: 2, vendor_name: 'Kathy Lee', title: 'Meal Swipes', rating: 2, comment: 'The swipe itself worked, but communication was frustrating. Plans changed last minute and it felt disorganized.', reviewer: "client", client_name: "Barbara Reddington" },
    { client_id: 5, vendor_id: 2, vendor_name: 'Kathy Lee', title: 'Meal Swipes', rating: 1, comment: "Didn't have a great experience. We set a time at JJ's and she didn't show up.", reviewer: "client", client_name: "Janine Abbott" },
    { client_id: 6, vendor_id: 2, vendor_name: 'Kathy Lee', title: 'Meal Swipes', rating: 2, comment: 'Pretty average experience. The meetup happened, but it took a lot of back-and-forth and waiting around.', reviewer: "client", client_name: "Sam Patel" },
    { client_id: 7, vendor_id: 2, vendor_name: 'Kathy Lee', title: 'Meal Swipes', rating: 1, comment: "Unreliable overall. Communication was inconsistent and the meetup location kept changing.", reviewer: "client", client_name: "Emily Chen" },

    { client_id: 10, vendor_id: 9, vendor_name: 'Maya Brooks', title: 'Laundry Folding Service', rating: 5, comment: "Maya did an amazing job folding and organizing my clothes.", reviewer: "client", client_name: "Chris Ramos" },
    { client_id: 1, vendor_id: 9, vendor_name: 'Maya Brooks', title: 'Laundry Folding Service', rating: 5, comment: "Really solid service overall. My clothes were folded neatly and smelled clean.", reviewer: "client", client_name: "John Doe" },
    { client_id: 2, vendor_id: 9, vendor_name: 'Maya Brooks', title: 'Laundry Folding Service', rating: 4, comment: "Super helpful during a busy week. Maya was reliable, friendly, and clearly took care with organizing everything.", reviewer: "client", client_name: "Kathy Lee" },
    { client_id: 3, vendor_id: 9, vendor_name: 'Maya Brooks', title: 'Laundry Folding Service', rating: 5, comment: "Great experience. Clothes were folded better than I would've done myself.", reviewer: "client", client_name: "Hannah Lasso" },
    { client_id: 4, vendor_id: 9, vendor_name: 'Maya Brooks', title: 'Laundry Folding Service', rating: 4, comment: "Easy and stress-free service.", reviewer: "client", client_name: "Barbara Reddington" },

    { client_id: 9, vendor_id: 8, vendor_name: 'Lina Morales', title: 'Bike Rentals Around Campus', rating: 4, comment: "The bike was in good condition and worked well for getting around campus.", reviewer: "client", client_name: "Maya Brooks" },
    { client_id: 10, vendor_id: 8, vendor_name: 'Lina Morales', title: 'Bike Rentals Around Campus', rating: 3, comment: "Decent experience overall. The bike was functional, but the seat height took some time to adjust and wasn’t super comfortable.", reviewer: "client", client_name: "Chris Ramos" },
    { client_id: 1, vendor_id: 8, vendor_name: 'Lina Morales', title: 'Bike Rentals Around Campus', rating: 4, comment: "Convenient and affordable for getting around Morningside Heights.", reviewer: "client", client_name: "John Doe" },
    { client_id: 2, vendor_id: 8, vendor_name: 'Lina Morales', title: 'Bike Rentals Around Campus', rating: 3, comment: "The bike did the job, but it wasn't as smooth as I expected on longer rides.", reviewer: "client", client_name: "Kathy Lee" },
    { client_id: 3, vendor_id: 8, vendor_name: 'Lina Morales', title: 'Bike Rentals Around Campus', rating: 3, comment: "Good value for the price. The bike was easy to handle and useful for running errands nearby.", reviewer: "client", client_name: "Hannah Lasso" },

    { client_id: 1, vendor_id: 10, vendor_name: 'Chris Ramos', title: 'Headshots for LinkedIn', rating: 1, comment: "The photos didn't come out very professional.", reviewer: "client", client_name: "John Doe" },
    { client_id: 2, vendor_id: 10, vendor_name: 'Chris Ramos', title: 'Headshots for LinkedIn', rating: 2, comment: "Chris was friendly, but the session felt rushed.", reviewer: "client", client_name: "Kathy Lee" },
    { client_id: 3, vendor_id: 10, vendor_name: 'Chris Ramos', title: 'Headshots for LinkedIn', rating: 2, comment: "Not a great experience overall. The photos were slightly blurry.", reviewer: "client", client_name: "Hannah Lasso" },
    { client_id: 4, vendor_id: 10, vendor_name: 'Chris Ramos', title: 'Headshots for LinkedIn', rating: 1, comment: "The idea is good, but execution could be better.", reviewer: "client", client_name: "Barbara Reddington" },
    { client_id: 5, vendor_id: 10, vendor_name: 'Chris Ramos', title: 'Headshots for LinkedIn', rating: 2, comment: "Communication was fine, but the results were disappointing. The lighting and angles weren’t flattering.", reviewer: "client", client_name: "Janine Abbott" },

    { client_id: 2, vendor_id: 1, vendor_name: 'John Doe', title: 'Moving Out Services', rating: 5, comment: "John was a lifesaver during finals week. He packed everything neatly and efficiently.", reviewer: "client", client_name: "Kathy Lee"},
    { client_id: 4, vendor_id: 1, vendor_name: 'John Doe', title: 'Moving Out Services', rating: 4, comment: "Really helpful service overall. John was organized and got everything packed in one day as promised.", reviewer: "client", client_name: "Barbara Reddington"},
    { client_id: 6, vendor_id: 1, vendor_name: 'John Doe', title: 'Moving Out Services', rating: 5, comment: "This made moving out so much less stressful.", reviewer: "client", client_name: "Sam Patel"},
    { client_id: 8, vendor_id: 1, vendor_name: 'John Doe', title: 'Moving Out Services', rating: 4, comment: "Great value for the price, especially during a busy time.", reviewer: "client", client_name: "Lina Morales"},
    { client_id: 10, vendor_id: 1, vendor_name: 'John Doe', title: 'Moving Out Services', rating: 4, comment: "Could not have asked for a better moving-out experience.", reviewer: "client", client_name: "Chris Ramos"},

    { client_id: 5, vendor_id: 4, vendor_name: 'Barbara Reddington', title: 'Home-Made Baked Goods', rating: 4, comment: "The desserts were fresh and clearly homemade.", reviewer: "client", client_name: "Janine Abbott"},
    { client_id: 6, vendor_id: 4, vendor_name: 'Barbara Reddington', title: 'Home-Made Baked Goods', rating: 3, comment: "The desserts were tasty, but a bit sweeter than I expected.", reviewer: "client", client_name: "Sam Patel"},
    { client_id: 7, vendor_id: 4, vendor_name: 'Barbara Reddington', title: 'Home-Made Baked Goods', rating: 3, comment: "The quality was good, but the selection felt limited.", reviewer: "client", client_name: "Emily Chen"},
    { client_id: 8, vendor_id: 4, vendor_name: 'Barbara Reddington', title: 'Home-Made Baked Goods', rating: 4, comment: "You can tell the desserts were made with care.", reviewer: "client", client_name: "Lina Morales"},
    { client_id: 9, vendor_id: 4, vendor_name: 'Barbara Reddington', title: 'Home-Made Baked Goods', rating: 4, comment: "Nice homemade desserts and easy delivery.", reviewer: "client", client_name: "Maya Brooks"},

    { client_id: 8, vendor_id: 7, vendor_name: 'Emily Chen', title: 'Resume Review & Interview Prep', rating: 1, comment: "The session didn't feel very tailored to CS roles.", reviewer: "client", client_name: "Lina Morales"},
    { client_id: 9, vendor_id: 7, vendor_name: 'Emily Chen', title: 'Resume Review & Interview Prep', rating: 2, comment: "Emily was friendly, but the resume review felt rushed.", reviewer: "client", client_name: "Maya Brooks"},
    { client_id: 10, vendor_id: 7, vendor_name: 'Emily Chen', title: 'Resume Review & Interview Prep', rating: 2, comment: "Decent for a quick peer review, but not worth the price in my opinion.", reviewer: "client", client_name: "Chris Ramos"},
    { client_id: 1, vendor_id: 7, vendor_name: 'Emily Chen', title: 'Resume Review & Interview Prep', rating: 1, comment: "Not very helpful for engineering resumes specifically.", reviewer: "client", client_name: "John Doe"},
    { client_id: 2, vendor_id: 7, vendor_name: 'Emily Chen', title: 'Resume Review & Interview Prep', rating: 1, comment: "I didn't get much out of the session.", reviewer: "client", client_name: "Kathy Lee"},

    { client_id: 2, vendor_id: 1, vendor_name: 'John Doe', title: 'Manicures', rating: 5, comment: 'My nails look amazing!', reviewer: "client", client_name: "Kathy Lee" },
    { client_id: 7, vendor_id: 1, vendor_name: 'John Doe', title: 'Manicures', rating: 5, comment: "The manicure turned out really nice and lasted well.", reviewer: "client", client_name: "Emily Chen" },
    { client_id: 9, vendor_id: 1, vendor_name: 'John Doe', title: 'Manicures', rating: 4, comment: "Decent manicure, but the session ran a little long and the shape wasn't exactly what I asked for.", reviewer: "client", client_name: "Maya Brooks" },
    { client_id: 3, vendor_id: 1, vendor_name: 'John Doe', title: 'Manicures', rating: 3, comment: "The final result was okay, just not perfect.", reviewer: "client", client_name: "Hannah Lasso" },

    { client_id: 1, vendor_id: 2, vendor_name: 'Kathy Lee', title: 'Meal Swipes', rating: 5, comment: "Great client to work with.", reviewer: "vendor", client_name: "John Doe" },
    { client_id: 1, vendor_id: 5, vendor_name: 'Janine Abbott', title: 'Dorm Cleaning', rating: 5, comment: "Very polite and easy to coordinate with.", reviewer: "vendor", client_name: "John Doe" },
    { client_id: 1, vendor_id: 3, vendor_name: 'Hannah Lasso', title: 'Furniture Pickup', rating: 4, comment: "They were organized, responsive, and made the process straightforward.", reviewer: "vendor", client_name: "John Doe" },

    { client_id: 2, vendor_id: 6, vendor_name: 'Sam Patel', title: 'Print Station Helper', rating: 4, comment: "Overall a good client to work with.", reviewer: "vendor", client_name: "Kathy Lee" },
    { client_id: 2, vendor_id: 7, vendor_name: 'Emily Chen', title: 'Resume Review & Interview Prep', rating: 3, comment: "Decent experience. The client was polite, but coordination took a bit longer than expected.", reviewer: "vendor", client_name: "Kathy Lee" },
    { client_id: 2, vendor_id: 8, vendor_name: 'Line Morales', title: 'Bike Rentals Around Campus', rating: 4, comment: "The client was respectful and responsive, and the service was completed without problems.", reviewer: "vendor", client_name: "Kathy Lee" },

    { client_id: 3, vendor_id: 9, vendor_name: 'Maya Brooks', title: 'Laundry Folding Service', rating: 2, comment: "Would prefer clearer communication in the future.", reviewer: "vendor", client_name: "Hannah Lasso" },
    { client_id: 3, vendor_id: 10, vendor_name: 'Chris Ramos', title: 'Headshots for LinkedIn', rating: 1, comment: "The client was unresponsive at key points and caused delays that could have been avoided with better coordination.", reviewer: "vendor", client_name: "Hannah Lasso" },
    { client_id: 3, vendor_id: 1, vendor_name: 'John Doe', title: 'Manicures', rating: 2, comment: "Expectations were unclear, which led to some frustration during the process.", reviewer: "vendor", client_name: "Hannah Lasso" },

    { client_id: 4, vendor_id: 1, vendor_name: 'John Doe', title: 'Moving Out Services', rating: 4, comment: "everything went smoothly from start to finish.", reviewer: "vendor", client_name: "Barbara Reddington" },
    { client_id: 4, vendor_id: 2, vendor_name: 'Kathy Lee', title: 'Meal Swipes', rating: 5, comment: "Would be happy to work with them again.", reviewer: "vendor", client_name: "Barbara Reddington" },
    { client_id: 4, vendor_id: 5, vendor_name: 'Janine Abbott', title: 'Dorm Cleaning', rating: 5, comment: "The interaction was efficient and professional throughout.", reviewer: "vendor", client_name: "Barbara Reddington" },

    { client_id: 5, vendor_id: 4, vendor_name: 'Barbara Reddington', title: 'Home-Made Baked Goods', rating: 4, comment: "The client was friendly and approachable.", reviewer: "vendor", client_name: "Janine Abbott" },
    { client_id: 5, vendor_id: 1, vendor_name: 'John Doe', title: 'Tutoring – COMS W1004', rating: 3, comment: "The client was polite but somewhat reserved, which made it harder to gauge expectations at times.", reviewer: "vendor", client_name: "Janine Abbott" },
    { client_id: 5, vendor_id: 3, vendor_name: 'Hannah Lasso', title: 'Furniture Pickup', rating: 4, comment: "Easygoing and respectful personality overall.", reviewer: "vendor", client_name: "Janine Abbott" },

    { client_id: 6, vendor_id: 7, vendor_name: 'Emily Chen', title: 'Resume Review & Interview Prep', rating: 1, comment: "The client came across as dismissive and difficult to communicate with.", reviewer: "vendor", client_name: "Sam Patel" },
    { client_id: 6, vendor_id: 8, vendor_name: 'Lina Morales', title: 'Bike Rentals Around Campus', rating: 2, comment: "Challenging personality to work with.", reviewer: "vendor", client_name: "Sam Patel" },
    { client_id: 6, vendor_id: 9, vendor_name: 'Maya Brooks', title: 'Laundry Folding Service', rating: 1, comment: "The client was uncooperative at times and seemed easily frustrated.", reviewer: "vendor", client_name: "Sam Patel" },

    { client_id: 7, vendor_id: 6, vendor_name: 'Sam Patel', title: 'Print Station Helper', rating: 5, comment: "Fantastic client to work with.", reviewer: "vendor", client_name: "Emily Chen" },
    { client_id: 7, vendor_id: 10, vendor_name: 'Chris Ramos', title: 'Headshots for LinkedIn', rating: 5, comment: "Great experience overall.", reviewer: "vendor", client_name: "Emily Chen" },
    { client_id: 7, vendor_id: 1, vendor_name: 'John Doe', title: 'Manicures', rating: 5, comment: "Clear communication, prompt follow-through, and a genuinely kind demeanor.", reviewer: "vendor", client_name: "Emily Chen" },

    { client_id: 8, vendor_id: 5, vendor_name: 'Janine Abbott', title: 'Dorm Cleaning', rating: 3, comment: "Pretty average experience.", reviewer: "vendor", client_name: "Lina Morales" },
    { client_id: 8, vendor_id: 2, vendor_name: 'Kathy Lee', title: 'Meal Swipes', rating: 3, comment: "The client was chill overall.", reviewer: "vendor", client_name: "Lina Morales" },
    { client_id: 8, vendor_id: 1, vendor_name: 'John Doe', title: 'Moving Out Services', rating: 2, comment: "After some back and forth, everything worked out fine.", reviewer: "vendor", client_name: "Lina Morales" },

    { client_id: 9, vendor_id: 4, vendor_name: 'Barbara Reddington', title: 'Home-Made Baked Goods', rating: 1, comment: "The client was pretty unresponsive and hard to work with.", reviewer: "vendor", client_name: "Maya Brooks" },
    { client_id: 9, vendor_id: 1, vendor_name: 'John Doe', title: 'Tutoring – COMS W1004', rating: 1, comment: "Definitely not a smooth interaction.", reviewer: "vendor", client_name: "Maya Brooks" },
    { client_id: 9, vendor_id: 3, vendor_name: 'Hannah Lasso', title: 'Furniture Pickup', rating: 1, comment: "Communication was really spotty and plans kept changing last minute.", reviewer: "vendor", client_name: "Maya Brooks" },

    { client_id: 10, vendor_id: 7, vendor_name: 'Emily Chen', title: 'Resume Review & Interview Prep', rating: 4, comment: "The client was engaged during my resume review session.", reviewer: "vendor", client_name: "Chris Ramos" },
    { client_id: 10, vendor_id: 8, vendor_name: 'Lina Morales', title: 'Bike Rentals Around Campus', rating: 5, comment: "Was able to maintain the bike rental in good condition for a week.", reviewer: "vendor", client_name: "Chris Ramos" },
    { client_id: 10, vendor_id: 9, vendor_name: 'Maya Brooks', title: 'Laundry Folding Service', rating: 4, comment: "Easy to coordinate with and communicated clearly about expectations for clothes.", reviewer: "vendor", client_name: "Chris Ramos" },

]


Review.delete_all
reviews.each do |review|
    Review.create!(review)
end

puts "Created #{Review.count} reviews!"
