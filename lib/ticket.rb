class Ticket
  def initialize(venue = 'venue')
    @venue = venue
    @date = date
  end

  def venue
    @venue
  end

  def date
    @date
  end

  def price=(amount)
    if(amount * 100).to_i == amount * 100
      @price = amount
    else
      puts 'price is malformed'
    end
  end

  def price
    @price
  end

  def discount=(percent)
    
    discount = @price * percent
    @price = @price - discount
  end

  def date=(string)
    string =~ /^\d{4}-\d{2}-\d{2}$/
    if string != 'yyyy-mm-dd'
      puts 'try again fawker'
    end
  end
end