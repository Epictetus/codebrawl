# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Contests' do

  context 'on a contest page' do

    background :all do
      @contest = Contest.make(
        :name => 'RSpec extensions',
        :description => 'Write an [RSpec](http://relishapp.com/rspec) extension that solves a problem you are having.',
        :entries => [

          Entry.make(
            :description => 'I wrote an RSpec formatter to show the test run\'s progress instead of just showing how many specs passed and failed up to now. It\'s [on Github](http://github.com/jeffkreeftmeijer/fuubar)'
          )
        ]
      )
    end

    background { visit "/contests/#{@contest.slug}" }

    scenario 'read the markdown contest description' do
      body.should include 'Write an <a href="http://relishapp.com/rspec">RSpec</a> extension that solves a problem you are having.'
    end

    scenario 'go to the entry form' do
      click_link 'Enter'
      page.should have_content 'Submit your entry for “RSpec extensions”'
    end

    scenario 'see the contest entries' do
      page.should have_content 'I wrote an RSpec formatter to show the test run’s progress instead of just showing how many specs passed and failed up to now.'
      body.should include('<a href="http://github.com/jeffkreeftmeijer/fuubar">on Github</a>')
    end

  end

end