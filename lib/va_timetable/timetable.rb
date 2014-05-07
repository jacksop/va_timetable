require 'nokogiri'
require 'open-uri'

class Timetable
  attr_reader :club

  URL_CANDIDATES = %w(
    http://www.virginactive.co.uk/microsites/%{club}/timetable
    http://www.virginactive.co.uk/clubs/%{club}/timetables
    )
 
  def initialize(club)
    @club = club.to_s
  end

  def classes
    @workouts ||= fetch_classes
  end

  private

  def fetch_classes
    workouts = []
    page = Nokogiri::HTML(first_responsive_url)
    page.css('div[id^=timetable_]').each do |t|
      date = t.css('.date')[0].text.to_i
      t.css('table .classname').each do |c|
        name = c.text
        cells = c.parent.parent.css('td')
        start = compose_time(date, *cells[0].text.split(':'))
        finish = compose_time(date, *cells[1].text.split(':'))
        booking = cells[5].text != '-'
        workouts << Workout.new(club.capitalize, name, start, finish, booking)
      end
    end
    workouts
  end

  def first_responsive_url
    url_list = URL_CANDIDATES.map {|c| c % {club: club}}
    url_list.detect do |url|
      begin
        break open(url)
      rescue
        false
      end
    end
  end

  def compose_time(date, hour, min)
    current = Time.now
    year = current.year
    month = current.month
    day = current.day
    if date < day
      month += 1
      if month > 12
        year += 1
        month = 1
      end
    end
    Time.new(year, month, date, hour, min, 0)
  end

  Workout = Struct.new(:club, :name, :start, :finish, :booking_required)

end
