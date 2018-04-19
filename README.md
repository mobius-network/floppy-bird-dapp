# Mobius Floppy Bird DApp

Sample Mobius DApp Store application implemented using Ruby and the [Mobius DApp Store Ruby SDK](https://github.com/mobius-network/mobius-client-ruby).

## Setup

1. Run:
```
bundle
mobius-cli create dev-wallet
mv dev-wallet.html public/
```   

2. Start the server with `rails s`

3. Open http://localhost:3000/dev-wallet.html and copy the Application Private Key.

4. Open [config/secrets.yml](https://github.com/mobius-network/floppy-bird-dapp/blob/master/config/secrets.yml) and paste the secret key in the shared/app/secret_key value.

```
shared:
  app:
    secret_key: PASTE_SECRET_KEY_HERE
    jwt_secret: 431714aa54beec753975eaffba3db12d43d4ee52cafeb3ddcdbea05903e3a3ee78ff1f49d56b23df16597bc15f6d6099aef2f668aa38f957ffc960a5445aa8fb
```

5. Stop the server (Ctrl + C)

## Testing

1. Start the server with `rails s`

2. Visit http://localhost:3000/dev-wallet.html

3. Click Open under Normal Account.

4. Play Floppy Bird! Note when you click to start playing there is a pause of a couple seconds because it is in real-time making a blockchain payment! In a real app you would withdraw a larger number of MOBI at once to have some locally on deposit for the user to charge against.

## Code Overview

### Server Side

The server side code is very simple and is copied from the [Mobius DApp Store Ruby SDK](https://github.com/mobius-network/mobius-client-ruby).

There are two parts to the server code:

1) Authentication - located in [app/controllers/auth_controller.rb](https://github.com/mobius-network/floppy-bird-dapp/blob/master/app/controllers/auth_controller.rb)

2) Payment - located in [app/controllers/app_controller.rb](https://github.com/mobius-network/floppy-bird-dapp/blob/master/app/controllers/app_controller.rb)

Both are documented in the [Mobius DApp Store Ruby SDK](https://github.com/mobius-network/mobius-client-ruby).

### Client Side

The client side code is similarly very simple. It started as a fork of <https://github.com/nebez/floppybird/> and is located in [public/flappy_bird](https://github.com/mobius-network/floppy-bird-dapp/tree/master/public/flappy_bird).

To add MOBI payment support we made the following changes

[index.html](https://github.com/mobius-network/floppy-bird-dapp/blob/master/public/flappy_bird/js/index.html):
 
1. We added a div `#credits_balance` on [line 41](https://github.com/mobius-network/floppy-bird-dapp/blob/master/public/flappy_bird/index.html#L41) to show info such as the player's current MOBI balance.
 
[main.js](https://github.com/mobius-network/floppy-bird-dapp/blob/master/public/flappy_bird/js/main.js).

1. The code expects the `token` value used to identify this user to be passed in via the URL `token` parameter and we save it in a new variable `g_token` on [line 69](https://github.com/mobius-network/floppy-bird-dapp/blob/master/public/flappy_bird/js/main.js#L69)

2. In the `$(document).ready` callback function on [line 87](https://github.com/mobius-network/floppy-bird-dapp/blob/master/public/flappy_bird/js/main.js#L87) we get the player's balance from the server by calling the `/balance` endpoint and pass in the `g_token` value to identify the current player. The `#credits_balance` div is updated with the value on response.

3. On [line 141](https://github.com/mobius-network/floppy-bird-dapp/blob/master/public/flappy_bird/js/main.js#L141) we create a new `startGame` function that delays starting a new game until payment is successful. On successful payment it calls `startGameReal` the original `startGame` function. 

In the `startGame` function on [line 148](https://github.com/mobius-network/floppy-bird-dapp/blob/master/public/flappy_bird/js/main.js#L148) we updated the `#credits_balance` div to say "Paying........."

On [line 150](https://github.com/mobius-network/floppy-bird-dapp/blob/master/public/flappy_bird/js/main.js#L150) the `pay` server call is made passing `g_token` to identify the player. If payment is successful the game is started by calling `startGameReal` on [line 154](https://github.com/mobius-network/floppy-bird-dapp/blob/master/public/flappy_bird/js/main.js#L154).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mobius-network/mobius-client-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mobius::Client project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mobius-client/blob/master/CODE_OF_CONDUCT.md).
