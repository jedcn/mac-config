#!/bin/bash

REPO=mac-config
echo "Syncing Github Pages Build for $REPO.."

#
# What SHA are we going to deploy?
SHA=$(git rev-parse --short HEAD)

#
# When you build the static site, where is it generated?
BUILD_DIR=gh-pages

#
# Create the static site in ./gh-pages
rake build-gh-pages

#
# What branch serves as the source for Github Pages for this repo?
#
# Usually this is 'gh-pages', but it can be 'master' if you're dealing
# with a site for a User or an Organization.
GH_PAGES_BRANCH=gh-pages

#
# Where will clone locally to, copying on top of, etc.
WORK_DIR=tmp/$GH_PAGES_BRANCH

# Step 0
echo "Cleaning up from last time.."
rm -rf $WORK_DIR
echo
echo

# Step 1
echo "Creating local copy of Github Page Branch"
mkdir -vp $WORK_DIR
GITHUB_URL=https://github.com/jedcn/$REPO.git
git clone $GITHUB_URL --branch $GH_PAGES_BRANCH --single-branch $WORK_DIR
echo
echo

# Step 2
echo "Deleting old content (but saving circle.yml)"
pushd $WORK_DIR
git rm -rf *
save_these_files="css/main.css css/prism.css js/vendor/prism.js"
for file in $save_these_files
do
  git reset HEAD $file
  git checkout $file
done
popd
echo
echo

# Step 3
echo "Copying over build"
cp -r $BUILD_DIR/* $WORK_DIR
echo
echo

# step 4
echo "Adding all files and creating new commit"
pushd $WORK_DIR
git add .
git commit -m "[deploy] Generated from $SHA"
popd
echo
echo

# Step 5
echo "Deploying.. (by pushing new commit)"
pushd $WORK_DIR
git push origin $GH_PAGES_BRANCH:$GH_PAGES_BRANCH
popd
