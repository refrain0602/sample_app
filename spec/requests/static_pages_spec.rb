require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
		
		visit '/static_pages/home'
		expect( page ).to have_content('Sample App')

      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get static_pages_index_path
#      response.status.should be(200)

    end

	it "shoud have the title 'Home'" do
	
		visit '/static_pages/home'
		expect( page ).to have_title("Ruby on Rails Tutorial Sample App | Home")
	
	end

  end
  
  
  describe "Help page" do
  
  	it "should have the content 'Help'" do
  	
  		visit '/static_pages/help'
  		
  		expect( page).to have_content('Help')
  	
  	end
  
	it "shoud have the title 'Help'" do
	
		visit '/static_pages/help'
		expect( page ).to have_title("Ruby on Rails Tutorial Sample App | Help")
	
	end

  end

	describe "About page" do
	
		it "should have the content 'About Us'" do
		
			visit '/static_pages/about'
			
			expect( page ).to have_content('About Us')
		
		end
		
		it "shoud have the title 'About Us'" do
		
			visit '/static_pages/about'
			expect( page ).to have_title("Ruby on Rails Tutorial Sample App | About Us")
		
		end

	end


	describe "Content page" do
	
		it "should have the content 'Content'" do
		
			visit '/static_pages/content'
			
			expect( page ).to have_content('Content')
		
		end
		
		it "shoud have the title 'Content'" do
		
			visit '/static_pages/content'
			expect( page ).to have_title("Ruby on Rails Tutorial Sample App | Content")
		
		end

	end

end
