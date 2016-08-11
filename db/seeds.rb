erica = User.create!()

mason =

marco =

prajay =

order_priv = marco.ordered.create!()
unorder_priv = marco.unordered.create!()

order_public = prajay.ordered.create!()
unorder_public = prajay.unordered.create!()

locked_crumb = order_public.locked.create!()
unlocked_crumb = order_public.unlocked.create!()

erica.favorites.create!()

mason.expriences.create!()

unlocked_crumb.images.create!()
unlocked_crumb.sounds.create!()
