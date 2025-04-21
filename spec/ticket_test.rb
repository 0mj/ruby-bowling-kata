require 'minitest/autorun'
require_relative '../lib/ticket'

class TicketTest < MiniTest::Test

  def setup
    @ticket = Ticket.new
  end

  def test_ticket_exists
    assert_instance_of Ticket, @ticket
  end

  def test_default_ticket_values
    assert_equal 'venue', @ticket.venue
  end

  def test_price
    assert_equal 10.50, @ticket.price= 10.50
  end

  def test_discount
    @ticket.price= 100
    @ticket.discount= 0.15
    assert_equal 85.00, @ticket.price
  end

  def test_ticket_date_set
    @ticket.date= '2025-04-20'
  end


end