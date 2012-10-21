#!/bin/env ruby
# encoding: utf-8
#
module PingCallback

  ActionController::Base.class_eval {
    def process(*)
      logger.debug 'Очистка Thread.current[:pinged] = false'
      Thread.current[:pinged] = false
      super
    end
  }

  def self.included(base)
    base.instance_eval{
      after_save :ping_callback
      after_destroy :ping_callback
    }

    def ping_callback
      logger.info "Текущее состояние Thread.current[:pinged] #{Thread.current[:pinged]}"
      if self.class == User 
        unless self.frozen?
          unless Thread.current[:pinged]
            Thread.current[:pinged] = true
            if self.ping
              self.ping.touch
            else
              self.create_ping
            end
          end
        end
      else
        if self.user 
          unless self.user.frozen?
            unless Thread.current[:pinged]
              Thread.current[:pinged] = true
              if self.user.ping
                self.user.ping.touch
              else
                self.user.create_ping
              end
            end
          end
        elsif self.car 
          unless self.car.frozen?
            unless Thread.current[:pinged]
              Thread.current[:pinged] = true
              if self.car.user.ping
                self.car.user.ping.touch
              else
                self.car.user.create_ping
              end
            end
          end
        end
      end
    end
  end
end
