require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @grid = @letters.strip.gsub(/\s,/, '')
    h = {}
    @message = 'not in grid'
    if @word.chars.all?(/[#{@grid}]/i)
      URI.open("https://wagon-dictionary.herokuapp.com/#{@word}") do |f|
        f.each_line { |line| h = JSON.parse(line) }
        @message =  if h.key?('error')
                      'not valid'
                    else
                      'valid'
                    end
      end
    else
      @message
    end
  end
end
