User.delete_all
Trail.delete_all
Crumb.delete_all
Favorite.delete_all
Active.delete_all
ActiveCrumb.delete_all
Tag.delete_all
TagTrail.delete_all

erica = User.create!(username: "codingerica", email:"erica@gmail.com", password: "bootcamp")

mason = User.create!(username: "codingmason", email:"mason@gmail.com", password: "bootcamp")

marco = User.create!(username: "codingmarco", email:"marco@gmail.com", password: "bootcamp")

prajay = User.create!(username: "codingprajay", email:"prajay@gmail.com", password: "bootcamp")


e1 = Tag.create!(subject: "Bars/Alcohol")
e2 = Tag.create!(subject: "Outdoor")
e3 = Tag.create!(subject: "Wine Tour")
m1 = Tag.create!(subject: "Culture")
m2 = Tag.create!(subject: "History")
Tag.create!(subject: "Education")
Tag.create!(subject: "Vacation")
Tag.create!(subject: "Kid-Friendly")
Tag.create!(subject: "Art")
Tag.create!(subject: "Romantic")
Tag.create!(subject: "Competition")
Tag.create!(subject: "Indoor")
Tag.create!(subject: "Celebration")
Tag.create!(subject: "Scavenger Hunt")
Tag.create!(subject: "Ghost Tour")
Tag.create!(subject: "Food")
Tag.create!(subject: "Holiday")
Tag.create!(subject: "Music")


fidi = mason.created_trails.create!(name: "Places we can test!", description: "A lovely walk in the oppresive heat.", priv: false, published: true, latitude: 40.706417, longitude: -74.009082)

TagTrail.create!(trail: fidi, tag: m1)
TagTrail.create!(trail: fidi, tag: m2)

fidi.crumbs.create!(name: "New York Stock Exchange", description: "High-tech home of one of the world's leading financial markets.", requires_answer: false, latitude: 40.706417, longitude: -74.009082, order_number: 1)

fidi.crumbs.create!(name: "The Charging Bull", description: "Charging Bull, which is sometimes referred to as the Wall Street Bull or the Bowling Green Bull is a bronze sculpture, that stands in Bowling Green Park. What is the name of the sculptor?", requires_answer: true, latitude: 40.705496, longitude: -74.013326, answer: "Arturo Di Modica", order_number: 2)

fidi.crumbs.create!(name: "Federal Hall", description: "Federal Hall, built in 1700 as New York's City Hall, later served as the first capitol building of the United States of America under the Constitution, as well as the site of George Washington's inauguration as the first President of the United States.", requires_answer: false, latitude: 40.707130, longitude: -74.010397, order_number: 3)

longisland = erica.created_trails.create!(name: "North Shore Wine Tour", description: "Find clues along the West Side Piers", sequential: false, priv: true, published: true, password: "vino", latitude: 40.991211, longitude: -72.534255)

TagTrail.create!(trail: longisland, tag: e1)
TagTrail.create!(trail: longisland, tag: e2)
TagTrail.create!(trail: longisland, tag: e3)

longisland.crumbs.create!(name: "Macari Vineyards", requires_answer: false, latitude: 40.986174, longitude: -72.567444, order_number: 1)

longisland.crumbs.create!(name: "Shinn Estate Vineyards and Farmhouse", requires_answer: false, latitude: 41.013866, longitude: -72.532554, order_number: 2)

longisland.crumbs.create!(name: "Castello di Borghese Vineyard", requires_answer: false, latitude: 41.016651, longitude: -72.506247, order_number: 3)
