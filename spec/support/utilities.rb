include ApplicationHelper

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def sign_in(user)
  visit signin_path
  valid_signin(user)
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_doc_title do |title|
  match do |page|
    page.should have_selector('title', text: full_title(title))
  end
end

RSpec::Matchers.define :have_content_title do |title|
  match do |page|
      page.should have_selector('h1', text: title)
  end
end

RSpec::Matchers.define :be_page_by_title do |title|
  match do |page|
      page.should have_doc_title(title)
      page.should have_content_title(title)
  end
end