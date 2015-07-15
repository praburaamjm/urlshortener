

class UrlshortenerController < ApplicationController

	def getUniqueShortToken
		length = 6
		short = (36**(length-1) + rand(36**length - 36**(length-1))).to_s(36)
		return short
	end

	def shorten
		begin
			fullurl = params[:url]
			if !params[:url].start_with?('http://','https://') 
				fullurl = 'http://'+fullurl
			end
			short_url = Shorturl.where(fullurl: fullurl).take
			if short_url == nil
				short_url = Shorturl.new
				short_url.fullurl = fullurl
				hostname = 'http://'+request.host_with_port
				short_url.shorturl = hostname + '/' +getUniqueShortToken
				short_url.save
			end
		rescue ActiveRecord::RecordNotFound
		end
		render json:short_url
	end

	def expand
		shorturl = params[:shorturl]
		surlObj = Shorturl.where(shorturl: shorturl).take
		render json:surlObj
	end

	def forward
		shorturl = params[:shorturl]
		hostname = 'http://'+request.host_with_port
		fullShortUrl = hostname + '/' + shorturl
		surlObj = Shorturl.where(shorturl: fullShortUrl).take
		
		if surlObj.nil?
			redirect_to hostname
		else
			if surlObj.fullurl.start_with?('http://','https://')
				redirect_to surlObj.fullurl
			else
				redirect_to "http://"+surlObj.fullurl
			end
		end
	end

	def index
	end


end
