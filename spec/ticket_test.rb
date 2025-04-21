require 'minitest/autorun'
require_relative '../lib/ticket'

class TestTicket < MiniTest::Test

  def setup
    @ticket = Ticket.new
  end

  def test_ticket_exists
    assert_instance_of Ticket, @ticket
  end

end