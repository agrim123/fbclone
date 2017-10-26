# Connector Chat (fbclone)

A simple social networking app. I actually did it as a summer project so, and i have tried to eliminate all errors in the existing app ,still some errors may prevail (like some dropdown menus or notifications!!), i am trying to remove these errors.

## Motivation

I started web development a year ago. For practice I came up with this idea. It was a hard start with all new real time things and websockets. But as it turned out rails is extremly powerful and simple. It gives so much flexibilty.

## Installation
1) For dev
```ruby
bundle install
rake db:create
rake db:migrate
rails s
``` 
2) For production

Make an account on [heroku.com](https://heroku.com)
Push the code to heroku and make sure code uploads successfully (queries are most welcome)
Also for chat option to work u need to set up another server on heroku. You can find the code for faye server [here](https://github.com/agrim123/fayeserver)

If you did everything correctly and without errors then congrats you have your own social networking platform. Enjoy :-)

## TODO

- [ ] Encrypt the users id in address bar
- [ ] Tag users
- [ ] Autocomplete serach bar
- [ ] Autocomplete tag bar
- [ ] Chat search
- [ ] Different title on diff page
- [ ] Like on comments
- [ ] Reply to comments
- [ ] Multiple photo upload
- [ ] Ajax search

## Contributions

Your ideas and any improvements in the current project are most welcome.


