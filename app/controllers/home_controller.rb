class HomeController < ApplicationController
  def index
    @epidemiology_news = EpidemiologyNewsService.fetch_epidemiology_news
    @hiv_news = EpidemiologyNewsService.fetch_hiv_news
    @covid_news = EpidemiologyNewsService.fetch_covid_news
    @departments = Department.all
  end
end
