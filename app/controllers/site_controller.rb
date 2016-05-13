class SiteController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def welcome
  end

  def admin_add_for_week
    @games = [[:away => "Florida",   :home => "Florida State",:spread => "+1", :dawg => "-1",:location => "Jacksonville, FL"],
              [:away => "Penn State",:home => "Ohio State",   :spread => "-15",:dawg => "+15",:location => "Columbus, OH"    ],
              [:away => "Kentucky",  :home => "Alabama",      :spread =>  "-23",:dawg => "+23",:location => "Missouri, MS"    ]]
  end

end
