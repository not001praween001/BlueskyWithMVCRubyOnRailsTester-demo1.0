#require 'net\http'
require 'json'

class BlueskyController < ApplicationController
  def get
    #################################################################################
    # Here! It is the simple code show how to test with Blue-sky following aspects: #
    #   1. Login to the platfrom with POST method.                                  #
    #   2. Using private api with GET method.                                       #
    #   3. Logout from the platfrom with POST method.                               #
    # @Author: Praween AMONTAMAVUT                                                  #
    #################################################################################

    # Identify your bluesky domain
    your_bluesky_domain = 'http://localhost:8189'
    # Identify your embedded device IP address
    your_local_ed_ip = '192.168.1.22'

    # Blue-sky Login sample
    login_uri = URI.parse(your_bluesky_domain + '/doLogin.ins')

    num = 0
    begin
       num = num + 1
       login_res = timeout(120) { Net::HTTP.post_form(login_uri, 'username' => 'guest', 'password' => 'guest', 'mode' => 'signin') }
       login_res_hash = JSON.parse(login_res.body)
       login_result = login_res_hash["ETLog"]["login"]["result"]
    end while num < 2 && login_result == "false"
    puts "Login result: " + login_result

    # Blue-sky set data example
    url = URI.parse(your_bluesky_domain + '/ETLog?instruction=sensornetwork&opt1=' + your_local_ed_ip + '&opt2=gpio&opt3=set&opt4=22&opt5=0')
    req = Net::HTTP::Get.new(url.to_s)
    res = timeout(120) { Net::HTTP.start(url.host, url.port) {|http|
      http.use_ssl = false
      http.request(req)
    }}
    set_result = res.body
    puts set_result

    # Blue-sky Logout sample
    logout_uri = URI.parse(your_bluesky_domain + '/doLogout.ins')
    num = 0
    begin
       num = num + 1
       logout_res = timeout(120) { Net::HTTP.post_form(logout_uri, 'username' => 'guest', 'mode' => 'signout') }
       logout_res_hash = JSON.parse(logout_res.body)
       logout_result = logout_res_hash["ETLog"]["logout"]["result"]
    end while num < 2 && logout_result == "false"
    puts "Logout result: " + logout_result
    render :text => "We has set the value 0 to gpio pin number 22 of the local embedded device(ED) IP '#{your_local_ed_ip}' of public domain #{your_bluesky_domain}. The operation result is '#{set_result}'"
  end
end
