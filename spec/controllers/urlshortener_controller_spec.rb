require 'rails_helper'

describe UrlshortenerController do 
	describe "Shortening service" do
		it "should shorten url and expand them back" do
			test_url = "http://google.com"
			post :shorten, url: test_url
			shorturl = JSON.parse(response.body)["shorturl"]
			post :expand, shorturl: shorturl
			fullurl = JSON.parse(response.body)["fullurl"]
			fullurl.should eq(test_url)
		end


		it "should produce same shortening url for same fullurl" do
			test_url = "http://google.com"
			post :shorten, url: test_url
			shorturl_1 = JSON.parse(response.body)["shorturl"]
			post :shorten, url: test_url
			shorturl_2 = JSON.parse(response.body)["shorturl"]
			shorturl_1.should eq(shorturl_2)
		end
	end
end