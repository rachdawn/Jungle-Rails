# Jungle

A mini e-commerce application, modeling an online plant shop, built with Rails 6.1.

!["Landing Page"](https://github.com/rachdawn/Jungle-Rails/blob/master/project-screenshots/JungleLandingPage.png?raw=true)

!["My Cart"](https://github.com/rachdawn/Jungle-Rails/blob/master/project-screenshots/JungleCart.png?raw=true)

!["About Us"](https://github.com/rachdawn/Jungle-Rails/blob/master/project-screenshots/JungleAboutUs.png?raw=true)

!["Sign Up"](https://github.com/rachdawn/Jungle-Rails/blob/master/project-screenshots/JungleSignUp.png?raw=true)

## Setup and Installation

1. Clone the repository:
```bash
git clone git@github.com:rachdawn/Jungle-Rails.git
```
2. Navigate to the project's directory:
 ```bash
cd Jungle-Project
```
3. Run `bundle install` to install dependencies
4. Create `config/database.yml` by copying `config/database.example.yml`
5. Create `config/secrets.yml` by copying `config/secrets.example.yml`
6. Run `bin/rails db:reset` to create, load and seed db
7. Create .env file based on .env.example
8. Sign up for a Stripe account
9. Put Stripe (test) keys into appropriate .env vars
10. Run `bin/rails s -b 0.0.0.0` to start the server

## Database

If Rails is complaining about authentication to the database, uncomment the user and password fields from `config/database.yml` in the development and test sections, and replace if necessary the user and password `development` to an existing database user.

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

- Rails 6.1 [Rails Guide](http://guides.rubyonrails.org/v6.1/)
- Bootstrap 5
- PostgreSQL 9.x
- Stripe
