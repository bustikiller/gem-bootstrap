#!/bin/bash -l 

GEM_NAME=$1

bundle gem $GEM_NAME --mit --test=rspec

cd $GEM_NAME

echo $(pwd)

sed -i '/spec.summary/c\  spec.summary       = "Summary of gem"' $GEM_NAME.gemspec
sed -i '/spec.description/c\  spec.description   = "Description of gem"' $GEM_NAME.gemspec
sed -i '/spec.homepage/c\  spec.homepage      = ""' $GEM_NAME.gemspec

git add $GEM_NAME.gemspec
git commit -m "Fix gemspec with default summary and description"

rvm --ruby-version use 2.5.1@$GEM_NAME

git add .ruby-gem .ruby-version
git commit -m "Generate rvm files"

bundle install

git add Gemfile.lock
git commit -m "Generate Gemfile.lock"