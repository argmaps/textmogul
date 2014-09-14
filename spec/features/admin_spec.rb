require 'spec_helper'

feature 'Signing up admin' do
  background do
    Plan.find_or_create_by(name: 'TextMogul1', stripe_id: 'TM1', price: 39.95, interval: 'month')
  end

  scenario "Signing up with correct info", js: true do
    full_name = random_letters + ' ' + random_letters
    subdomain = random_letters
    email = random_letters + '@gmail.com'

    visit new_admin_path
    fill_in 'E-mail', with: email
    fill_in 'Password', with: 'password'
    fill_in 'admin_subdomain', with: subdomain
    fill_in 'admin_stripe_secret_key', with: 'sk_test_xxxxxxxxxxxxxxx'
    fill_in 'admin_stripe_publishable_key', with: 'pk_test_xxxxxxxxxxxxxxx'
    fill_in 'number', with: '4242424242424242'
    fill_in 'name', with: full_name
    fill_in 'expiry', with: '08/17'
    fill_in 'cvc', with: '333'
    click_button 'Sign up'

    expect(page).to have_content 'Hi there'
  end

end
