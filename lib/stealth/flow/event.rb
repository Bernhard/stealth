# coding: utf-8
# frozen_string_literal: true

module Stealth
  module Flow
    class Event

      attr_accessor :name, :transitions_to, :meta, :action, :condition

      def initialize(name, transitions_to, condition = nil, meta = {}, &action)
        @name = name
        @transitions_to = transitions_to.to_sym
        @meta = meta
        @action = action
        @condition = if condition.nil? || condition.is_a?(Symbol) || condition.respond_to?(:call)
                       condition
                     else
                       raise TypeError, 'condition must be nil, an instance method name symbol or a callable (eg. a proc or lambda)'
                     end
      end

      def condition_applicable?(object)
        if condition
          if condition.is_a?(Symbol)
            object.send(condition)
          else
            condition.call(object)
          end
        else
          true
        end
      end

      def to_s
        @name.to_s
      end
    end
  end
end
