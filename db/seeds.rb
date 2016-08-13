User.delete_all
Trail.delete_all
Crumb.delete_all
Favorite.delete_all
Active.delete_all
Tag.delete_all

erica = User.create!(username: "codingerica", email:"erica@gmail.com", password: "devbootcampallstar")

mason = User.create!(username: "codingmason", email:"mason@gmail.com", password: "devbootcampallstar")

marco = User.create!(username: "codingmarco", email:"marco@gmail.com", password: "devbootcampallstar")

prajay = User.create!(username: "codingprajay", email:"prajay@gmail.com", password: "devbootcampallstar")

order_priv = marco.created_trails.create!(name: "Walk in the Park", description: "The best places in Prospect Park", sequential: true, priv: true, published: true, password: "Brooklyn")

unorder_priv = marco.created_trails.create!(name: "Pier Challenge", description: "Find clues along the West Side Piers", sequential: false, priv: true, published: true, password: "Chelsea")

order_public = prajay.created_trails.create!(name: "Hidden Gems in Alphabet City", sequential: true, description: "Some of the best places you've never heard of.", priv: false, published: true)

unorder_public = prajay.created_trails.create!(name: "Rubin Museum", sequential: false, description: "Educate yourself on the 3rd floor exhibition", priv: false, published: true)

locked_crumb = unorder_public.crumbs.create!(name: "Nepalese Sculpture", description: "Which author discusses this story in Siddhartha?", requires_answer: true, latitude: 34.006, longitude: 546.27, answer: "Herman Hesse", order_number: 3)

unlocked_crumb = order_public.crumbs.create!(name: "The Counter", requires_answer: false, description: "Great burgers!", latitude: 34.006, longitude: 546.27, order_number: 1)

erica.favorites.create!(trail: unorder_public)

mason.actives.create!(trail: order_public)

Tag.create!(subject: "History")
Tag.create!(subject: "Food")
Tag.create!(subject: "Education")
Tag.create!(subject: "Vacation")
Tag.create!(subject: "Kid-Friendly")
Tag.create!(subject: "Bars/Alcohol")
Tag.create!(subject: "Art")
Tag.create!(subject: "Romantic")
Tag.create!(subject: "Competition")
Tag.create!(subject: "Outdoor")
Tag.create!(subject: "Indoor")
Tag.create!(subject: "Scavenger Hunt")
Tag.create!(subject: "Ghost Tour")
Tag.create!(subject: "Wine Tour")
Tag.create!(subject: "Culture")
Tag.create!(subject: "Celebration")
Tag.create!(subject: "Holiday")
Tag.create!(subject: "Music")

# mason.images.create!(http://s3.amazonaws.com/bucketname/filename)
# order_priv.images.create!()
# unlocked_crumb.images.create!()
# unlocked_crumb.sounds.create!()
