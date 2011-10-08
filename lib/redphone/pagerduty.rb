require File.join(File.dirname(__FILE__), 'helpers')

module Redphone
  class Pagerduty
    def initialize(options={})
      raise "You must supply a service key" if options[:service_key].nil?
      @service_key = options[:service_key]
    end

    def incident_api(request_body)
      response = http_request(
        :method => "post",
        :ssl => true,
        :uri => "https://events.pagerduty.com/generic/2010-04-15/create_event.json",
        :body => request_body.merge({:service_key => @service_key}).to_json
      )
      response.body
    end

    def trigger_incident(options={})
      raise "You must supply a description" if options[:description].nil?
      request_body = options.merge!({:event_type => "trigger"})
      incident_api(request_body)
    end

    def resolve_incident(options={})
      raise "You must supply a incident key" if options[:incident_key].nil?
      request_body = options.merge!({:event_type => "resolve"})
      incident_api(request_body)
    end
  end
end