require 'spec_helper'

describe Timetable do
  let(:timetable) { Timetable.new('SomeClubName') }
  let(:microsite) { File.open(File.dirname(__FILE__) + '/support/aldersgate.html', 'rb').read }
  let(:clubsite) { File.open(File.dirname(__FILE__) + '/support/islington.html', 'rb').read }

  before(:each) do
    Time.stub(:now).and_return(Time.new(2014,05,06,10,30,40))
  end

  it "returns empty array when club not found" do
    timetable.stub(:open).and_raise(:SocketError)
    expect(timetable.classes).to be_empty
  end

  context "when club has a microsite" do
    before(:each) do
      timetable.stub(:open).and_return(microsite)
    end 

    it "returns correct number of class entries" do
      expect(timetable.classes.count).to eql(90)
    end

    it "has the correct club name for the first class" do
      expect(timetable.classes[0].club).to eql('Someclubname')
    end

    it "has the correct name for the first class" do
      expect(timetable.classes[0].name).to eql('Body Pump')
    end

    it "has the correct start time for the first class" do
      expect(timetable.classes[0].start.strftime('%Y%m%d%H%M%S')).to eql('20140527070000')
    end

    it "has the correct finish time for the first class" do
      expect(timetable.classes[0].finish.strftime('%Y%m%d%H%M%S')).to eql('20140527074500')
    end

    it "has the correct booking required status for the first class" do
      expect(timetable.classes[0].booking_required).to be_false
    end
  end

  context "when club does not have a microsite" do
    before(:each) do
      timetable.stub(:open).and_return(clubsite)
    end 

    it "returns correct number of class entries" do
      expect(timetable.classes.count).to eql(112)
    end

    it "has the correct club name for the first class" do
      expect(timetable.classes[2].club).to eql('Someclubname')
    end

    it "has the correct name for the third class" do
      expect(timetable.classes[2].name).to eql('Hatha Yoga')
    end

    it "has the correct start time for the third class" do
      expect(timetable.classes[2].start.strftime('%Y%m%d%H%M%S')).to eql('20140506070000')
    end

    it "has the correct finish time for the third class" do
      expect(timetable.classes[2].finish.strftime('%Y%m%d%H%M%S')).to eql('20140506080000')
    end

    it "has the correct booking required status for the third class" do
      expect(timetable.classes[2].booking_required).to be_true
    end
  end

  it "increments the month when dates span a month" do
    timetable.stub(:open).and_return(microsite)
    expect(timetable.classes[89].start.strftime('%Y%m%d%H%M%S')).to eql('20140602150500')
  end
end
