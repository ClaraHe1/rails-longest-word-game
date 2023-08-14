require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").map { |letter| letter }.sample(10)
  end

  def score
    @new = params[:new]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@new}"
    html_file = URI.open(url).read
    user = JSON.parse(html_file)
    @new_splitted = @new.chars.all? { |word| @letters.include?(word) }
    # raise
    if @new_splitted && user["found"] == true
      @score = "Congratulations! #{@new} is a valid Eglish word"
    elsif @new_splitted && user["found"] == false
      @score = "sory but #{@new} does not seem to be a valid Englis word..."
    else
      @score = "sory but #{@new} can't be built out of #{@letters}"
    end
  end
end
