train_cats = categorical(train_labels);
train_cats = grp2idx(train_cats);
test_cats = categorical(test_labels);
test_cats = grp2idx(test_cats);

nn = kNN(@getDifference, 3, train_image_feats, test_image_feats, train_cats);