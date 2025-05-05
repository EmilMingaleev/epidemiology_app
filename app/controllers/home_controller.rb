class HomeController < ApplicationController
  def index
    news = EpidemiologyNewsService.fetch_all_news
    @epidemiology_news = news[:epidemiology]
    @hiv_news = news[:hiv]
    @covid_news = news[:covid]
    @departments = Department.all
  end
end
