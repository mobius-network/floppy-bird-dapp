# Floppy Bird Mobius DApp

Sample Mobius DApp Store application implemented using Ruby and the [Mobius DApp Store Ruby SDK](https://github.com/mobius-network/mobius-client-ruby).

## Setup

1. Clone https://github.com/mobius-network/mobius-client-ruby into `../mobius-client-ruby`

2. Run:
 ```
bundle
mobius-cli create dev-wallet
mv dev-wallet.html public/
 ```   
    
3. Start the server with `rails s`

4. Open http://localhost:3000/dev-wallet.html and copy the Application secret key.

5. Open config/secrets.yml and paste the secret key in line 22 for the secret_key value.

## Testing

1. If the server isn't running start it with: `rails s`

2. Visit http://localhost:3000/dev-wallet.html

3. Click Open under Normal Account.

4. Play Floppy Bird! Note when you click to start playing there is a pause of a couple seconds because it is in real-time making a blockchain payment! In a real app you would withdraw a larger number of MOBI at once to have some locally on deposit for the user to charge against.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mobius-network/mobius-client-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mobius::Client project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mobius-client/blob/master/CODE_OF_CONDUCT.md).
