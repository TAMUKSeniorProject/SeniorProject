class CalendarController < ApplicationController
    def index
        @discussions = Discussion.all
    end
end