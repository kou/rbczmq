# encoding: utf-8

require File.join(File.dirname(__FILE__), '..', 'helper')

class TestRepSocket < ZmqTestCase
  def test_behavior
    ctx = ZMQ::Context.new
    sock = ctx.socket(:REP)
    assert_equal ZMQ::REP, sock.type
    assert_equal "REP socket", sock.to_s
    assert_raises ZMQ::Error do
      sock.connect("inproc://test.rep-sock-behavior")
    end
  ensure
    ctx.destroy
  end

  def test_flow
    ctx = ZMQ::Context.new
    sock = ctx.socket(:REP)
    sock.bind("inproc://test.rep-sock-flow")
    assert_raises ZMQ::Error do
      sock.send_frame(ZMQ::Frame("frame"), ZMQ::Frame::MORE)
    end
  ensure
    ctx.destroy
  end
end