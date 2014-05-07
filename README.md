# VaTimetable

Parses the Virgin Active website for a club and returns an array of workout classes.

## Installation

Add this line to your application's Gemfile:

    gem 'va_timetable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install va_timetable

## Usage

To return an array of workouts, instantiate a `Timetable` by passing the club name, and them call the `classes` method.

    timetable = Timetable.new('broadgate')
    workout_classes = timetable.classes
 
Each of the returned workouts has the following attributes:

* club - the name of theVirgin Active club that was queried
* name - the nane of the workout class/activity
* start - the date and time the class/activity starts
* finish - the date anf time the class/activity finishes
* booking_required - does the class/activity need to be booked (true/false)

## Contributing

1. Fork it ( http://github.com/jacksop/va_timetable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
