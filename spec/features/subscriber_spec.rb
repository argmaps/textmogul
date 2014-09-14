require 'spec_helper'

feature 'Signing up subscriber' do
  background do
    admin = Admin.create(first_name: random_letters, last_name: random_letters, stripe_secret_key: ENV['STRIPE_SECRET_KEY'], stripe_publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
                         subdomain: random_letters, email: random_letters + '@gmail.com', password: random_letters)
    Plan.find_or_create_by(name: 'TextMogulSubscriber1', stripe_id: 'TMS1', price: 2.99, interval: 'month', user: admin)
  end

  scenario "Signing up with correct info", js: true do
    full_name = random_letters + ' ' + random_letters
    email = random_letters + '@gmail.com'

    visit new_subscriber_path
    fill_in 'E-mail', with: email
    fill_in 'Password', with: 'password'
    select('Viet Nam', :from => 'subscriber_country')
    fill_in 'Phone', with: 123456789
    fill_in 'number', with: '4242424242424242'
    fill_in 'name', with: full_name
    fill_in 'expiry', with: '08/17'
    fill_in 'cvc', with: '333'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome'
  end

end
