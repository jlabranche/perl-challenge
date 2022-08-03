# perl-challenge
challenge

# Food Truck - Requirements

As the doo-da man says, "you've got to play your hand", and in this case your hand is to implement this food truck app.
Our team loves to eat. They are also a team that loves variety, so they also like to discover new places to eat.
In fact, we have a particular affection for food trucks. One of the great things about Food Trucks in San Francisco is that the city releases a list of them as open data.
Your assignment is to make it possible for our teams to do something with this food trucks data.
This is a freeform assignment. You can write a web API that returns a set of food trucks. You can write a web frontend that visualizes the nearby food trucks for a given place. You can create a CLI that lets us get the names of all the taco trucks in the city. You're not limited by these ideas at all, but hopefully those are enough help spark your own creativity.
San Francisco's food truck open dataset is located here and there is an endpoint with a CSV dump of the latest data here. We've also included a copy of the data in this repo as well.


# install instructions
brew install msyql
brew services start mysql
mysql_secure_installation -h 127.0.0.1
mysql -u root -p
cpan install Carton
cpan install String::ShellQuote
carton install

# Got'chas
brew services start mysql
Error: Permission denied @ rb_sysopen - /Users/<username>/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
Solution: sudo chown `whoami` $HOME/Library/LaunchAgents/

problems installing Carton
sudo chown `whoami` /usr/local/bin/
sudo chown `whoami` /Library/Perl/$perlVersion
