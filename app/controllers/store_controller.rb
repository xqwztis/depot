# -*- encoding: utf-8 -*-
class StoreController < ApplicationController
  def index
    @products = Product.all
    @time = Time.now
    update_visits_counter
  end
  
  def update_visits_counter
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
  end

  def session_counter_message
    {:message => 'index accessed %s', 
     :params => [[session[:counter], 'time']]} if session[:counter] > 5
  end

  helper_method :session_counter_message
end
