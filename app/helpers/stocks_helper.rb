require 'date'
#require 'unicode'
require 'russian'

module StocksHelper
  def stock_now?(str_hours)
    return true if str_hours == 'всегда'

    # флаг
    stock_now = false

    # удаляем запятую, разделяющую два интервала
    str_hours.gsub! /(?<=[а-я])(,)/, ' '

    # заменяем "00:00" на "24:00"
    str_hours.gsub! /00:00/, '24:00'

    # режем на части
    hours_parts = str_hours.split(', ')

    # удаляем хвост, если есть
    hours_parts.delete_at -1 if str_hours.split(' ').count.odd?

    # для каждого интервала
    hours_parts.each do |part|

      # парсим интервал дней недели
      weekdays = part.split(' ').first
      # парсим временной интервал
      hours = part.split(' ').last

      # текущая дата
      now = DateTime.now

      # текущий день недели
      weekday_now = Russian::strftime(now, '%a')
      weekday_now = weekday_now.mb_chars.downcase.to_s

      # проверяем входит настоящее время в заданные интервалы
      if weekday_range_include?(weekdays, weekday_now) and
          hours_range_include?(hours, now.strftime('%R'))
        stock_now = true
      end

    end

    stock_now
  end


  #
  # входит ли день недели в интервал дней недели
  # например входит ли "пн" в "пн-пт" - да
  #
  def weekday_range_include?(range, weekday)
    # парсим левый и правый конец интвервала дней недели (пн-пт)
    weekday_left = range.split('-').first
    weekday_left = weekday_left.mb_chars.downcase.to_s

    weekday_right = range.split('-').last
    weekday_right = weekday_right.mb_chars.downcase.to_s

    # список дней недели
    all_weekdays = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс']

    weekday_left_index = all_weekdays.find_index(weekday_left)
    weekday_right_index = all_weekdays.find_index(weekday_right)

    # наш интервал
    our_interval = Array.new

    if (weekday_left_index > weekday_right_index)
      # если левый индекс больше правого
      # например "вс-чт"
      our_interval = all_weekdays.reverse.take(7 - weekday_left_index) +
          all_weekdays.take((7-(7 - weekday_left_index)-weekday_right_index-7).abs)

      puts our_interval
    else
      # нужный нам интервал
      our_interval = all_weekdays.slice(Range.new(weekday_left_index, weekday_right_index))
    end


    our_interval.include?(weekday)
  end


  #
  # входит ли данное время во вреенной интервал
  # например входит ли "23:00" в "12:00-18:00" - нет
  #
  def hours_range_include?(range, hour)
    # парсим левый и правый конец временного интервала (12:00-23:00)
    hour_left = DateTime.parse(range.split('-').first)
    hour_right = DateTime.parse(range.split('-').last)

    # парсим нужное нам время
    our_hour = DateTime.parse(hour)

    # если левое время больше правого
    if hour_left > hour_right
      hour_right = hour_right + 1
    end

    # если наше время входит в интервал, то все ок
    if hour_left <= our_hour and our_hour <= hour_right
      return true
    else
      return false
    end
  end
end
