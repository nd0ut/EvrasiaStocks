require 'spec_helper'

describe StockHours do
  before :all do
    @stock_hours = StockHours.new
  end

  describe '#now?' do
    context 'пт-вс 23:00-05:00, пн-чт 23:00-02:00' do
      before :all do
        @stock_hours.hours = 'пт-вс 23:00-05:00, пн-чт 23:00-02:00'
      end

      it 'интервал пт-вс' do
        DateTime.stub!(:now).and_return(DateTime.parse('fri 22:30')) # пятница 22:30
        @stock_hours.now?.should be_false

        DateTime.stub!(:now).and_return(DateTime.parse('fri 23:30')) # пятница 23:30
        @stock_hours.now?.should be_true

        DateTime.stub!(:now).and_return(DateTime.parse('sat 03:30')) # суббота 03:30
        @stock_hours.now?.should be_true

        DateTime.stub!(:now).and_return(DateTime.parse('sat 06:30')) # суббота 06:30
        @stock_hours.now?.should be_false

        DateTime.stub!(:now).and_return(DateTime.parse('sun 23:30')) # воскресенье 23:30
        @stock_hours.now?.should be_true

        DateTime.stub!(:now).and_return(DateTime.parse('mon 03:30')) # понедельник 03:30
        @stock_hours.now?.should be_true

        DateTime.stub!(:now).and_return(DateTime.parse('mon 06:30')) # понедельник 06:30
        @stock_hours.now?.should be_false
      end

      it 'интвервал пн-чт' do
        DateTime.stub!(:now).and_return(DateTime.parse('mon 22:30')) # понедельник 22:30
        @stock_hours.now?.should be_false

        DateTime.stub!(:now).and_return(DateTime.parse('mon 23:30')) # понедельник 23:30
        @stock_hours.now?.should be_true

        DateTime.stub!(:now).and_return(DateTime.parse('tue 01:30')) # вторник 01:30
        @stock_hours.now?.should be_true

        DateTime.stub!(:now).and_return(DateTime.parse('tue 03:30')) # вторник 03:30
        @stock_hours.now?.should be_false

        DateTime.stub!(:now).and_return(DateTime.parse('thu 23:30')) # четверг 23:30
        @stock_hours.now?.should be_true

        DateTime.stub!(:now).and_return(DateTime.parse('fri 01:30')) # пятница 01:30
        @stock_hours.now?.should be_true

        DateTime.stub!(:now).and_return(DateTime.parse('fri 03:30')) # пятница 03:30
        @stock_hours.now?.should be_false
      end
    end
  end
end
