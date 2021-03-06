require 'acceptance/acceptance_helper'

feature 'Article' do
  # TODO: find a better way to do this ;)
  around do |example|
    blog = "#{Rails.root}/app/blog"
    #article = "#{articles}/acceptance-testing-articles.html"

    `mkdir -p #{blog}`
    `mv #{blog} #{blog}_backup`
    `ln -s #{Rails.root}/spec/fixtures/blog #{blog}`
    example.run
    `rm #{blog}`
    `mv #{blog}_backup #{blog}`
  end
  
  scenario 'visit the article index' do
    visit '/'
    click_link 'News'
    page.should have_content 'Acceptance testing articles'
  end
  
  context 'on the article index' do
    before { visit '/articles' }

    scenario 'show links to the articles' do
      page.should have_link 'Acceptance testing articles'
      body.should include '/articles/acceptance-testing-articles'
    end

  end

  context 'on an article page' do
    before { visit '/articles/acceptance-testing-articles' }

    scenario 'show the full article' do
      page.should have_content 'Acceptance testing articles'
      page.should have_content 'Running Jekyll in Rails. How do you test that?!'
    end

  end

end