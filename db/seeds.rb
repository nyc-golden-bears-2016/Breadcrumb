erica = User.create!()

mason =

marco =

prajay =

order_priv = marco.ordered.create!()
unorder_priv = marco.unordered.create!()

order_public = prajay.ordered.create!()
unorder_public = prajay.unordered.create!()

test_crumb = unorder_public.crumbs.create!()

erica.favorites.create!()

mason.expriences.create!()

test_crumb.images.create!()
test_crumb.sounds.create!()
