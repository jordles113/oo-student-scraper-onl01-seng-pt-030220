require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

    def self.scrape_index_page(index_url)

      doc = Nokogiri::HTML(open(index_url))
      student_page = doc.css(".student-card a")
      students = []
  
      student_page.each do |student|
        students << {
          name: student.css(".card-text-container h4").text,
          location: student.css(".card-text-container p").text,
          profile_url: student.attr('href')
        }
      end
      students
  end	  

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
    student = {}

    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".description-holder p").text


    social_media = doc.css(".social-icon-container a")
    social_media.each do |social_type|
      link = social_type.attr('href')
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student
  end 
end 
 