require File.dirname(__FILE__) + '/test_helper.rb'

context "The EC2 console " do
  
  setup do
    @ec2 = EC2::AWSAuthConnection.new('not a key', 'not a secret')
  end
  
  specify "should return info written to a specific instances console" do
  
    body = <<-RESPONSE
    <GetConsoleOutputResponse xmlns="http://ec2.amazonaws.com/doc/2007-01-19">
      <instanceId>i-28a64341</instanceId>
      <timestamp>2007-01-03 15:00:00</timestamp>
      <output>
        YyB2ZXJzaW9uIDQuMC4xIDIwMDUwNzI3IChSZWQgSGF0IDQuMC4xLTUpKSAjMSBTTVAgVGh1IE9j 
        dCAyNiAwODo0MToyNiBTQVNUIDIwMDYKQklPUy1wcm92aWRlZCBwaHlzaWNhbCBSQU0gbWFwOgpY 
        ZW46IDAwMDAwMDAwMDAwMDAwMDAgLSAwMDAwMDAwMDZhNDAwMDAwICh1c2FibGUpCjk4ME1CIEhJ 
        R0hNRU0gYXZhaWxhYmxlLgo3MjdNQiBMT1dNRU0gYXZhaWxhYmxlLgpOWCAoRXhlY3V0ZSBEaXNh 
        YmxlKSBwcm90ZWN0aW9uOiBhY3RpdmUKSVJRIGxvY2t1cCBkZXRlY3Rpb24gZGlzYWJsZWQKQnVp 
        bHQgMSB6b25lbGlzdHMKS2VybmVsIGNvbW1hbmQgbGluZTogcm9vdD0vZGV2L3NkYTEgcm8gNApF 
        bmFibGluZyBmYXN0IEZQVSBzYXZlIGFuZCByZXN0b3JlLi4uIGRvbmUuCg==
        </output>
    </GetConsoleOutputResponse>
    RESPONSE
    
    @ec2.stubs(:make_request).with('GetConsoleOutput', {"instanceId"=>"i-2ea64347"}).
       returns stub(:body => body, :is_a? => true)
    @ec2.get_console_output("i-2ea64347").should.be.an.instance_of EC2::GetConsoleOutputResponse
    response = @ec2.get_console_output("i-2ea64347")
  end
  
  specify "method get_console_output should raise an exception when called without nil/empty string arguments" do
    lambda { @ec2.get_console_output() }.should.raise(EC2::ArgumentError)
    lambda { @ec2.get_console_output("") }.should.raise(EC2::ArgumentError)
  end
  
end