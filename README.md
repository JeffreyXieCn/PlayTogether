# PlayTogether Web App

This is a web app called PlayTogether&trade;, it's running now at https://playtogetherbyjeffrey.herokuapp.com/

I created this web app during my spare time. At this moment, it's possible for people to create clubs, join a club as a member, organize an activity so that club members can participate, and charge members for their participation from their balances, and club admin can recharge a member's balance.

In fact, I am motivated to develop this app to make my own life easier in the first place. Since I like playing badminton, I established a badminton club in my neighborhood, and we usually play together during Saturday nights, previously I am using online Google Sheets to manage club members, activities, charging and recharging, this quickly becomes tedious and cumbersome, and it's not scalable. Then I realized that "Hey, I am a software engineer, why not develop an app to make my life easier by automating these tasks as much as possible, perhaps it will also make other people's lives easier! " :-)

## License

To be determined

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```
